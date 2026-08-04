# Placement Management System – Chapter 6
## Making Software Respond Automatically with Apex Triggers

### Objective
Implement Apex Triggers to automate business processes in the Placement Management System while keeping business logic inside service classes.

---

## Features Implemented

###  Automatically Validate New Applications
- Created a **Before Insert Trigger** on `Application__c`.
- Delegated validation logic to `ApplicationService.validateApplications()`.
- Prevents invalid application records from being saved.

###  Update Placement Statistics
- Created an **After Update Trigger**.
- Detects when an application's status changes to **Selected**.
- Calls `StatisticsService` to update placement statistics.

###  Send Notifications
- Delegated notification functionality to `NotificationService`.
- Sends notifications whenever important placement events occur.

###  Business Logic in Service Classes
- Trigger contains only event handling.
- All validation and processing logic is implemented inside `ApplicationService`.

###  Reusable Trigger Architecture
- Designed a clean and maintainable architecture.
- Business logic is separated into dedicated service classes for future scalability.

---

# Project Structure

```
force-app
└── main
    └── default
        ├── classes
        │   ├── ApplicationService.cls
        │   ├── StatisticsService.cls
        │   ├── NotificationService.cls
        │   └── *.cls-meta.xml
        │
        └── triggers
            ├── ApplicationTrigger.trigger
            └── ApplicationTrigger.trigger-meta.xml
```

---

# Trigger Events

## Before Insert
- Validate Student
- Validate Job
- Prevent invalid records

## After Update
- Detect status changes
- Update placement statistics
- Send notifications

---

# Architecture

```
Application Trigger
        │
        ▼
ApplicationService
        │
 ┌──────┴──────────┐
 │                 │
 ▼                 ▼
StatisticsService  NotificationService
```

---

# Business Flow

```
Application Created
        │
        ▼
Before Insert Trigger
        │
        ▼
ApplicationService.validateApplications()
        │
        ▼
Application Saved
        │
        ▼
Status Updated
        │
        ▼
After Update Trigger
        │
        ▼
ApplicationService.handleStatusUpdates()
        │
 ┌──────┴──────────┐
 ▼                 ▼
StatisticsService  NotificationService
```

---

# Testing

### Scenario 1
**Action**
Create a valid application.

**Expected Result**
Application is saved successfully.

---

### Scenario 2
**Action**
Create an application without Student or Job.

**Expected Result**
Validation error is displayed.

---

### Scenario 3
**Action**
Update Application Status from **Applied** to **Selected**.

**Expected Result**
- Trigger executes successfully.
- StatisticsService is invoked.
- NotificationService is invoked.

---

### Scenario 4
**Action**
Check Salesforce Debug Logs.


