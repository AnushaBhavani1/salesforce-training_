# Sprint 4 – Building Business Logic with Apex

## Project
Placement Management System

## Objective

The objective of this sprint was to implement business logic for the Placement Management System using Apex. The focus was on allowing students to apply for jobs while enforcing business rules before saving application records.

---

## Business Requirements Implemented

- Accept student job applications.
- Prevent duplicate applications.
- Validate student eligibility based on CGPA.
- Save valid applications.
- Return meaningful success or failure messages.

---

## Apex Class Created

### ApplicationService.cls

This service class is responsible for handling all application-related operations.

### Method

```apex
submitApplication(Id studentId, Id jobId)
```

This method performs the following operations:

1. Checks whether the student has already applied for the selected job.
2. Retrieves Student details.
3. Retrieves Job details.
4. Validates the student's CGPA against the job's minimum CGPA.
5. Creates a new Application record if all validations pass.
6. Returns an appropriate success or error message.

---

## Business Logic Flow

```
Student Clicks Apply
        ↓
Retrieve Student Details
        ↓
Retrieve Job Details
        ↓
Check Duplicate Application
        ↓
Validate Eligibility
        ↓
Create Application Record
        ↓
Insert Record
        ↓
Return Confirmation Message
```

---

## Validation Implemented

### Duplicate Application

The system checks whether an Application record already exists for the same Student and Job.

Result:

- Duplicate application → Rejected
- New application → Accepted

---

### Eligibility Validation

The student's CGPA is compared with the Job's Minimum CGPA.

Result:

- CGPA meets requirement → Application accepted
- CGPA below requirement → Application rejected

---

## Technologies Used

- Salesforce Platform
- Apex
- SOQL
- DML (Insert)
- Execute Anonymous Window
- Developer Console

---

## Testing Performed

### Scenario 1

Student applies for the first time.

Expected Result

```
Application submitted successfully.
```

---

### Scenario 2

Student applies again for the same job.

Expected Result

```
Application already exists.
```

---

### Scenario 3

Student CGPA is below the required CGPA.

Expected Result

```
Student is not eligible.
```

---

## Concepts Learned

- Business Logic
- Service Layer Design
- Apex Classes
- Apex Methods
- Parameters
- SOQL Queries
- DML Insert
- Duplicate Validation
- Eligibility Validation
- Business Responsibilities
- Clean Code Design

---

## Engineering Principles Learned

- Understand the business before writing code.
- One class should have one responsibility.
- Every method should solve one business problem.
- Retrieve data before making business decisions.
- Validate before saving records.
- Return meaningful messages to users.

---

## Outcome

Successfully implemented the business logic for student job applications using Apex by combining:

- Business Rules
- SOQL
- DML
- Service Class Design

The Placement Management System can now process applications intelligently by validating eligibility, preventing duplicates, and saving valid records.

## Output
<img width="960" height="1020" alt="image" src="https://github.com/user-attachments/assets/edcaddbf-ce50-459b-aae3-6006df7d2440" />
<img width="1920" height="1020" alt="Screenshot 2026-08-04 104514" src="https://github.com/user-attachments/assets/98a9f846-7fae-4d3f-83a5-21f4a841374e" />



