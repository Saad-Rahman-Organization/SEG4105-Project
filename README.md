# NutriSnap Flutter Application

## How to Run

1.  Install required Android platform/NDK (only once):

    & "$HOME/AppData/Local/Android/Sdk/cmdline-tools/latest/bin/sdkmanager.bat" "platforms;android-36" "ndk;27.0.12077973"

2.  Fetch deps and regenerate code:

    flutter pub get
    dart run build_runner build --delete-conflicting-outputs

3.  Run on emulator/device:

    flutter run -d emulator 

Optional: 

  For initial testing, I would reccomend running:

    flutter run -d chrome

  and then moving on to an emulator/device run. 
  
MAAZ ZAIDI, 300246507

# Backend

SAAD RAHMAN WARSI, 300249227
# SEG4105 Software Project Management - Course Project

[![Course](https://img.shields.io/badge/uOttawa-SEG4105-garnet.svg)](https://catalogue.uottawa.ca/en/courses/seg/)

This repository contains the source code, deliverables, and project management artifacts for the system prototype developed as part of the **SEG4105 (Software Project Management)** course at the University of Ottawa[cite: 1].

## 📋 Project Overview
The objective of this project is to apply advanced project planning, estimation, risk management, and configuration control to build a robust software prototype[cite: 1]. The system is engineered to solve modern domain-specific workflow challenges while adhering to rigorous engineering standards[cite: 1].

### Key Features Implemented:
* **Feature 1:** User Authentication and Role-based Access Control (RBAC)[cite: 1]
* **Feature 2:** Real-time Core Workflows / Data Management Dashboard[cite: 1]
* **Feature 3:** Automated Reporting, Audit Trails, and Analytics[cite: 1]

---

## 🛠️ Tech Stack & Tools
* **Language:**   Python [cite: 1]
* **Frameworks:** Flask / Flutter[cite: 1]
* **Project Management Tools:** Jira / GitHub Projects / Trello[cite: 1]

---

## 🚀 Getting Started

### Prerequisites
Ensure you have the relevant tools installed locally based on your setup:[cite: 1]
* Runtime Environment (e.g., JDK 17+, Node.js v18+, Python 3.10+)[cite: 1]
* Build Tools / Package Managers (e.g., Maven, Gradle, npm, pip)[cite: 1]
* Database Engine (or Docker for containerized setup)[cite: 1]

### Installation
1. **Clone the repository:**
```bash
   git clone [https://github.com/Saad-Rahman-Organization/SEG4105-Project.git](https://github.com/Saad-Rahman-Organization/SEG4105-Project.git)
   cd SEG4105-Project
   ```[cite: 1]

2. **Configure Environment Variables:**
   Create a `.env` file or adjust configuration scripts in the root directory:
```env
   PORT=8080
   DATABASE_URL=your_database_connection_string
   ```[cite: 1]

3. **Build and Run:**
```bash
   # Build the project
   [build-command]
   
   # Start the application
   [run-command]
   ```[cite: 1]

---

## 📅 Project Management Artifacts & Milestones
As this is a Project Management course submission, the following key engineering and management checkpoints were tracked:[cite: 1]

| Milestone / Deliverable | Status | Description |
| :--- | :--- | :--- |
| **Project Charter** | ✅ Completed | Outlined scope, constraints, milestones, and stakeholder matrix. |
| **Estimation & Cost Analysis**| ✅ Completed | Applied COCOMO / Function Point Analysis for effort sizing. |
| **Checkpoint 1: Architecture** | ✅ Completed | Initial system architecture design, baseline scheduling, and plan. |
| **Checkpoint 2: Midpoint** | ✅ Completed | Incremental build evaluation, metrics tracking, and risk updates. |
| **Final Demo & Report** | ✅ Completed | End-to-end working prototype verification against metrics. |[cite: 1]

*Note: Document versions, risk logs, and metrics tracking matrices can be found in the `/docs` or `/management-artifacts` folder.*[cite: 1]

---

## 📂 Repository Structure
```text
SEG4105-Project/
├── src/                  # Application source code
│   ├── backend/          # Server-side business logic
│   └── frontend/         # User interface templates/scripts
├── docs/                 # Assignment submissions, charts, and diagrams
│   ├── Project_Charter.pdf
│   └── Risk_Management_Matrix.xlsx
├── tests/                # Unit, integration, and system test suites
├── .gitignore
└── README.md
```[cite: 1]

---

## 👥 Group Members
* **Saad Rahman**[cite: 1]
* **Maaz Zaidi**[cite: 1]
* **Tariq Jabi**[cite: 1]
* **Pavel Karmaker**[cite: 1]
