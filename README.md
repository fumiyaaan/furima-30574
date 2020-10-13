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
| category_id       | integer    | null: false                    |
| condition_id      | integer    | null: false                    |
| postage_payer_id  | integer    | null: false                    |
| prefecture_id     | integer    | null: false                    |
| transport_days_id | integer    | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association
-belongs_to :user
-has_one :purchase
-belongs_to_active_hash :category_id
-belongs_to_active_hash :condition_id
-belongs_to_active_hash :postage_payer_id
-belongs_to_active_hash :prefecture_id
-belongs_to_active_hash :transport_days_id



## purchasesテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |


### Association
-belongs_to :user
-belongs_to :item
-has_one :address



## Addressesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| card_number   | integer    | null: false                    |
| exp_month     | integer    | null: false                    |
| exp_year      | integer    | null: false                    |
| security_code | integer    | null: false                    |
| postal_number | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | integer    | null: false                    |
| purchase      | references | null: false, foreign_key: true |

### Association
-belongs_to :purchase
-belongs_to_active_hash :prefecture_id