### usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| password           | string | null: false |
| sur_name           | string | null: false |
| first_name         | string | null: false |
| sur_name_reading   | string | null: false |
| first_name_reading | string | null: false |
| birthday           | date   | null: false |

### Association
-has_many :items
-has_many :purchases



## itemsテーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| item_name         | string     | null: false                    |
| description       | text       | null: false                    |
| category          | integer    | null: false                    |
| condition         | integer    | null: false                    |
| postage_payer     | integer    | null: false                    |
| prefecture        | integer    | null: false                    |
| transport_days    | integer    | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association
-belongs_to :user
-has_one :purchase
-belongs_to_active_hash :category
-belongs_to_active_hash :condition
-belongs_to_active_hash :postage_payer
-belongs_to_active_hash :prefecture
-belongs_to_active_hash :transport_days



## purchasesテーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| card_number       | integer    | null: false                    |
| exp_month         | integer    | null: false                    |
| exp_year          | integer    | null: false                    |
| security_code     | integer    | null: false                    |
| postal_number     | integer    | null: false                    |
| prefecture        | integer    | null: false                    |
| city              | string     | null: false                    |
| house_number      | string     | null: false                    |
| building_name     | string     |                                |
| phone_number      | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association
-belongs_to :user
-belongs_to :item
-belongs_to_active_hash :prefecture