use config::APP_CONFIG;
use md5::{Digest, Md5};

pub mod auth;
pub mod config;
pub mod controller;
pub mod entity;
pub mod router;
pub mod utils;

///卡密生成
#[test]
fn t() {
    // create a Md5 hasher instance
    let mut hasher = Md5::new();

    // process input message
    hasher.update(format!("{}{}", "qq2831828656",APP_CONFIG.jwt_secret.clone()));

    // acquire hash digest in the form of GenericArray,
    // which in this case is equivalent to [u8; 16]
    let result = hasher.finalize();

    let hex_result = format!("{:x}", result);

    println!("{}", hex_result)

}
