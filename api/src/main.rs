use api::{config::APP_CONFIG, router};

#[tokio::main]
async fn main() {
    let listener = tokio::net::TcpListener::bind(format!("0.0.0.0:{}", APP_CONFIG.port.clone())).await.unwrap();
    let router = router::app().await;
    axum::serve(listener, router).await.unwrap();
}
