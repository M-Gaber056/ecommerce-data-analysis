# HR Analytics in Power BI

An interactive Human Resources (HR) analytics report built with **Microsoft Power BI** while completing DataCamp's [Case Study: HR Analytics in Power BI](https://www.datacamp.com/courses/case-study-hr-analytics-in-power-bi).

This project explores workforce data to help understand hiring trends, employee demographics, performance, satisfaction, and attrition. It combines data modeling, DAX, exploratory data analysis, and report design into a consolidated Power BI experience.

## Project Overview

The goal of this project is to transform HR datasets into an interactive report that makes workforce metrics easier to explore and understand.

The analysis focuses on questions such as:

- **Hiring trends:** How does hiring change over time?
- **Workforce composition:** How is the workforce distributed across demographic groups, departments, and job roles?
- **Employee performance:** What do performance reviews and employee satisfaction measures reveal?
- **Employee attrition:** What patterns and factors are associated with employees leaving the organization?

The case study uses data for Atlas Labs, a fictional software company, as part of DataCamp's Power BI learning experience.

## Tools and Technologies

- **Microsoft Power BI Desktop** — report development and interactive visualizations
- **DAX (Data Analysis Expressions)** — measures, date calculations, and analytical logic
- **Data modeling** — connecting employee, performance, and supporting lookup tables
- **CSV and text files** — source datasets and date-table definition
- **JSON** — custom Power BI report theme

## Key Components

### 1. Data Modeling and Preparation

The repository includes employee records, performance reviews, and lookup tables for fields such as education, ratings, and satisfaction.

These datasets support the relationships and calculations needed to analyze workforce metrics from different perspectives.

### 2. Exploratory Data Analysis

The report explores hiring activity, workforce demographics, departments, job roles, and employee performance. These views provide context for examining employee attrition and potential retention challenges.

### 3. DAX and Date Analysis

The project includes a DAX definition for a date dimension based on employee hire dates. A dedicated date table supports time-based analysis and reporting.

### 4. Report Design

A custom Power BI theme is included in `Theme.json`. It defines the report's color palette, typography settings, and visual styling to create a consistent appearance across report pages.

## Repository Contents

| File or folder | Description |
|---|---|
| `CaseStudyHrAnal.pbix` | Power BI report containing the analysis and visualizations |
| `Theme.json` | Custom HR Analytics report theme |
| `Datasets/Employee.csv` | Employee-level information, including department, role, demographics, salary, and employment details |
| `Datasets/PerformanceRating.csv` | Employee performance reviews, satisfaction ratings, and related measures |
| `Datasets/EducationLevel.csv` | Education-level lookup table |
| `Datasets/RatingLevel.csv` | Rating-level lookup table |
| `Datasets/SatisfiedLevel.csv` | Satisfaction-level lookup table |
| `Datasets/DimDate.txt` | DAX definition for the date dimension |
| `Datasets/Metadata - Case Study_HR Analytics in Power BI.pdf` | Supporting metadata documentation for the case-study datasets |

## How to Explore the Project

1. Install [Microsoft Power BI Desktop](https://powerbi.microsoft.com/desktop/).
2. Clone or download this repository.
3. Open `CaseStudyHrAnal.pbix` in Power BI Desktop.
4. If Power BI asks for source locations, update them to match the files in the `Datasets/` folder.
5. Refresh the data if required, then navigate through the report pages and interact with the available visuals and filters.

## Skills Demonstrated

- Power BI report development
- Data modeling and table relationships
- DAX and date-based calculations
- Exploratory data analysis
- HR metrics and workforce analytics
- Interactive data visualization
- Report layout, theming, and consistency

## Learning Context and Attribution

This project was developed while working through DataCamp's **Case Study: HR Analytics in Power BI**, created in collaboration with Microsoft.

The underlying case study uses the fictional company Atlas Labs for educational purposes. This repository documents my Power BI learning project; it is not an official DataCamp or Microsoft product.

- [DataCamp case study](https://www.datacamp.com/courses/case-study-hr-analytics-in-power-bi)
- [Power BI Desktop](https://powerbi.microsoft.com/desktop/)

## Connect

- **GitHub repository:** https://github.com/M-Gaber056/hr-analysis-in-powerbi
- **LinkedIn project post:** *Add your LinkedIn post URL here after publishing.*

---

*Built as part of my ongoing journey in data analytics and business intelligence.*
