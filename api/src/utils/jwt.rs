use std::ops::Add;
use axum::http::HeaderMap;
use chrono::Local;
use serde::{Deserialize, Serialize};
use jsonwebtoken::{encode, Algorithm, Header, EncodingKey, Validation, decode, DecodingKey, TokenData};
use sea_orm::{DatabaseConnection, EntityTrait};
use crate::{config::APP_CONFIG, entity::users};

#[derive(Debug, Serialize, Deserialize)]
pub struct Claims {
    sub: String,
    company: String,
    exp: i64,
    user_id: i64
}

impl Claims {
    fn new(sub: String,
           company: String,
           exp: i64,
           user_id: i64
    ) -> Self{
        Self {sub, company, exp, user_id}
    }
    ///获取存放的用户id
    pub fn get_user_id(self) -> i64{
        self.user_id
    }
}

///根据用户id生成token
pub fn create_token(user_id: i64) -> Result<String, Box<dyn std::error::Error>>{
    //获取过期时间
    let exp_time = Local::now()
        .add(chrono::Duration::try_hours(2).expect("时间转换错误"))
        .timestamp();
    let claims = Claims::new("admin@hhzx.top".to_string(), "hhzx.top".to_string(), exp_time, user_id);
    let header = Header::default();
    let key = &EncodingKey::from_secret(APP_CONFIG.jwt_secret.clone().as_bytes());
    let token = encode(&header, &claims, key);
    match token {
        Ok(v) => {Ok(v)}
        Err(_) => {Err(Box::from("创建token失败"))}
    }
}

pub fn decode_token(token: &str) -> jsonwebtoken::errors::Result<TokenData<Claims>> {
    let key = &DecodingKey::from_secret(APP_CONFIG.jwt_secret.clone().as_bytes());
    let validation = &Validation::new(Algorithm::HS256);
    let token_message = decode::<Claims>(token, key, validation);

    token_message
}

///根据请求头获取用户信息
pub async  fn get_user_info(
    token: &str,
    db: &DatabaseConnection
) -> Result<users::Model, Box<dyn std::error::Error>>
{

    let jwt_data = decode_token(token)?;
    let user_id = jwt_data.claims.get_user_id();

    let r = users::Entity::find_by_id(user_id).one(db).await?;

    match r {
        None => {
            Err(Box::from("没有该用户"))
        }
        Some(r) => {
            Ok(r)
        }
    }
}