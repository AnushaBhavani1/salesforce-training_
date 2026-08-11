# Placement Management System

A Salesforce-based Placement Management System for managing students, companies, jobs, and student applications.

## Project Overview

The Placement Management System provides a centralized platform for students to view eligible job opportunities and apply for jobs based on placement eligibility criteria.

The system uses Salesforce custom objects, Apex classes, triggers, and Lightning Web Components (LWC).

---

## Main Features

### Student Management
- Store student information
- Track CGPA
- Track active backlogs
- Track department/branch
- Display student information on the placement portal

### Job Management
- Display available jobs
- Display company name
- Display package
- Display application deadline
- Display minimum CGPA
- Display eligible branch
- Display allowed backlogs

### Job Details
Students can click **View Details** to see complete job information.

### Job Application
Students can click **Apply** to submit an application.

The system checks:

1. Student exists
2. Job exists
3. Application deadline
4. Minimum CGPA
5. Active backlogs
6. Eligible branch
7. Duplicate application

