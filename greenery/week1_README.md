# Greenery DBT Project

## SQL Queries and Answers

### 1. How many users do we have?
- SQL Query:
  ```sql
  SELECT COUNT(distinct user_id) FROM stg_users;
  ```
- Answer: 130

### 2. On average, how many orders do we receive per hour?
- SQL Query:
  ```sql
  SELECT AVG(order_count) FROM(
    SELECT date_trunc('hour',created_at)AS hour, 
    COUNT(order_id) AS order_count)
    FROM stg_orders
    GROUP BY hour;
  ```
- Answer: 7.520833

### 3. On average, how long does an order take from being placed to being delivered?
- SQL Query:
  ```sql
  SELECT AVG(DATEDIFF('hour',created_at, ddelivered_at)) AS avg_delivery_time 
  FROM stg_orders;
  ```
- Answer: 93.403279

### 4. How many users have only made one purchase? Two purchases? Three+ purchases?
- SQL Query:
  ```sql
  WITH purchases AS (SELECT user_id, COUNT(order_id) AS purchase_count
  FROM stg_orders
  GROUP BY user_id
  HAVING purchase_count = 1 
  OR purchase_count = 2
  OR purchase_count >= 3)
  
  SELECT count(DISTINCT user_id), purchase_count
  FROM purchase
  GROUP BY purchase_count;
  ```
- Answer: 1 purchase = 8 users
2 purchases = 28 users
3+ purchases = 71 users

### 5. On average, how many unique sessions do we have per hour?
- SQL Query:
  ```sql
  SELECT AVG(session_count) FROM (SELECT date_trunc('hour', created_at) AS hour, 
  COUNT (DISTINCTY session_id) AS session_count
  FROM stg_events
  GROUP BY hour);
  ```
- Answer: 16.327586

## GitHub Repository
[Link to your GitHub repository](https://github.com/Gaduba/course-dbt.git)
