
# 👋 Hi, I'm Marina Gokova

[![LinkedIn](https://img.shields.io/badge/LinkedIn-blue?style=flat-square&logo=linkedin&link=https://www.linkedin.com/in/marianna-gokova)](https://www.linkedin.com/in/marianna-gokova)

---

## 🐾 HealthTail: Interactive Veterinary Analytics

**Status:** Completed  
**Role:** Data Analyst  
**Tech Stack:** Google BigQuery, SQL, Looker Studio  
**Dashboard:** [View on Looker Studio](https://lookerstudio.google.com/s/pJO8lrwf1zs)

<a href="https://github.com/marinaG1717/HealthTail-Interactive-Veterinary-Analytics/blob/54d559dad8278166624f9582a374dc222b290b8f/Common%20Pet%20Diseases%20by%20Type%2C%20Breed%20%26%20Time.pdf" target="_blank">
  <img src="https://img.shields.io/badge/View%20PDF-Common%20Pet%20Diseases-blue?style=for-the-badge&logo=adobeacrobatreader" alt="View PDF">
</a>

---

<a href="https://github.com/marinaG1717/HealthTail-Interactive-Veterinary-Analytics/blob/8a57ff350a8484fa0636cee428047afece94db0b/Veterinary%20Care%20Insights_%20Diagnoses%20and%20Spending.pdf" target="_blank">
  <img src="https://img.shields.io/badge/View%20PDF-Veterinary%20Care%20Insights-blue?style=for-the-badge&logo=adobeacrobatreader" alt="View PDF">
</a>


---

### 📊 Project Overview

- **Client:** HealthTail  
- **Partner:** Clinipet Analytics Team  
- **Data Source:** CSV files (uploaded to BigQuery)

The HealthTail project focused on solving two major business challenges for the veterinary sector:
- **Auditing Medication Purchases and Expenses**: Streamlined annual tracking of medication spending.
- **Monitoring Diagnoses and Disease Trends**: Identified common diagnoses by pet type and breed to support strategic planning.

---

### 🚀 Key Deliverables

- 📂 **Clean and unified datasets** in BigQuery
- ❓ **Business questions answered** with SQL
- 📈 **Interactive Looker Studio dashboard** for real-time insights

---

### 🛠️ How I Built It
## 🧹 Step 1: Data Cleaning & Aggregation in BigQuery

### 🧼 Task 1.1 – Clean Registration Data

Created `healthtail_cleaned_aggregated` table by processing `healthtail_reg_cards`.

| **Column**      | **Transformation Applied**                                |
|------------------|------------------------------------------------------------|
| `patient_name`   | Standardized to **UPPERCASE**                              |
| `owner_phone`    | Removed **non-numeric characters**                         |
| `breed`          | Replaced `NULL` or empty values with `"Unknown"`          |
| *(and others)*   | Basic formatting and normalization                         |

✅ **Output Table**: [`healthtail_cleaned_aggregated`](https://console.cloud.google.com/bigquery?project=healthtail-460009&p=healthtail-460009&d=healthtail_m_g1&t=healthtail_cleaned_aggregated&page=table) *(BigQuery)*

## 📦 Task 1.2 – Medication Audit Table

Created a unified table `med_audit` to track medication purchases and usage.

| **Column**        | **Description**                                      |
|-------------------|------------------------------------------------------|
| `month`           | Month of transaction (`MM`)                          |
| `med_name`        | Medication name                                      |
| `total_packs`     | Aggregated quantity (purchased or consumed)          |
| `total_value`     | Cost value (SUM of price or cost)                    |
| `stock_movement`  | `"stock in"` (purchased) or `"stock out"` (used)     |

**Built from:**
- `healthtail_invoices` (stock in)  
- `healthtail_visits` (stock out)

✅ **Output Table**: `med_audit` *([BigQuery](https://console.cloud.google.com/bigquery?project=healthtail-460009&p=healthtail-460009&d=healthtail_m_g1&t=healthtail_cleaned_aggregated&page=table&inv=1&invt=Abx42Q&ws=!1m19!1m6!12m5!1m3!1shealthtail-460009!2seurope-west3!3sc0783778-1495-4ddc-b788-918d351b0260!2e1!1m6!12m5!1m3!1shealthtail-460009!2seurope-west3!3scac49863-1f10-462e-9f1b-adfe9af08c35!2e1!1m4!4m3!1shealthtail-460009!2shealthtail_m_g1!3smed_audit))*  
💾 **SQL File**: [step1_data_cleaning_and_aggregation.sql](https://github.com/marinaG1717/HealthTail-Interactive-Veterinary-Analytics/edit/main/README.md#:~:text=step1_data_cleaning_and_aggregation) *(includes both queries)*

---

## 🔹 Step 2: Answering Research Questions (SQL)

Using cleaned and aggregated data in BigQuery, we wrote queries to address HealthTail’s business questions such as:

- 🐶 **What are the top 5 most prescribed medications per pet type?**
- 🧬 **Which breeds are diagnosed most frequently with specific diseases?**
- 💰 **How much is spent on medications by month?**
- 📅 **What are the trends in diagnoses across the year?**

Each query was saved along with its results to be used in reporting.  
💾 **SQL File**: [step2_research_questions.sql](https://github.com/marinaG1717/HealthTail-Interactive-Veterinary-Analytics/edit/main/README.md#:~:text=step2_research_questions)  
📁 *Includes individual queries + their result tables/views*

---

## 🔹 Step 3: Looker Studio Dashboard

We created an interactive dashboard in **Looker Studio**, connected directly to **BigQuery**, to provide real-time insights for HealthTail.

📌 **Dashboard Features**:
- 📊 *Disease & Diagnosis Trends* by pet type and breed  
- 💉 *Medication Usage vs Purchases* over time  
- 🔎 *Filters* by date range, pet type  
- 🧾 *Inventory Overview*: quantities and values of stock  

📈 **Dashboard Link**: [HealthTail Looker Studio Dashboard](https://lookerstudio.google.com/s/pJO8lrwf1zs)  
🔗 *Real-time connection to BigQuery for dynamic updates*
### 🌟 Impact & Learnings

- Reduced medication waste via clearer tracking
- Aligned procurement with patient needs
- Enabled proactive staffing and planning
- Centralized reporting for operational visibility

---

## 🛠️ Skills & Technologies

[![BigQuery](https://img.shields.io/badge/Google%20BigQuery-4285F4?style=flat-square&logo=googlebigquery&logoColor=white)](https://console.cloud.google.com/bigquery?project=healthtail-460009&p=healthtail-460009&d=healthtail_m_g1&t=healthtail_cleaned_aggregated&page=table&inv=1&invt=Abx42Q&ws=!1m19!1m6!12m5!1m3!1shealthtail-460009!2seurope-west3!3sc0783778-1495-4ddc-b788-918d351b0260!2e1!1m6!12m5!1m3!1shealthtail-460009!2seurope-west3!3scac49863-1f10-462e-9f1b-adfe9af08c35!2e1!1m4!4m3!1shealthtail-460009!2shealthtail_m_g1!3smed_audit)

[![Looker Studio](https://img.shields.io/badge/Looker%20Studio-4285F4?style=flat-square&logo=googleanalytics&logoColor=white)](https://lookerstudio.google.com/s/o7tMLCGAwkQ)

---

## 📬 Let's Connect

- [LinkedIn](https://www.linkedin.com/in/marianna-gokova)

---
