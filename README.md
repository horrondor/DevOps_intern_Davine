# DevOps Internship Tasks

This repository contains my weekly tasks, hands-on activities, scripts, documentation, and practical work completed during my **DevOps Internship at Davine Technologies**.

## 📌 Internship Overview

**Organization:** Davine Technologies
**Role:** DevOps Intern
**Internship:** DevOps Internship — 2026

**Focus:** DevOps, Linux, Git, Bash Scripting, Automation, Docker, Docker Compose, Jenkins, CI/CD, and GitHub Integration.

The repository is organized week by week to document my learning progress and practical implementation throughout the internship.

---

## 📂 Repository Structure

```text
DevOps-Internship/

├── Week_1/
│   ├── Task/
│   └── Hands-on-Activity/
│
├── Week_2/
│   ├── Task/
│   └── Hands-on-Activity/
│
├── Week_3/
│   ├── Task/
│   └── Hands-on-Activity/
│
├── Week_4/
│   ├── Task/
│   └── Hands-on-Activity/
│
├── Week_5/
│   ├── Task/
│   └── Hands-on-Activity/
│
└── README.md
```

> The structure may be updated as new weekly tasks and activities are completed.

---

# 🗓️ Weekly Progress

## Week 1 — Git & Version Control

* Git fundamentals
* GitHub repository management
* Git configuration
* SSH authentication
* Repository cloning
* Branching and merging
* Merge conflict practice
* Pull Requests
* Git workflow
* GitFlow branching strategy
* Hands-on Git exercises

---

## Week 2 — Linux & DevOps Fundamentals

* Linux users and groups
* File and directory permissions
* Ownership and access control
* Linux command-line operations
* SSH configuration
* Linux system administration
* Networking fundamentals
* Practical Linux administration tasks

---

## Week 3 — Shell Scripting, Automation & Web Servers

* Bash Shell Scripting
* Variables and user input
* Conditional statements
* Loops and functions
* File and directory operations
* Automated file backups
* Cron jobs
* Apache / Nginx web servers
* Basic web server configuration
* Log management
* Hosting a simple HTML website

---

## Week 4 — Docker & Docker Compose

**Release Date:** 17 August 2026

Week 4 focused on containerization using Docker and Docker Compose. The practical work covered building, running, managing, and deploying containerized applications.

### Topics Covered

* Introduction to Docker
* Docker Architecture
* Docker Engine installation
* Docker Images
* Docker Containers
* Docker Hub
* Dockerfiles
* Docker Volumes
* Docker Networks
* Environment Variables
* Port Mapping
* Docker Compose
* Multi-container applications
* Docker best practices

### Practical Work

* Installed and verified Docker Engine
* Pulled images from Docker Hub
* Created and managed Docker containers
* Built custom Docker images using Dockerfiles
* Ran applications inside containers
* Configured persistent storage using Docker Volumes
* Created custom Docker Networks
* Configured environment variables
* Configured container port mapping
* Created Docker Compose configurations
* Deployed a multi-container application
* Verified communication between containers
* Built and deployed a MERN-based multi-container application
* Used multi-stage Docker builds
* Applied container security practices such as running applications with a non-root user
* Pushed Docker images to Docker Hub

### Multi-Container Application

The hands-on activity involved deploying a multi-container application consisting of:

```text
Frontend
   │
   ▼
Backend
   │
   ▼
MongoDB
```

Docker Compose was used to manage the application services, networking, environment variables, ports, and persistent database storage.

---

## Week 5 — Jenkins, CI/CD & GitHub Integration

**Release Date:** 24 August 2026

Week 5 focused on Jenkins, Continuous Integration/Continuous Delivery (CI/CD), GitHub integration, automated builds, pipelines, and webhook-based automation.

### Topics Covered

* Jenkins Fundamentals
* Jenkins Architecture
* Jenkins Installation and Configuration
* Jenkins Dashboard
* Jenkins Jobs and Builds
* Jenkins Credentials
* GitHub Integration
* Freestyle Projects
* Declarative Pipelines
* Jenkinsfile
* Pipeline Stages
* Build Triggers
* GitHub Webhooks
* Build and Test Automation
* Pipeline Troubleshooting
* CI/CD Best Practices

### Practical Work

* Installed and configured Jenkins
* Explored the Jenkins Dashboard
* Connected Jenkins with GitHub
* Configured Jenkins credentials
* Created a Freestyle Project
* Configured a GitHub repository as the project source
* Configured automated build triggers
* Created a Declarative Jenkins Pipeline
* Created and modified a Jenkinsfile
* Implemented pipeline stages for:

  * Checkout
  * Build
  * Test
  * Validation
* Executed Jenkins pipelines
* Analyzed Jenkins Console Output
* Configured GitHub Webhooks
* Tested automatic pipeline triggering through GitHub
* Configured Jenkins Controller and Jenkins Agent architecture
* Ran pipeline workloads on a Jenkins Agent
* Practiced pipeline troubleshooting and failure analysis

### Jenkins CI/CD Workflow

```text
Developer
    │
    ▼
GitHub Repository
    │
    │ Push
    ▼
GitHub Webhook
    │
    ▼
Jenkins Controller
    │
    ▼
Jenkins Agent
    │
    ├── Checkout
    ├── Build
    ├── Test
    └── Validation
    │
    ▼
Build Result
```

### GitHub Webhook Integration

GitHub Webhooks were configured to notify Jenkins when changes were pushed to the repository.

The workflow was tested using a Cloudflare Tunnel to make the Jenkins webhook endpoint accessible externally.

```text
GitHub
   │
   │ Push Event
   ▼
GitHub Webhook
   │
   ▼
Cloudflare Tunnel
   │
   ▼
Jenkins Controller
   │
   ▼
Jenkins Pipeline
```

### Pipeline Troubleshooting

As part of the hands-on activity, controlled failures were introduced into the pipeline to practice the complete troubleshooting workflow:

```text
Pipeline Failure
       │
       ▼
Read Console Output
       │
       ▼
Identify Root Cause
       │
       ▼
Fix the Problem
       │
       ▼
Run Pipeline Again
       │
       ▼
Verify Successful Build
```

---

# 🛠️ Technologies & Tools

### Version Control

* Git
* GitHub
* GitFlow
* SSH

### Operating Systems & Administration

* Linux
* Ubuntu
* Linux Mint
* Bash
* SSH
* Cron
* Vim / Neovim

### Web Servers

* Apache
* Nginx

### Containerization

* Docker
* Docker Engine
* Docker Compose
* Docker Hub
* Dockerfile
* Docker Volumes
* Docker Networks

### CI/CD

* Jenkins
* Jenkins Pipeline
* Jenkinsfile
* GitHub Webhooks
* Jenkins Agents
* Jenkins Credentials

### Virtualization & Networking

* VirtualBox
* Vagrant
* TCP/IP Networking
* Port Mapping
* Virtual Networks
* Cloudflare Tunnel

---

# 🎯 Purpose

The purpose of this repository is to:

* Document my weekly internship progress.
* Maintain practical scripts, configurations, and implementation files.
* Track hands-on DevOps activities.
* Practice real-world Linux and DevOps workflows.
* Understand containerization and CI/CD concepts through practical implementation.
* Maintain a reference of commands, solutions, and troubleshooting processes.
* Demonstrate practical DevOps skills developed during the internship.
* Document the progression from source code management to automated CI/CD workflows.

---

# 📈 Progress

| Week   | Topic                                     | Status         |
| ------ | ----------------------------------------- | -------------- |
| Week 1 | Git & Version Control                     | ✅ Completed    |
| Week 2 | Linux & DevOps Fundamentals               | ✅ Completed    |
| Week 3 | Shell Scripting, Automation & Web Servers | ✅ Completed    |
| Week 4 | Docker & Docker Compose                   | ✅ Completed    |
| Week 5 | Jenkins, CI/CD & GitHub Integration       | 🔄 In Progress |

---

# 📚 Key Learning Outcomes

Through these weekly activities, I have gained practical experience with:

* Version control using Git and GitHub
* Linux system administration
* Bash scripting and automation
* Web server configuration
* Containerizing applications with Docker
* Building custom Docker images
* Managing multi-container applications with Docker Compose
* Docker networking and persistent storage
* Publishing images to Docker Hub
* Jenkins CI/CD pipelines
* Jenkins Controller and Agent architecture
* Declarative Jenkins Pipelines
* Jenkinsfiles and pipeline stages
* GitHub Webhook integration
* Automated build triggering
* CI/CD troubleshooting using Console Output
* Using AI as an assistant for DevOps troubleshooting and pipeline improvement

---

# 👨‍💻 Internship

**Davine Technologies**

**DevOps Internship — 2026**

This repository is maintained as part of my internship learning and practical work.

> **Learning Principle:** Understand the technology and workflow behind each implementation rather than simply copying commands or configurations. AI tools may be used as assistants for troubleshooting, explanation, and automation, but all generated configurations and commands are verified and tested before implementation.
