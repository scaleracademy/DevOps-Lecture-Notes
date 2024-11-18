# System Resource Monitoring
---

## Introduction to System Resource Monitoring

**System resource monitoring** involves observing and tracking various system components such as CPU usage, memory consumption, network traffic, and disk I/O. This helps in identifying bottlenecks, optimizing performance, and ensuring system reliability.

### Key Discussion Points:
- Display a **Grafana dashboard** for visual reference.  
  ![Grafana Dashboard](https://hackmd.io/_uploads/S1SSqSvaR.png)

- **Interactive Discussion:**  
  - **What is system resource monitoring?**  
    Monitoring all system resources to understand when and how monitoring should be done. A demo will be provided later in the session.
  
  - **Why is system monitoring important?**  
    - Enables preventive measures before issues escalate.
    - Optimizes resource usage for efficient system operations.
    - Identifies bottlenecks, ensuring smooth system functioning.

---

## Tools for Monitoring

System resource monitoring can be done using a variety of tools, categorized broadly into:

### 1. **Built-in Tools**  
   - **Linux:** `top`, `free`, `ps`, `df`, `vmstat` for monitoring CPU, memory, processes, and disk usage.
   - **Network Monitoring:** `netstat` for network connections and `tcpdump` for traffic analysis.

### 2. **Specialized Tools**  
   These offer in-depth system analysis, often with enhanced visualization and real-time data collection:
   - **Grafana**: Provides a customizable interface for system metrics.
   - **AppDynamics, Zabbix, Datadog**: Comprehensive tools for performance management and anomaly detection.

**Key Considerations for Tool Selection:**
- **System Compliance:** Ensure the tool supports your system.
- **Scalability:** Can it handle growth?
- **Cost:** What are the financial constraints?

**Interactive Questions:**
- **What should be the selection criteria for choosing a monitoring tool?**  
  The criteria should include compliance, scalability, and cost-effectiveness.
  
- **Do we need to learn all the tools?**  
  No, it’s more important to grasp the fundamentals of a few key tools rather than mastering all.

### Real-Time Analysis with Grafana:
- **Dashboard Analysis:**  
  ![System Health](https://hackmd.io/_uploads/BJRonrPpA.png)  
  - The system is healthy, consuming below-average resources. Memory and CPU utilization are low, indicating underutilization.
  
  ![Increased Load](https://hackmd.io/_uploads/SJWIpBPa0.png)  
  - Increased system load with a decrease in idle time.

- **Insight:**  
  Built-in tools provide basic monitoring, but **specialized tools** like Grafana are needed for detailed analysis.

---

## Troubleshooting in Monitoring

Troubleshooting involves identifying the root cause of system issues using monitoring data and a set of diagnostic commands. This process requires real-time data and systematic observation.

### Common Metrics for Troubleshooting:
- **CPU Utilization**  
  - Example: Initially, CPU was idle, but a job increased the load temporarily. After job completion, the system returned to idle.
  
- **Memory Utilization**  
  - Memory was lightly utilized initially. When a process demanded more memory, the system adapted. Upon job completion, swap memory was minimized.

### Key Commands for Troubleshooting:
1. **`top` Command:**  
   Displays real-time resource usage, highlighting processes consuming excessive CPU or memory.
   ![top Command](https://hackmd.io/_uploads/BkJHYcu6A.png)

2. **Analyze the Output:**  
   ![Output Analysis](https://hackmd.io/_uploads/HJ-x5cupC.png)  
   High CPU and memory utilization are identified.

3. **Identify the Process:**  
   - Use the **`ps -ef | grep <PID>`** command to find the specific process causing the issue.  
   ![Process Identification](https://hackmd.io/_uploads/S17ic9upR.png)

4. **Steps after Identifying Process:**
   - Kill unnecessary processes.
   - For essential processes, adjust priorities to prevent system bottlenecks.

---

## Remediation Steps

Once a potential issue is identified, remediation ensures the system continues to function efficiently. 

### Key Remediation Considerations:
- **How to inform users about overutilization?**  
  - **Incorrect Approach:** Ignore the issue.  
  - **Correct Approach:** Ask users how often the process runs:
    - If it runs for a few minutes, no action is needed.
    - If it runs continuously, consider increasing resources based on usage.

**Dashboard Example:**  
![Network Traffic Issue](https://hackmd.io/_uploads/rJcXC9O6A.png)  
- A possible network traffic issue is highlighted.

### Network Traffic Analysis:
- **Graphical Representation:**  
  ![Network Traffic](https://hackmd.io/_uploads/BkeFAqOpR.png)  
  - Data transmission and reception increase at certain times, indicating user activity.

**Real-World Example:**  
- Think of Instagram’s traffic, which increases during peak periods or special events like sales.

### Monitoring Components:
- **Node Exporter:** Collects system metrics and sends them to Prometheus.
- **Prometheus:** Stores data and allows queries.
- **Grafana:** Visualizes the data, making it easier to interpret system performance.

---

## Importance of Alerting

An essential part of system monitoring is **alerting**, which ensures that administrators are notified when issues arise.

**Why is alerting important?**
- It provides real-time updates when spikes in system activity occur, helping prevent crashes and downtime.

**Command:**  
- `$ systemctl status`  
  - Used to check the status of key services like Grafana.

### Running Applications as Services
- Applications can be managed and monitored using system commands like `systemctl` to ensure networked systems perform efficiently across multiple machines.
