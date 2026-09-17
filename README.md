# End-to-End Data Engineering Project with Snowflake, dbt & Apache Airflow

An end-to-end data engineering project that demonstrates how raw business data can be ingested, transformed, tested, and organized into an analytics-ready data warehouse using **Snowflake, dbt, and Apache Airflow**.

The project follows a modern **ELT architecture**, where raw data is loaded into Snowflake first and transformations are then managed using dbt.

---

## 📌 Project Overview

The objective of this project is to build a scalable and maintainable data warehouse pipeline that transforms raw transactional data into structured datasets suitable for analytics and Business Intelligence.

The pipeline covers:

* Data ingestion into Snowflake
* Source data management
* SQL-based transformations with dbt
* Staging layer development
* Dimensional data modeling
* Fact and dimension tables
* Data quality testing
* Workflow orchestration with Apache Airflow
* Documentation and reproducible transformations

---

## 🏗️ Architecture

```text
                    ┌──────────────────────┐
                    │      Source Data     │
                    │ Customers / Orders   │
                    │ Products / Items     │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │       Snowflake      │
                    │      Raw Layer       │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │         dbt          │
                    │   Staging Models     │
                    │ Cleaning & Transform │
                    └──────────┬───────────┘
                               │
                               ▼
              ┌─────────────────────────────────┐
              │           dbt Marts             │
              │                                 │
              │  dim_customers                  │
              │  dim_products                   │
              │  fact_orders                    │
              └────────────────┬────────────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │ Analytics-Ready Data │
                    │      Warehouse       │
                    └──────────────────────┘

                    ▲
                    │
             Apache Airflow
          Pipeline Orchestration
```

---

## 🔄 Data Pipeline

The pipeline follows an ELT approach:

### 1. Extract & Load

Raw source data is loaded into Snowflake without performing the main business transformations outside the warehouse.

### 2. Source Definition

dbt sources are used to define and document the raw tables consumed by the transformation layer.

### 3. Staging

The staging layer prepares raw data for downstream modeling by applying transformations such as:

* Column selection
* Data type standardization
* Renaming
* Data cleaning
* Basic business transformations

Current staging models include:

```text
models/
└── staging/
    ├── stg_customers.sql
    ├── stg_orders.sql
    ├── stg_order_items.sql
    └── stg_products.sql
```

### 4. Dimensional Modeling

The transformed data is organized into fact and dimension tables.

```text
models/
└── marts/
    ├── dim_customers.sql
    ├── dim_products.sql
    └── Fact_orders.sql
```

The resulting model separates descriptive entities from transactional data, making the warehouse easier to query and consume from BI tools.

### 5. Data Quality

dbt tests are used to validate the reliability of the transformation layer.

The project includes tests for common data quality requirements such as:

* Uniqueness
* Not-null constraints
* Referential integrity
* Valid relationships between fact and dimension tables

Tests can be executed with:

```bash
dbt test
```

### 6. Orchestration

Apache Airflow is used to orchestrate the data workflow.

The project includes a DAG responsible for coordinating the Snowflake/dbt pipeline:

```text
Dags/
└── snowflake_dbt_pipeline.py
```

This provides a foundation for automating the execution of data transformation tasks and managing dependencies between pipeline steps.

---

## 🧰 Tech Stack

| Technology         | Purpose                                    |
| ------------------ | ------------------------------------------ |
| **Snowflake**      | Cloud data warehouse                       |
| **dbt**            | Data transformation, testing, and modeling |
| **Apache Airflow** | Workflow orchestration                     |
| **SQL**            | Data transformation and modeling           |
| **Python**         | Pipeline orchestration and automation      |
| **Git & GitHub**   | Version control                            |

---

## 📂 Project Structure

```text
End-to-end-data-engineering-project/
│
├── Dags/
│   └── snowflake_dbt_pipeline.py
│
├── analyses/
│
├── macros/
│
├── models/
│   ├── staging/
│   │   ├── stg_customers.sql
│   │   ├── stg_order_items.sql
│   │   ├── stg_orders.sql
│   │   └── stg_products.sql
│   │
│   ├── marts/
│   │   ├── dim_customers.sql
│   │   ├── dim_products.sql
│   │   └── Fact_orders.sql
│   │
│   ├── source.yml
│   └── example/
│       └── schema.yml
│
├── seeds/
│
├── snapshots/
│
├── tests/
│   └── project_test.yml
│
├── dbt_project.yml
├── README.md
└── .gitignore
```

---

## 🗄️ Data Warehouse Model

The warehouse follows a dimensional modeling approach.

### Dimension Tables

#### `dim_customers`

Contains customer-level attributes used to analyze customer activity and orders.

#### `dim_products`

Contains product-level information used for product and sales analysis.

### Fact Table

#### `Fact_orders`

Contains transactional order information and connects orders with the relevant customer, product, and order-item dimensions.

Conceptually:

```text
                ┌─────────────────┐
                │  dim_customers  │
                └────────┬────────┘
                         │
                         │
                         ▼
                  ┌──────────────┐
                  │  Fact_orders │
                  └──────┬───────┘
                         │
                         │
                         ▼
                ┌─────────────────┐
                │  dim_products   │
                └─────────────────┘
```

---

## 🧪 dbt Workflow

The main dbt workflow can be executed using:

```bash
dbt debug
```

Run the transformation models:

```bash
dbt run
```

Run data quality tests:

```bash
dbt test
```

Run models and tests together:

```bash
dbt build
```

Generate project documentation:

```bash
dbt docs generate
```

Serve the documentation locally:

```bash
dbt docs serve
```

---

## 🔍 Data Quality Strategy

Data quality is treated as part of the transformation workflow rather than as a separate manual process.

The project uses dbt tests to validate important assumptions about the warehouse, including:

```text
Source Data
     │
     ▼
Staging Models
     │
     ├── Not Null
     ├── Unique
     ├── Relationships
     └── Accepted Values
     │
     ▼
Dimensional Models
     │
     ▼
Analytics-Ready Data
```

This helps detect data integrity issues before downstream analytics consume the transformed datasets.

---

## ⚙️ Configuration

The project uses a dbt profile to connect to Snowflake.

Credentials should **never be committed to GitHub**.

Sensitive configuration such as:

```text
profiles.yml
.env
passwords
tokens
private keys
```

should remain outside version control.

The repository's `.gitignore` is configured to prevent common local and sensitive files from being committed.

---

## 🚀 How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/mohammedkhafagy752000/End-to-end-data-engineering-project.git
```

### 2. Navigate to the project

```bash
cd End-to-end-data-engineering-project
```

### 3. Create and activate a Python virtual environment

Windows:

```bash
python -m venv .venv
.venv\Scripts\activate
```

### 4. Install the required packages

Install the required Python dependencies for Airflow and the Snowflake/dbt workflow according to the project environment.

### 5. Configure Snowflake

Configure the dbt Snowflake profile locally.

Do not commit credentials to the repository.

### 6. Validate the dbt connection

```bash
dbt debug
```

### 7. Run the models

```bash
dbt build
```

### 8. Run the Airflow pipeline

Start Airflow and trigger:

```text
snowflake_dbt_pipeline
```

The DAG is responsible for orchestrating the pipeline workflow.

---

## 📊 Analytics Layer

The final warehouse structure is designed to provide clean, consistent, and analytics-ready datasets for downstream Business Intelligence tools.

Potential analytical use cases include:

* Sales performance analysis
* Customer behavior analysis
* Product performance
* Order trends
* Revenue analysis
* Operational KPIs

The dimensional structure allows BI tools such as **Power BI** to consume the warehouse without relying on complex transformations at the reporting layer.

---

## 🎯 Engineering Practices Demonstrated

This project demonstrates practical implementation of several data engineering concepts:

* **ELT architecture**
* **Cloud data warehousing**
* **Dimensional modeling**
* **SQL transformations**
* **dbt staging and marts**
* **Data quality testing**
* **Workflow orchestration**
* **Pipeline dependency management**
* **Version control**
* **Separation of raw and transformed data**
* **Analytics-ready data modeling**
* **Secure credential management**

---

## 🔮 Future Improvements

Possible extensions to the project include:

* Incremental dbt models
* Slowly Changing Dimensions (SCD)
* Automated CI/CD for dbt
* dbt documentation deployment
* Advanced data quality monitoring
* Pipeline failure notifications
* Cloud-based Airflow deployment
* BI dashboard integration
* Additional analytical marts
* Automated source-data ingestion

---

## 👤 Author

**Mohammed Khafagy**

Data Analyst | BI Developer | Data Engineering Enthusiast

Master's Student in Computer Science – Data Science
Damietta University

Focused on building data pipelines, analytical data models, and Business Intelligence solutions using SQL, Python, Snowflake, dbt, and Power BI.

---

## 📄 License

This project is licensed under the **MIT License**.
