//! `SeaORM` Entity, @generated by sea-orm-codegen 1.1.0

use sea_orm::entity::prelude::*;
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Eq, Deserialize, Serialize)]
#[sea_orm(table_name = "computer_authorizations")]
pub struct Model {
    #[sea_orm(primary_key)]
    pub authorization_id: i64,
    #[sea_orm(unique)]
    pub computer_id: String,
    pub expires_at: Option<DateTime>,
    pub is_active: Option<i8>,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
