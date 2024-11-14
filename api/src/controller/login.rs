use axum::{extract::State, Json};
use sea_orm::{ColumnTrait, Condition, DatabaseConnection, EntityTrait, QueryFilter};
use serde_json::Value;

use crate::{entity::users, utils::{jwt, md5::md5_build, result::ResultUtils}};

pub async fn login(
    State(db): State<DatabaseConnection>,
    Json(users): Json<users::Model>,
) -> Json<Value>{
    //查询数据库是否存在该用户
    let r = users::Entity::find()
    .filter(
        Condition::all()
        .add(users::Column::Username.eq(users.username))
        .add(users::Column::Password.eq(md5_build(users.password.as_str())))
    )
    .one(&db)
    .await;

    let r = match r {
        Ok(r) => {
            r
        }
        Err(_r) => {
            return ResultUtils::<&str>::error("登录失败".into());
        }
    };

    match r {
        None => {
            ResultUtils::<&str>::error("登录失败".into())
        }
        Some(r) => {
            //创建token
            let token = jwt::create_token(r.user_id);
            match token {
                Ok(r) => { ResultUtils::success(Some(r)) }
                Err(r) => { ResultUtils::<&str>::error(r.to_string()) }
            }
        }
    }
}