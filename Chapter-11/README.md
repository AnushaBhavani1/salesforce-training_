# Sprint 11 – Salesforce API Integration & External Recruitment System

## Placement Management System

A Salesforce-based Placement Management System that integrates with an external recruitment API to synchronize selected candidates.

This sprint demonstrates how Salesforce can communicate securely with an external REST API using:

- Apex HTTP Callouts
- Queueable Apex
- Named Credentials
- External Credentials
- REST APIs
- JSON
- Integration Status Tracking
- Error Handling
- Retry Thinking
- Idempotency
- Asynchronous Integration

---

# 1. Business Problem

The Placement Management System stores students, jobs, and applications inside Salesforce.

When a student is selected for a job, the external recruiting company also needs the candidate's information.

The requirement is:

> When an Application becomes `Selected`, Salesforce should automatically send the candidate information to an external recruitment system.

The student should not have to wait for the external API call to complete.

Therefore, the integration is implemented asynchronously using Queueable Apex.

---

# 2. Integration Architecture

The overall flow is:

```text
                    Salesforce
                        |
                        |
                 Application
                        |
                  Status = Selected
                        |
                        v
                 Queueable Apex
                        |
                        v
              CandidateSyncQueueable
                        |
                        v
                 Named Credential
                        |
                        v
                 REST API Callout
                        |
                        v
          External Recruitment API
                        |
                        v
                 JSON Response
                        |
                        v
             Update Application
                        |
             +----------+----------+
             |                     |
             v                     v
           Sent              Retry Required
