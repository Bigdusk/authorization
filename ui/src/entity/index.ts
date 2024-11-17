export interface Users {
    user_id: number,
    username: string,
    password: string,
    permissions: number
}

export interface CardKeys {
    key_id?: number
    card_key?: string
    type?: string
    value?: string
    created_at?: number
    activated_at?: number
    expires_at?: number
    is_active?: boolean | string | number
    authorization_id?: string
}

export interface Announcement {
    announcement_id: number
    title: string
    content: string
    published_by: number
    publish_date: string
    expiration_date: string
    is_active: number
}

export interface CardKeyInfo {
    name: string
    day: string
    num: number
}

export interface Notice {
    announcement_id: number
    title: string
    content: string
    user_id: number
    publish_date: string | null
    expiration_date: string | null
    is_active: number
}




// pub announcement_id: i32,
// pub title: String,
// #[sea_orm(column_type = "Text")]
// pub content: String,
// pub published_by: i32,
// pub publish_date: Option<DateTimeUtc>,
// pub expiration_date: Option<DateTimeUtc>,
// pub is_active: Option<i8>,