# Salesforce – Day 3
## Validation Rules, Flows & Triggers

### Project Overview
This project enhances the Placement Management System by implementing Salesforce automation using Flows, Validation Rules, and Apex Triggers. The goal is to automate business processes while maintaining data quality and minimizing Apex code wherever possible.

---

## Requirements Solved Using Flow

The following business requirements were implemented using Record-Triggered Flows:

- Automatically populate the **Application Date** when a new Application record is created.
- Send an **Email Notification** to the Placement Officer whenever a student submits an application.
- Automatically create an **Offer Letter** record when the Application Status changes to **Selected**.

---

## Requirements Solved Using Validation Rules

The following validations were implemented using Validation Rules:

- Student CGPA must be greater than or equal to the Job's Minimum CGPA.
- Application Date cannot be after the Job Closing Date.
- Student field cannot be left blank.
- Job field cannot be left blank.
- Status field cannot be left blank.
- Application Date cannot be left blank.

---

## Requirements That Still Needed Apex

The following requirement was implemented using Apex Trigger:

- Prevent duplicate applications by ensuring the same student cannot apply for the same job more than once.

---

## Why These Solutions?

### Flow
Flows were chosen because they provide a declarative, no-code solution for automating business processes such as updating fields, sending emails, and creating related records.

### Validation Rules
Validation Rules were used to enforce data quality by preventing invalid or incomplete data from being saved.

### Apex Trigger
Apex Trigger was used for complex business logic such as detecting duplicate applications, which requires querying existing records before saving.

---

## Features Implemented

- Record-Triggered Flow for Application Date
- Email Notification Flow
- Offer Letter Creation Flow
- Validation Rules for data quality
- Apex Trigger for duplicate application prevention

---

## Technologies Used

- Salesforce Flow Builder
- Validation Rules
- Apex Triggers
- Custom Objects
- Lightning Experience

---

## Outcome

Successfully implemented declarative automation and validation for the Placement Management System while using Apex only where required, following Salesforce best practices.
