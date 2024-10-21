# Part 1. Models

### Question: What is our user repeat rate?

**Answer:** 80%

**Query:**  
```sql
WITH orders_chort AS (
    SELECT 
        user_id,
        COUNT(DISTINCT order_id) AS user_orders
    FROM {{ ref('stg_orders') }}
    GROUP BY 1 
), 
users_buckets AS (
    SELECT 
        user_id,
        IFF(user_orders >= 2, 1, 0) AS has_two_plus_purchases
    FROM orders_chort
) 
SELECT 
    SUM(has_two_plus_purchases) AS two_plus_purchases,
    COUNT(DISTINCT user_id) AS num_users_w_purchases,
    DIV0(two_plus_purchases, num_users_w_purchases) AS repeat_rate 
FROM users_buckets
```

---

### b. What are Good Indicators of a User Likely to Purchase Again?

#### Likely Repeat Purchasers:
- **High Frequency of Purchases**: Users who purchase more frequently tend to buy again.
- **High Order Values**: Customers with larger purchases show higher commitment.
- **Engagement Metrics**: Users who frequently interact with promotions or loyalty programs.
- **Recent Purchases**: Users who have bought recently are more likely to return.

#### Likely Non-Repeat Purchasers:
- **Long Time Since Last Purchase**: Users who haven't bought anything in a while.
- **Low Engagement**: Minimal interaction with product pages or content.
- **Low Purchase Values**: Customers with smaller purchases might be less committed.

If more data were available, additional features to explore would include demographic information (age, location, income), behavioral data (clickstream, cart abandonment), and customer support interactions.

---

### Part 2: Organizing Marts for Business Insights

#### Product Mart
In the product mart, we focus on product performance metrics, page views, and user behavior. Key model is:

- **fct_product_performance**: Tracks all page view, add-to-cart and other information on indivivual products to help understand how much traffic each product receives.

#### Marketing Mart
The marketing mart helps analyze user engagement and purchase trends. Key model is:

- **fct_user_engagement**: Contains order-level data at the user level, allowing for customer segmentation and retention analysis.

#### Core Mart
The core mart provides a high-level overview of business performance, combining data from users, products, and orders. Key model is:

- **fct_order_summary**: Summarizes key order metrics such as total spend, product count,shipping status, address and user information.

---

### Part 3: Testing and Snapshots

To ensure data accuracy, I implemented tests such as `not_null` and `unique` for key columns in our models. These tests help verify assumptions about the data, that IDs are unique.

I also used dbt snapshots to track changes in the product inventory over time. The `product_snapshot` model helps to see inventory changes and how they evolve from week to week.

#### Question: Which products had their inventory change from week 1 to week 2?

**Answer:**  
- **Monstera** went from 77 to 64  
- **Philodendron** went from 51 to 25  
- **Pothos** went from 40 to 20  
- **String of pearls** went from 58 to 10  

---

### Part 4: Final Thoughts

By organizing data into Product, Marketing, and Core marts, we can enable different business units to derive insights relevant to their needs. This structured approach allows Greenery to better understand user behavior, product performance, and overall business health.
