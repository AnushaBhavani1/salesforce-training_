# Placement Management System – Chapter 5 (Sprint 5)

## 📌 Overview

This sprint focuses on implementing complete business transactions using **Apex, SOQL, and DML** in the Salesforce Placement Management System.

The Application Service retrieves student and job information, validates business rules, creates new applications, updates application status, and returns meaningful feedback.

---

## 🎯 Sprint Objectives

- Retrieve Student information using SOQL.
- Retrieve Job details using SOQL.
- Prevent duplicate applications.
- Validate student eligibility.
- Validate application deadline.
- Create Application records using DML.
- Update Application Status using DML.
- Return meaningful messages to users.

---



---

## 📂 Objects Used

- Student__c
- Job__c
- Application__c

---

## 📁 Project Structure

```
force-app/
└── main/
    └── default/
        └── classes/
            ├── ApplicationService.cls
            └── ApplicationService.cls-meta.xml
```

---

## 🚀 Features Implemented

### ✔ Retrieve Student Details

Retrieves student information using SOQL.

Fields retrieved:

- Name
- CGPA

---

### ✔ Retrieve Job Details

Retrieves job information.

Fields retrieved:

- Job Name
- Minimum CGPA
- Last Date

---

### ✔ Duplicate Application Check

Checks whether the student has already applied for the same job before creating a new application.

---

### ✔ Eligibility Validation

Checks:

- Student CGPA
- Minimum Job CGPA

If the student is not eligible, the application is rejected.

---

### ✔ Application Deadline Validation

Verifies that the application is submitted before the job's last date.

---

### ✔ Create Application

Creates a new Application record using DML.

Automatically sets:

- Student
- Job
- Application Date
- Status = Applied

---

### ✔ Update Application Status

Updates the application status after recruiter actions.

Supported Statuses:

- Applied
- Shortlisted
- Interview Scheduled
- Selected
- Rejected

---

## 🔍 SOQL Queries

### Retrieve Student

```sql
SELECT Id, Name, CGPA__c
FROM Student__c
WHERE Id = :studentId
```

### Retrieve Job

```sql
SELECT Id, Name, Minimum_CGPA__c, Last_Date__c
FROM Job__c
WHERE Id = :jobId
```

### Duplicate Check

```sql
SELECT COUNT()
FROM Application__c
WHERE Student__c = :studentId
AND Job__c = :jobId
```

---

## 💾 DML Operations

### Insert

```apex
insert app;
```

Creates a new Application record.

---

### Update

```apex
update app;
```

Updates the Application Status.

---

## 📋 Apex Methods

| Method | Description |
|---------|-------------|
| submitApplication() | Creates a new application |
| updateApplicationStatus() | Updates application status |
| getStudent() | Retrieves student details |
| getJob() | Retrieves job details |
| isDuplicate() | Checks duplicate applications |

---

## ✅ Business Validations

- Duplicate Application Validation
- Student Eligibility Validation
- Application Deadline Validation
- Student Record Validation
- Job Record Validation

---

## 🧪 Test Scenarios

### Test Case 1

**Scenario**

Student applies for a job for the first time.

**Expected Result**

```
Application submitted successfully.
```

---

### Test Case 2

**Scenario**

Student applies again for the same job.

**Expected Result**

```
Application already exists.
```

---

### Test Case 3

**Scenario**

Student CGPA is below the required minimum.

**Expected Result**

```
Student is not eligible.
```

---

### Test Case 4

**Scenario**

Student applies after the application deadline.

**Expected Result**

```
Application deadline has passed.
```

---

### Test Case 5

**Scenario**

Recruiter updates the application status.

**Expected Result**

```
Application status updated successfully.
```

---


