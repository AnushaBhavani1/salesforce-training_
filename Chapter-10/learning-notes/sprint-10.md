\# Sprint 10 – LWC Architecture



\## Component Architecture



The Student Placement Portal is divided into focused Lightning Web Components.



```text

StudentPortal

│

├── StudentSummary

├── StudentProfile

└── EligibleJobs

&#x20;   ├── JobCard

&#x20;   └── EmptyState

DATA FLOW


StudentPortal
      │
      │ data
      ▼
StudentSummary

StudentProfile
      │
      │ profile input
      ▼
StudentPortal

JobCard
      │
      │ viewdetails / apply
      ▼
EligibleJobs
      │
      │ viewdetails / apply
      ▼
StudentPortal






