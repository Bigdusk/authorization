use axum::Json;
use serde::Serialize;
use serde_json::{json, Value};

#[derive(Serialize)]
pub struct ResultUtils<DATA> {
    pub code: u32,
    pub message: String,
    pub data: Option<DATA>,
}

impl<DATA> ResultUtils<DATA>
where
    DATA: Serialize,
{
    pub fn success(data: Option<DATA>) -> Json<Value> {
        Json(json!(Self {
            code: 200,
            message: String::from("请求成功"),
            data
        }))
    }

    pub fn error(message: String) -> Json<Value> {
        Json(json!(Self {
            code: 500,
            message,
            data: None
        }))
    }

    pub fn build(code: u32, message: String, data: Option<DATA>) -> Json<Value> {
        Json(json!(Self {
            code,
            message,
            data
        }))
    }
}
