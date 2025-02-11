# Kubernetes - Helm Notes


## **What is Helm?**
Helm is a package manager for Kubernetes that simplifies the deployment, management, and scaling of applications. It uses preconfigured templates, called Helm Charts, to automate the process of creating Kubernetes resources.

### **Why Use Helm?**
- **Simplifies Kubernetes deployments**: Automates the creation and management of Kubernetes resources.
- **Provides version control**: Manage different versions of your application.
- **Reusable templates**: Create consistent and repeatable deployments.

---

## **Key Concepts in Helm**

### **1. Helm Charts**
Helm Charts are collections of templates that define Kubernetes resources. These charts contain all the necessary files to deploy an application on Kubernetes.

#### **Structure of a Helm Chart**
- **Chart.yaml**: Contains metadata about the chart (name, version, description).
- **Values.yaml**: Contains default configuration values for the chart.
- **Templates/**: Directory containing YAML templates for Kubernetes resources.

#### **Example of Chart.yaml:**
```yaml
apiVersion: v2
name: my-application
version: 1.0.0
description: A Helm chart for my application
```

### **2. Helm Repositories**
Helm Repositories are storage locations for Helm Charts. These repositories can be public or private and allow you to store and retrieve charts for your deployments.

#### **Popular Helm Repositories:**
- Bitnami
- ArtifactHub
- Helm Stable Repository

### **3. Helm Releases**
A Helm Release is a specific deployment of a Helm Chart. Every time a chart is deployed, it is tracked as a release.

---

## **Key Features of Helm**

| **Feature**           | **Description**                                 |
|-----------------------|-------------------------------------------------|
| Simplified Deployment | Automates Kubernetes resource creation          |
| Version Control       | Tracks application versions and rollbacks       |
| Reusable Templates    | Creates consistent configurations using charts  |
| Scalability           | Easily manage application scaling               |

---

## **Helm Workflow**
The typical workflow for using Helm involves creating charts, installing releases, upgrading them, and rolling back if necessary.

### **Step 1: Create a Chart**
```bash
helm create my-chart
```
This command generates a basic chart structure with the necessary files.

### **Step 2: Install a Release**
```bash
helm install <release-name> <chart>
```
This command installs a release from the specified chart.

#### **Example:**
```bash
helm install my-app ./my-chart
```

### **Step 3: Upgrade a Release**
```bash
helm upgrade <release-name> <chart>
```
This command upgrades an existing release with new chart configurations.

#### **Example:**
```bash
helm upgrade my-app ./my-chart
```

### **Step 4: Rollback a Release**
```bash
helm rollback <release-name> <revision>
```
This command rolls back a release to a previous revision.

#### **Example:**
```bash
helm rollback my-app 1
```

---

## **File Descriptions in Helm**

### **1. Chart.yaml**
This file contains metadata about the Helm Chart.

#### **Example:**
```yaml
apiVersion: v2
name: my-chart
version: 1.0.0
description: A sample Helm chart
```

### **2. Values.yaml**
Contains the default configuration values for the chart.

#### **Example:**
```yaml
replicaCount: 2
image:
  repository: nginx
  tag: latest
  pullPolicy: IfNotPresent
service:
  type: ClusterIP
  port: 80
```

### **3. Templates/**
Contains Kubernetes resource templates.

#### **Example Template:** ConfigMap
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  myValue: "Example"
```

---

## **Pre-existing Helm Charts**
There are several pre-existing Helm Charts available in repositories:

| **Chart**       | **Description**                      |
|-----------------|--------------------------------------|
| Nginx           | Web server                           |
| Prometheus      | Monitoring system                    |
| Grafana         | Dashboard and visualization tool     |
| Jenkins         | Continuous Integration server        |
| MySQL           | Database server                      |

---

## **Helm Commands**

| **Command**                          | **Description**                               |
|--------------------------------------|-----------------------------------------------|
| `helm install <release> <chart>`     | Install a Helm chart                          |
| `helm upgrade <release> <chart>`     | Upgrade an existing release                  |
| `helm rollback <release> <revision>` | Rollback a release to a previous revision     |
| `helm package <path-to-chart>`       | Package a chart into a `.tgz` archive         |
| `helm push <chart>`                  | Push a chart to a repository                 |

---

## **Helm Templates**
Helm templates use Go template syntax to create dynamic configurations.

### **1. Helper Templates**
Helper templates are reusable components defined in a `_helpers.tpl` file.

#### **Example:**
```yaml
{{- define "my-chart.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}
```

### **2. Dynamic Names in Templates**
Dynamic names use variables to customize resource names.

#### **Examples:**
```yaml
metadata:
  name: {{ .Release.Name }}-configmap
```
```yaml
metadata:
  name: {{ .Release.Name | lower }}-deployment
```

### **3. Conditional Rendering**
Conditional rendering allows templates to include or exclude configurations based on values.

#### **Example:**
```yaml
selector:
  app: my-app
{{- if .Values.service.external }}
externalIPs:
  - {{ .Values.service.external }}
{{- end }}
```

---

## **Deployment Example: Nginx**

1. **Install Nginx using Helm:**
```bash
helm install my-nginx bitnami/nginx
```

2. **Customize using values.yaml:**
```yaml
replicaCount: 2
service:
  type: LoadBalancer
```

---

## **Deployment Example: Prometheus and Grafana**
Use existing Helm charts to set up monitoring tools.

1. **Install Prometheus:**
```bash
helm install prometheus prometheus-community/prometheus
```

2. **Install Grafana:**
```bash
helm install grafana grafana/grafana
```

---

## **Summary**
Helm simplifies Kubernetes application deployments by providing reusable charts, version control, and dynamic templates. It reduces the complexity of managing Kubernetes resources and ensures consistent configurations across environments.
