# Sprint 11 – Salesforce Integration: External Recruitment Gateway

## Business Problem

The Placement Management System needs to communicate with an external recruitment platform. When a student's Application is marked as **Selected**, Salesforce sends the candidate information to the external recruitment API automatically.

The integration allows Salesforce to send selected candidate details without requiring the user to wait for the external system.

## Objectives

- Understand REST APIs and HTTP methods.
- Send JSON data from Salesforce to an external API.
- Use Queueable Apex for asynchronous processing.
- Use Named Credentials instead of hard-coded credentials.
- Handle successful and failed API responses.
- Track integration status on the Application record.
- Store the external candidate ID returned by the API.
- Support retry handling for temporary server failures.
- Understand idempotency and duplicate prevention.
- Document the integration architecture.

## Integration Architecture

Application Status = Selected  
↓  
Queueable Apex  
↓  
CandidateSyncQueueable  
↓  
Named Credential  
↓  
HTTP POST Request  
↓  
External Recruitment API  
↓  
HTTP Response  
↓  
Update Integration Status

## External System

For this prototype, **JSONPlaceholder** is used as a mock external REST API.

Endpoint:

`https://jsonplaceholder.typicode.com/posts`

HTTP Method:

`POST`

The mock API accepts JSON data and returns a simulated created record with an ID.

## API Contract

### Endpoint

`POST /posts`

### Full URL

`https://jsonplaceholder.typicode.com/posts`

### Request Headers

`Content-Type: application/json`

### Request Body

```json
{
  "applicationId": "Salesforce Application Id",
  "studentId": "Student Id",
  "name": "Anusha",
  "email": "student@example.com",
  "department": "CSE",
  "cgpa": 8.4,
  "jobId": "Job Id",
  "company": "Company Name",
  "role": "Python Developer",
  "selectionDate": "2026-08-11"
}
