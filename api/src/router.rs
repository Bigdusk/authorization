use std::time::Duration;

use axum::{http::Method, routing::get, Router};
use tower::ServiceBuilder;
use tower_http::{compression::CompressionLayer, cors::{Any, CorsLayer}, timeout::TimeoutLayer, trace::TraceLayer};

use crate::utils::database;

pub async  fn app() -> Router<()>{
    let db = database::new_conn().await;
    let app = Router::new()
    .route("/", get(hi))
    .with_state(db)
    .layer(
        // 官方推荐在ServiceBuilder上一次性载入
        ServiceBuilder::new()
            .layer(TraceLayer::new_for_http())
            .layer(CompressionLayer::new())
            // 超时时间是1s200ms
            .layer(TimeoutLayer::new(Duration::new(3, 200000)))
            // 默认情况下不放行，所以需要根据自己需求设置必要的允许规则。
            .layer(
                CorsLayer::permissive()
                    .allow_methods([
                        Method::GET,
                        Method::POST,
                        Method::DELETE,
                        Method::PUT,
                        Method::OPTIONS
                    ])
                    .allow_origin(Any)
            )

    );

    app
}

async fn hi() -> &'static str{
    "hello world"
}