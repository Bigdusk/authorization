use md5::{Digest, Md5};

use crate::config::APP_CONFIG;

///与jwt共用加密盐
pub fn md5_build(value: &str) -> String {
    let mut hasher = Md5::new();

    hasher.update(format!("{}{}", value,APP_CONFIG.jwt_secret.clone()));

    let result = hasher.finalize();

    let hex_result = format!("{:x}", result);

    hex_result
}
