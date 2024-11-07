use std::time::Duration;

use sea_orm::{ConnectOptions, Database, DatabaseConnection};

use crate::config::APP_CONFIG;

///创建数据库连接
pub async fn new_conn() -> DatabaseConnection{
    //生成实体
    //sea-orm-cli generate entity -u mysql://authorization:p7ytXb7k6mh5Bc4A@140.143.142.199:3306/authorization -o entity/src
    let mut opt = ConnectOptions::new(APP_CONFIG.db_url.clone());

    opt.max_connections(100)
    .min_connections(5)
    .connect_timeout(Duration::from_secs(8))
    .acquire_timeout(Duration::from_secs(8))
    .idle_timeout(Duration::from_secs(8))
    .max_lifetime(Duration::from_secs(8))
    .sqlx_logging(false)
    .sqlx_logging_level(log::LevelFilter::Info)
    .set_schema_search_path("my_schema");

    let db = Database::connect(opt).await.expect("连接数据库失败");

    db
}