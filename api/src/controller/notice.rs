use axum::{extract::{Path, State}, Json};
use chrono::Local;
use sea_orm::{ActiveModelTrait, ActiveValue::NotSet, DatabaseConnection, EntityTrait, IntoActiveModel, Set};
use serde_json::Value;

use crate::{entity::announcements, utils::result::ResultUtils};

pub async fn notice_create(
    State(db): State<DatabaseConnection>,
    Json(announcement): Json<announcements::Model>,
) -> Json<Value>{
    //创建公告
    let mut notice = announcement.into_active_model();
    notice.announcement_id = NotSet;
    notice.user_id = Set(1);
    notice.publish_date = Set(Some(Local::now().naive_local()));
    notice.expiration_date = Set(Some(Local::now().naive_local()));
    notice.is_active = Set(Some(1));

    let r = notice.insert(&db).await;

    match r {
        Ok(r) => ResultUtils::success(Some(r)),
        Err(r) => ResultUtils::<String>::error(r.to_string()),
    }
}

pub async fn notice_query_all(
    State(db): State<DatabaseConnection>,
) -> Json<Value>{
    let r = announcements::Entity::find().all(&db).await;
    match r {
        Ok(r) => ResultUtils::success(Some(r)),
        Err(r) => ResultUtils::<String>::error(r.to_string()),
    }
}

pub async fn notice_delete(
    State(db): State<DatabaseConnection>,
    Path(id): Path<i64>
) -> Json<Value>{
    let r = announcements::Entity::delete_by_id(id).exec(&db).await;

    match r {
        Ok(_) => ResultUtils::success(Some(true)),
        Err(r) => ResultUtils::<String>::error(r.to_string()),
    }
}