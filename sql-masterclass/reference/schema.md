# Signal Store schema

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : places
    ORDERS ||--|{ ORDER_ITEMS : contains
    PRODUCTS ||--o{ ORDER_ITEMS : appears_in

    CUSTOMERS {
        integer customer_id PK
        text customer_name
        text email
        text country
        date signup_date
        text customer_segment
        text marketing_channel
    }

    ORDERS {
        integer order_id PK
        integer customer_id FK
        date order_date
        text order_status
        text sales_channel
        numeric order_total
    }

    ORDER_ITEMS {
        integer order_item_id PK
        integer order_id FK
        integer product_id FK
        integer quantity
        numeric unit_price
    }

    PRODUCTS {
        integer product_id PK
        text product_name
        text category
        numeric list_price
    }
```

## Grain

| Table | One row represents |
|---|---|
| `customers` | One registered customer |
| `orders` | One order placed by one customer |
| `order_items` | One product line within one order |
| `products` | One sellable product |

`orders.order_total` is stored so part one can query a single table. The seed
script calculates it from `order_items`, and the validation script proves the two
totals match.
