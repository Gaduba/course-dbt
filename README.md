# Greenery DBT Data Modeling Project


## Introduction

This dbt project focuses on creating a scalable and maintainable data structure for Greenery, an e-commerce platform, by utilizing dbt to organize, transform, and model raw data from PostgreSQL into actionable insights for various business units. The project follows a structured approach, covering essential dbt concepts like staging models, fact/dimension models, snapshots, and data marts, while aiming to address specific business questions related to user behavior, product performance, and marketing activities

### Project Structure and Key Components:
  #### 1. Project Setup

- Initialized a dbt project named greenery, connecting to a PostgreSQL data source for raw data.
- Configured dbt_project.yml and profiles.yml to ensure proper connection with credentials and schemas in Snowflake.
- Built a clear directory structure with models, snapshots, and source files to ensure modular and scalable development.

  #### 2. Staging Models

- Created staging models for all seven source tables from PostgreSQL, located in the models/staging/postgres/ folder.
- The staging models follow dbt best practices, avoiding SELECT * and explicitly selecting, renaming, and casting columns for clarity and consistency.
- These models serve as a clean and standardized foundation for subsequent transformations.

  #### 3. Snapshots

- Set up a snapshot model for monitoring changes in the products table, tracking the inventory column over time.
- Snapshots allow for historical analysis of data changes (e.g., product stock levels, pricing fluctuations) by capturing point-in-time records.
- Configured the snapshot to build in the personal Snowflake schema to align with dbt's dynamic target variables.
  
  #### 4. Data Marts

- Created dedicated marts for various business units:
Product Mart: Tracks daily page views, orders by product, and product performance, helping to analyze traffic-to-purchase conversion rates.
Core Mart: Includes models like fact_orders, dim_products, and dim_users to handle key business metrics.
Marketing Mart: Aggregates order information at the user level, providing insights into user behavior and marketing effectiveness.

#### 5. Answering Business Questions

- Used dbt models to answer key questions such as user repeat rate, average delivery times, and user engagement metrics (e.g., session counts, purchases).
Developed SQL queries to calculate metrics like average order time, user purchase frequency, and other KPIs, with results stored in the marts.

#### 6. Data Analysis and Funnel Insights

- Designed models to understand the product funnel by analyzing user movement through different stages (e.g., product views to purchases).
Identified critical drop-off points where users disengage, providing insights to improve user experience and conversion rates.
Version Control and Collaboration

#### 7 Leveraged GitHub for version control, regularly pushing updates and tracking changes to ensure seamless collaboration and deployment.
- Outcome
By structuring the data in a logical, layered approach, this dbt project enables the Greenery team to answer complex business questions, track performance metrics, and generate insights to drive product, user, and marketing strategies. The project emphasizes flexibility, scalability, and maintainability, ensuring the data models can evolve alongside the business’s growing needs.