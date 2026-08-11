# Sprint 10 – LWC Architecture & Component Communication

## Student Placement Portal

Sprint 10 focuses on extending the Student Placement Portal using a component-based Lightning Web Component (LWC) architecture.

The main objective was to understand **parent-to-child communication, child-to-parent communication, custom events, reusable components, form handling, validation, and UI states**.

## Component Tree

The application is divided into smaller components:

```text
StudentPortal
│
├── StudentSummary
├── StudentProfile
└── EligibleJobs
    ├── JobCard
    └── EmptyState
```

Each component has a specific responsibility. `StudentPortal` manages the overall application, `StudentSummary` displays student details, `StudentProfile` handles profile information, and `EligibleJobs` displays available jobs. `JobCard` handles individual jobs, while `EmptyState` is used when no records are available.

## Component Communication

### Parent → Child

Parent components pass data to child components using public properties with `@api`.

```javascript
@api studentName;
@api branch;
@api cgpa;
```

Similarly, `JobCard` receives job information through:

```javascript
@api job;
```

This allows child components to display data provided by their parent.

### Child → Parent

Child components communicate with their parent using **Custom Events**.

For example, `JobCard` dispatches `viewdetails` and `apply` events when the user performs the corresponding actions. `EligibleJobs` handles these events and passes the information to `StudentPortal`.

```text
JobCard
   ↓
EligibleJobs
   ↓
StudentPortal
```

The main principle is: **Children report events, while parents coordinate the required actions.**

## Data Strategy

The current implementation mainly uses local component state.

* `EligibleJobs` uses a local `jobs` array.
* `StudentProfile` stores form values in its component state.
* `StudentSummary` receives student information using `@api`.
* `JobCard` receives job details through `@api`.
* Custom Events are used for component communication.

For Salesforce data operations, **Lightning Data Service (LDS)** can be preferred when standard record APIs are sufficient. Apex can be used for complex business logic, custom processing, or server-side validation.

## Validation and Form Handling

The Student Profile form uses Lightning components such as `lightning-input` and `lightning-button`. Required fields are marked using `required`, and `input.reportValidity()` is used to validate the input before saving.

Client-side validation helps identify issues such as missing fields, incorrect email formats, invalid numeric values, and CGPA range errors.

Important business rules should also be enforced on the server to maintain data integrity.

The form uses a common change handler:

```javascript
handleChange(event) {
    const field = event.target.dataset.field;
    this[field] = event.target.value;
}
```

The profile contains fields such as **Student Name, Email, Phone, CGPA, and Branch**.

## Reusable Components

`JobCard` is reusable because it can display different jobs using the `@api job` property. It also provides events such as `viewdetails` and `apply`.

`EmptyState` is another reusable component that can be used whenever a list has no records, such as Eligible Jobs or My Applications.

## Loading, Empty and Error States

The application considers different UI states:

```text
Loading → Show loading information
Normal  → Display available data
Empty   → Explain that no records are available
Error   → Inform the user that something went wrong
```

The `EmptyState` component provides a consistent and meaningful message when there are no records.

## Architecture Decision

The main architectural decision was to divide the portal into focused components rather than putting all functionality inside `StudentPortal`.

This approach provides **clear responsibilities, better component communication, reusability, and easier maintenance**. It also helps avoid creating a large "God Component" that handles too many unrelated responsibilities.

## Project Structure and Development

The Sprint 10 project is maintained under the `Chapter-10/` directory. The project was verified using Git, committed to the repository, and the final changes were pushed to the `main` branch. Screenshots for Student Profile, Eligible Jobs, Application Success, and Empty State are maintained in the `screenshots` folder.

## Learning Outcomes

Through this sprint, I practiced:

* Parent-to-child and child-to-parent communication
* `@api` properties and Custom Events
* Reusable LWC components
* Form handling and validation
* Lightning Data Service concepts
* Loading, empty, and error states
* Component-based architecture
* Avoiding tightly coupled and overly large components

Overall, Sprint 10 helped me understand how to build a more **structured, reusable, and maintainable LWC application**.

## Interview Summary

> "In Sprint 10, I developed the Student Placement Portal using multiple focused Lightning Web Components. I used `@api` properties for parent-to-child communication and Custom Events for child-to-parent communication. I also created reusable components such as JobCard and EmptyState and implemented form validation in the Student Profile component. The main focus was to separate responsibilities and build a maintainable LWC architecture."
