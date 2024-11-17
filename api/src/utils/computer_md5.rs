use chrono::Local;
use md5::{Digest, Md5};

///时间+内容＋话语
pub fn md5_build(value: &str) -> String {
    let mut hasher = Md5::new();
    let secret = Local::now().format("%Y%m%d").to_string();
    let say = "你好入侵者，如果你看见这个请联系QQ:2831828656".to_string();
    hasher.update(format!("{}{}{}", secret, value, say));

    let result = hasher.finalize();

    let hex_result = format!("{:x}", result);

    hex_result
}