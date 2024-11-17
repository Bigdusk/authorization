use axum::extract::State;
use axum::{Extension, Json};
use chrono::Local;
use rand::{thread_rng, Rng};
use sea_orm::{EntityTrait, Set};
use sea_orm::{ActiveValue::NotSet, DatabaseConnection};
use serde::{Deserialize, Serialize};
use serde_json::Value;

use crate::auth::CurrentUser;
use crate::entity::card_keys;
use crate::utils::result::ResultUtils;

#[derive(Serialize, Deserialize)]
pub struct CardKeyInfo {
    pub name: String,
    pub day: String,
    pub num: usize,
}
///生成卡密
pub async fn card_keys_insert(
    Extension(current_user): Extension<CurrentUser>,
    State(db): State<DatabaseConnection>,
    Json(card_keys_info): Json<CardKeyInfo>,
) -> Json<Value>{
    println!("{:#?}", current_user);
    let get_card_key = || {
        let chars = String::from("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789");

        let mut card_key = String::new();
    
        let mut rng = thread_rng();
    
        for _ in 0..=61 {
            let random_int = rng.gen_range(0..=61);
            card_key.push_str(&chars[random_int..random_int + 1]);
        }
    
        card_key
    };

    //存储所有卡密
    let mut card_arry: Vec<_> = vec![];
    //界面返回结果
    let mut r = vec![];
    for _ in 0..card_keys_info.num {
        let key = get_card_key();
        let card_key = card_keys::ActiveModel {
            key_id: NotSet,
            card_key: Set(key.clone()),
            r#type: Set(card_keys_info.name.clone()),
            value: Set(Some(card_keys_info.day.clone())),
            created_at: Set(Some(Local::now().naive_local())),
            activated_at: Set(None),
            expires_at: Set(None),
            is_active: Set(Some(0)), //0false，1true
            authorization_id: Set(None),
        };

        card_arry.push(card_key);
        r.push(key);
    }

    //批量写入
    let res = card_keys::Entity::insert_many(card_arry).exec(&db).await;

    match res {
        Ok(_) => {
            ResultUtils::success(Some(r))
        },
        Err(r) => ResultUtils::<String>::error(r.to_string()),
    }
}

///查询所有卡密
pub async fn card_key_query_all(
    State(db): State<DatabaseConnection>,
) -> Json<Value>
{
    let card_keys_all = card_keys::Entity::find().all(&db).await;
    match card_keys_all {
        Ok(r) => ResultUtils::success(Some(r)),
        Err(r) => ResultUtils::<String>::error(r.to_string()),
    }
}