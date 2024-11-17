use chrono::Local;
use config::APP_CONFIG;
use md5::{Digest, Md5};
use ring::{rand::SystemRandom, signature::{self, Ed25519KeyPair, KeyPair}};

pub mod auth;
pub mod config;
pub mod controller;
pub mod entity;
pub mod router;
pub mod utils;


#[test]
fn t() {
        // 1. 生成密钥对
        let rng = SystemRandom::new();
        let pkcs8_bytes = Ed25519KeyPair::generate_pkcs8(&rng).expect("生成密钥对失败");
        let key_pair = Ed25519KeyPair::from_pkcs8(pkcs8_bytes.as_ref()).expect("创建密钥对失败");
    
        // 提取公钥和私钥
        let public_key = key_pair.public_key().as_ref();
        println!("公钥: {:?}", public_key);
    
        // 2. 数据签名
        let message = b"Hello, this is a test message.";
        let signature = key_pair.sign(message);
        println!("签名: {:?}", signature.as_ref());
    
        // 3. 签名验证
        let is_valid = signature::UnparsedPublicKey::new(&signature::ED25519, public_key)
            .verify(message, signature.as_ref())
            .is_ok();
        if is_valid {
            println!("签名验证成功！");
        } else {
            println!("签名验证失败！");
        }
}
