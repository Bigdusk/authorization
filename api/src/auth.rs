use axum::{
    extract::Request,
    http::{self, StatusCode},
    middleware::Next,
    response::Response,
};

use crate::utils::{database, jwt};

#[derive(Clone, Debug)]
pub struct CurrentUser {
    pub user_id: i64,
    pub username: String,
    pub password: String,
    pub permissions: i32,
}

pub async fn login_auth(mut req: Request, next: Next) -> Result<Response, StatusCode> {
    //判断是否属于放行路径
    let url = req.uri().path();
    for allow_path in allow_path_all() {
        if url.starts_with(allow_path) {
            return Ok(next.run(req).await)
        }
    }

    //获取请求头携带token
    let auth_header = req
        .headers()
        .get(http::header::AUTHORIZATION)
        .and_then(|header| header.to_str().ok());

    //判断判断是否携带
    let auth_header = if let Some(auth_header) = auth_header {
        auth_header
    } else {
        return Err(StatusCode::UNAUTHORIZED);
    };

    //获取用户数据并共享到处理器
    if let Some(current_user) = authorize_current_user(auth_header).await {
        // insert the current user into a request extension so the handler can
        // extract it
        req.extensions_mut().insert(current_user);
        Ok(next.run(req).await)
    } else {
        Err(StatusCode::UNAUTHORIZED)
    }
}

async fn authorize_current_user(auth_token: &str) -> Option<CurrentUser> {
    let db = database::new_conn().await;
    let user_info = jwt::get_user_info(auth_token, &db).await;

    match user_info {
        Ok(r) => Some(CurrentUser {
            user_id: r.user_id,
            username: r.username,
            password: r.password,
            permissions: r.permissions,
        }),
        Err(_) => None,
    }
}

///允许访问路径
fn allow_path_all() -> Vec<&'static str> {
    vec![
        "/login",
        "/computer/auth",
        "/computer/info",
        "/card_key/redeem",
        "/notice/query/all"
    ]
}