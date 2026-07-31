# 🚀 Salesforce Interview Readiness Bootcamp – Day 4

# Lightning Web Components (LWC) – Placement Management System

## 📌 Objective

The objective of this assignment is to understand the fundamentals of **Lightning Web Components (LWC)** by building the first user interface for the **Placement Management System**.

---

# 📖 What is Lightning Web Components (LWC)?

Lightning Web Components (LWC) is Salesforce's modern UI framework built on standard web technologies such as **HTML, JavaScript, and CSS**. It enables developers to build reusable, fast, secure, and maintainable components that interact with Salesforce data through Apex.

---

# 💻 What I Built

I developed the first user interface for the **Placement Management System** using Lightning Web Components.

### Features

- ✅ Welcome to Vishnu Placement Portal
- ✅ Institute Logo
- ✅ Welcome Banner
- ✅ Student Information
- ✅ Placement Dashboard
- ✅ Dashboard Cards
  - Students
  - Companies
  - Jobs
  - Applications
- ✅ Show Welcome Message Button
- ✅ Apply Button
- ✅ Status changes from **Not Applied** → **Applied**
- ✅ Responsive UI Design

> **Note:** All values are currently hardcoded. They will be connected to Apex and Salesforce Database in future assignments.

---

# 📂 Project Structure

```text
placementHome/
│
├── placementHome.html
├── placementHome.js
├── placementHome.css
└── placementHome.js-meta.xml
```

---

# 📄 Files Used

## placementHome.html

Responsible for:

- Page Layout
- Welcome Banner
- Dashboard
- Student Details
- Buttons
- Data Binding

---

## placementHome.js

Responsible for:

- Variables
- JavaScript Logic
- Event Handling
- Button Click Events

Variables Used

- studentName
- rollNumber
- department
- message
- status

Methods

- showMessage()
- apply()

---

## placementHome.css

Responsible for:

- Modern UI Design
- Dashboard Cards
- Responsive Layout
- Hover Effects
- Banner Styling
- Footer Styling

---

## placementHome.js-meta.xml

Responsible for exposing the component to Lightning App Builder.

Targets Used

- lightning__HomePage
- lightning__AppPage

---

# ✅ Activities Completed

## Activity 1

Created the first Lightning Web Component.

Displayed:

```
Welcome to Vishnu Placement Portal
```

---

## Activity 2

Created variables for:

- Student Name
- Roll Number
- Department

Displayed them on the screen using data binding.

---

## Activity 3

Created a button:

```
Show Welcome Message
```

On clicking the button:

```
Welcome to Salesforce Development!
```

is displayed.

---

## Activity 4

Created another button:

```
Apply
```

Initially:

```
Status : Not Applied
```

After clicking the button:

```
Status : Applied
```

---

# 📊 Mini Project

Created the first screen of the **Placement Management System**.

Dashboard contains:

- 👨‍🎓 Students
- 🏢 Companies
- 💼 Jobs
- 📄 Applications

---

# 🔄 Data Binding

Displayed:

```html
Hello {studentName}
```

When the value of **studentName** changes in JavaScript, the UI updates automatically without refreshing the page.

This demonstrates **one-way reactive data binding** in Lightning Web Components.

---

# 🛠 Technologies Used

- Salesforce
- Lightning Web Components (LWC)
- HTML
- JavaScript
- CSS
- Salesforce CLI
- Visual Studio Code

---

# 📚 What I Learned Today

- Introduction to Lightning Web Components
- LWC Architecture
- Component Structure
- HTML in LWC
- JavaScript in LWC
- Meta XML File
- Data Binding
- Event Handling
- Lightning App Builder
- Component Deployment
- Building Responsive User Interfaces

---

---

