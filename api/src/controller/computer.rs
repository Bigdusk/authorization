
use axum::{extract::State, Json};
use chrono::{Days, Local};
use sea_orm::{ActiveModelTrait, ActiveValue::NotSet, ColumnTrait, Condition, DatabaseConnection, EntityTrait, IntoActiveModel, QueryFilter, Set, TransactionTrait};
use serde::{Deserialize, Serialize};
use serde_json::Value;

use crate::{entity::{card_keys, computer_authorizations}, utils::{computer_md5, result::ResultUtils}};

///设备访问授权或者注册
pub async fn computer_auth(
    State(db): State<DatabaseConnection>,
    Json(computer): Json<computer_authorizations::Model>
) -> Json<Value>{
    //先判断是否注册授权
    let is_auth = computer_authorizations::Entity::find()
    .filter(
        Condition::all()
        .add(
            computer_authorizations::Column::ComputerId.eq(computer.clone().computer_id)
        )
    )
    .one(&db)
    .await;

    match is_auth {
        Ok(r) => {
            match r {
                Some(r) => {
                    //存在记录设备
                    
                    //判断是否允许使用
                    if r.is_active == Some(0) {
                        return ResultUtils::<String>::error("设备已被禁用，请联系管理员".into());
                    }

                    //计算是否过期
                    match r.expires_at {
                        Some(expires_time) => {
                            //判断是否过期
                            if Local::now().naive_local() < expires_time {
                                //返回加密信息：当前时间+游览器指纹+验证信息0代表false，1代表true
                                return ResultUtils::success(Some(computer_md5::md5_build("0")));
                            } else {
                                return ResultUtils::success(Some(computer_md5::md5_build("1")));
                            }
                        },
                        None => {
                            //该设备还没有激活
                            return ResultUtils::<String>::error("该设备还没有激活".into());
                        },
                    }

                },
                None => {
                    //不存在记录设备
                    //进行记录
                    let mut r = computer.into_active_model();
                    r.authorization_id = NotSet;
                    r.expires_at = Set(Local::now().naive_local().checked_sub_days(Days::new(1)));
                    
                    let r = r.insert(&db).await;

                    match r {
                        Ok(_) => {
                            return ResultUtils::<String>::error("设备注册成功".into());
                        },
                        Err(_) => {
                            return ResultUtils::<String>::error(    "设备注册失败".into());
                        },
                    }
                },
            }
        },
        Err(_) => {
            return ResultUtils::<String>::error("验证失败".into());
        },
    }
}

pub async fn computer_info(
    State(db): State<DatabaseConnection>,
    Json(computer): Json<computer_authorizations::Model>
) -> Json<Value>{
    let computer = computer_authorizations::Entity::find()
    .filter(
        Condition::all()
        .add(
            computer_authorizations::Column::ComputerId.eq(computer.computer_id)
        )
    )
    .one(&db)
    .await;

    let r = match computer {
        Ok(r) => r,
        Err(_) => {return ResultUtils::<String>::error("验证失败".into());},
    };

    match r {
        Some(r) => ResultUtils::success(Some(r)),
        None => ResultUtils::<String>::error("获取信息失败".into()),
    }
}





#[derive(Deserialize, Serialize)]
pub struct ComputerInfo {
    pub computer_id: String,
    pub card_key: String
}
///用于对设备增加时间
pub async fn redeem_card_key(
    State(db): State<DatabaseConnection>,
    Json(computer_info): Json<ComputerInfo>
) -> Json<Value>{
    //先查电脑数据
    let current_computer = computer_authorizations::Entity::find()
    .filter(
        Condition::all()
        .add(
            computer_authorizations::Column::ComputerId.eq(computer_info.computer_id)
        )
    )
    .one(&db)
    .await;

    let current_computer = match current_computer {
        Ok(r) => r,
        Err(_) => {
            return ResultUtils::<String>::error("查询设备错误".into());
        },
    };

    let current_computer = match current_computer {
        Some(r) => r,
        None => {
            return ResultUtils::<String>::error("设备验证错误".into());
        },
    };

    //再查卡密数据
    let current_card_key = card_keys::Entity::find()
    .filter(
        Condition::all()
        .add(
            card_keys::Column::CardKey.eq(computer_info.card_key)
        )
    )
    .one(&db)
    .await;

    let current_card_key = match current_card_key {
        Ok(r) => r,
        Err(_) => {
            return ResultUtils::<String>::error("查询兑换码错误".into());
        }
    };

    let current_card_key = match current_card_key {
        Some(r) => {
            if r.is_active == Some(0) {
                r
            }else {
                return ResultUtils::<String>::error("兑换码已经使用".into()); 
            }
        },
        None => {
            return ResultUtils::<String>::error("兑换码不存在".into());
        },
    };
    //最后更新

    //事务
    let txn = match db.begin().await {
        Ok(r) => r,
        Err(_) => return ResultUtils::<String>::error("事务出错".into()),
    };

    //改变天数,在已经有的天数上增加
    let day = current_card_key.value.clone();
    let day = match day {
        Some(r) => {
            match r.parse::<u64>() {
                Ok(r) => r,
                Err(_) => {
                    return ResultUtils::<String>::error("兑换码错误".into());
                },
            }
        },
        None => {
            return ResultUtils::<String>::error("兑换码错误".into());
        },
    };

    let mut new_computer = current_computer.clone().into_active_model();

    //判断当前时间是否已经授权，如果在使用期限范围内则直接添加时间
    if current_computer.expires_at.unwrap() > Local::now().naive_local() {
        let temp_time = current_computer.expires_at.clone().unwrap();
        new_computer.expires_at = Set(temp_time.checked_add_days(Days::new(day)));
    }else {
        new_computer.expires_at = Set(Local::now().naive_local().checked_add_days(Days::new(day)));
    }

    let _ = new_computer.update(&txn).await;

    //改变卡密状态
    let mut new_card_key = current_card_key.into_active_model();
    new_card_key.is_active = Set(Some(1));
    new_card_key.authorization_id = Set(Some(current_computer.authorization_id));

    let _ = new_card_key.update(&txn).await;


    let r= txn.commit().await;

    match r {
        Ok(_) => ResultUtils::success(Some("操作成功")),
        Err(r) => ResultUtils::<String>::error(r.to_string()),
    }
}