use std::time::Duration;

use axum::{http::Method, middleware, routing::{get, post}, Router};
use tower::ServiceBuilder;
use tower_http::{compression::CompressionLayer, cors::{Any, CorsLayer}, timeout::TimeoutLayer, trace::TraceLayer};

use crate::{auth::login_auth, controller::{card_key::{card_key_query_all, card_keys_insert}, computer::{computer_auth, computer_info, redeem_card_key}, login::login, notice::{notice_create, notice_delete, notice_query_all}}, utils::database};

pub async  fn app() -> Router<()>{
    let db = database::new_conn().await;
    let app = Router::new()
    .route("/", get(hi))
    .route("/login", post(login))
    .route("/card_keys/insert", post(card_keys_insert))
    .route("/card_key/query/all", get(card_key_query_all))

    .route("/notice/create", post(notice_create))
    .route("/notice/query/all", get(notice_query_all))
    .route("/notice/delete/:id", get(notice_delete))

    .route("/computer/auth", post(computer_auth))
    .route("/computer/info", post(computer_info))
    .route("/card_key/redeem", post(redeem_card_key))

    .route_layer(middleware::from_fn(login_auth))
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