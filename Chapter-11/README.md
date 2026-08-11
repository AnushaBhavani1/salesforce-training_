# Sprint 11 – Salesforce External Recruitment Integration

## Placement Management System

### Overview

Sprint 11 extends the Placement Management System by connecting Salesforce with an external recruitment API.

When an Application is marked as **Selected**, Salesforce asynchronously sends the candidate information to an external recruitment system using a REST API.

The integration uses:

- Queueable Apex
- HTTP Callouts
- REST API
- JSON
- Named Credentials
- External Credentials
- Permission Sets
- Integration status tracking
- Error handling

---

# 1. Business Problem

The Placement Management System stores student applications and selection information inside Salesforce.

However, recruiting companies may use their own recruitment platforms.

When a student is selected for a job, the placement team needs the candidate information to be sent automatically to the external recruitment system.

### Business Requirement

When:

```text
Application Status = Selected
