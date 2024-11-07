use lazy_static::lazy_static;
use serde::{Deserialize, Serialize};

///应用默认配置
#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct Config {
    pub app_name: String,
    pub jwt_secret: String,
    pub port: u32,
    pub db_url: String,
}
//初始化配置
lazy_static! {
    pub static ref APP_CONFIG: Config = {
        let app_name = dotenv::var("APP_NAME")
        .expect("读取配置文件失败");

        let jwt_secret = dotenv::var("JWT_SECRET")
        .expect("读取配置文件失败");

        let port = dotenv::var("PORT")
        .expect("读取配置文件失败");

        let port = port.parse::<u32>()
        .expect("读取配置文件失败");
    
        let db_url = dotenv::var("DATABASE_URL")
        .expect("读取配置文件失败");

    let c = Config { app_name, jwt_secret, port, db_url };

    c
    };
}
