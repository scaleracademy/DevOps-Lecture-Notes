
# Scaling, Networking, and Automation Notes

## **1. Horizontal vs Vertical Scaling**

### **Understanding Scaling Through a Real-World Analogy**
- **Scenario**: Imagine a restaurant during a festive season.
  - The restaurant adds tables (e.g., increasing from 4 to 6) to accommodate more guests.
  - **Drawback**: Despite additional seating, delays in service occur due to overloading of the kitchen and staff.
  - **Solution**:
    - Expand physical space by adding new floors or outlets.
    - Hire more staff and upgrade the kitchen.
- **Relation to DevOps**:
  - This reflects the two primary scaling strategies:
    1. Adding capacity by expanding resources (Vertical Scaling).
    2. Adding more units to share the load (Horizontal Scaling).


### **Concept of Scaling in DevOps**
Scaling ensures that applications can handle increased traffic and workload efficiently.

1. **Horizontal Scaling** (Scaling Out):
   - Adds multiple servers to distribute traffic.
   - A load balancer is used to direct incoming requests to these servers.
   - Example: A web application serving thousands of users by distributing requests across multiple instances.

2. **Vertical Scaling** (Scaling Up):
   - Upgrades the existing server’s capacity (e.g., more RAM, CPU).
   - Ideal for monolithic applications that are not designed for distributed environments.


### **Comparison Between Horizontal and Vertical Scaling**

| **Aspect**              | **Horizontal Scaling**                            | **Vertical Scaling**                              |
|-------------------------|--------------------------------------------------|--------------------------------------------------|
| **Scaling Method**      | Adds multiple servers to share the load          | Increases resources (CPU, RAM) on one server    |
| **Limitation**          | Complexity in management and synchronization     | Physical hardware limits                        |
| **Cost**                | Higher initial setup cost, scales well          | Expensive with diminishing returns             |
| **Use Case**            | Distributed apps, high-read volume databases    | Smaller apps with balanced read/write needs    |


### **Traditional vs. Modern Scaling**
- **Traditional Approach**:
  - Companies managed physical data centers with limited scalability options.
  - Scaling required manual intervention, including migrations to larger hardware.
- **Modern Approach**:
  - Cloud providers (AWS, GCP) simplify scaling with:
    - Auto-scaling groups for Horizontal Scaling.
    - On-demand instance upgrades for Vertical Scaling.
  - Tools like Docker and Kubernetes enable easy Horizontal Scaling by running applications in containers.


- Why are modern databases more suited to Horizontal Scaling?
  - **Answer**: Containers (via Docker and Kubernetes) allow applications to be easily replicated and deployed in distributed environments, ensuring fault tolerance and scalability.

## **2. Load Balancing: Nginx vs. HAProxy**

### **Load Balancer Functionality Overview**
Load balancers distribute incoming traffic across servers to ensure:
- High availability.
- Fault tolerance.
- Optimized performance.

---

### **Nginx**
- **Analogy**: Think of Nginx as a multitasking station manager who directs trains to platforms while handling various administrative duties.
- **Features**:
  - Optimized for HTTP/HTTPS (Layer 7) traffic.
  - Performs basic TCP load balancing but lacks advanced routing capabilities.
  - Efficient for handling low-to-moderate traffic.
- **Limitations**:
  - Less robust health checks compared to specialized tools.
  - Struggles with large-scale traffic management.

---

### **HAProxy**
- **Analogy**: HAProxy is like a dedicated railway traffic controller, specializing in efficiently routing trains (traffic) during peak times.
- **Features**:
  - Optimized for TCP (Layer 4) load balancing with advanced algorithms.
  - Supports robust health checks for backend servers.
  - Handles high-traffic scenarios efficiently.
- **Advantages Over Nginx**:
  - Prioritizes reliability in large-scale setups.
  - Better suited for applications requiring fine-grained traffic control.

---

### **Key Insight**
Both tools have unique strengths:
- **Nginx** excels at Layer 7 traffic and web server integration.
- **HAProxy** is better for Layer 4 traffic and high-demand environments.

---

## **3. Practical Demonstration: Setting Up HAProxy for MySQL Load Balancing**

### **Overview**
- **Objective**: Set up HAProxy to distribute MySQL traffic across backend servers.
- **Setup**:
  - Frontend Server: Runs HAProxy (no MySQL installed).
  - Backend Server: Hosts MySQL database(s).

---

### **Step-by-Step Guide**

#### 1. **Server Setup**
- Log into two servers:
  - **Frontend Server**: Dedicated for HAProxy installation.
  - **Backend Server**: Running MySQL for database operations.
- Verify MySQL installation on the backend:
  ```bash
  sudo mysql
  ```

---

#### 2. **Installing HAProxy**
- Update the frontend server:
  ```bash
  sudo apt update
  sudo apt install haproxy -y
  ```

---

#### 3. **Configuring HAProxy**
- Open HAProxy configuration file:
  ```bash
  sudo nano /etc/haproxy/haproxy.cfg
  ```
- Add the following configuration:
  ```haproxy
  frontend mysql_front
      bind *:3306
      default_backend mysql_servers

  backend mysql_servers
      mode tcp
      option tcplog
      balance roundrobin
      server mysql_backend <backend-server-ip>:3306 check
  ```
- **Explanation**:
  - `frontend`: Defines the entry point for MySQL traffic (port 3306).
  - `backend`: Lists MySQL servers with IP addresses for traffic distribution.

---

#### 4. **Creating a MySQL User for HAProxy**
- Create a user for HAProxy to perform health checks:
  ```sql
  CREATE USER 'haproxy_check'@'%' IDENTIFIED BY 'password';
  GRANT REPLICATION CLIENT ON *.* TO 'haproxy_check'@'%';
  FLUSH PRIVILEGES;
  ```

---

#### 5. **Testing Connectivity**
- Test connectivity between HAProxy and the backend server:
  ```bash
  ping <backend-server-ip>
  telnet <backend-server-ip> 3306
  ```

---

#### 6. **Installing MySQL Client on HAProxy**
- Install the MySQL client utility:
  ```bash
  sudo apt install mysql-server
  sudo systemctl status mysql
  ```

---

#### 7. **Testing the Setup**
- Connect to the MySQL backend through HAProxy:
  ```bash
  mysql -h localhost -u haproxy_check -p
  ```

---

#### 8. **Adding More Backend Servers**
- Update the HAProxy configuration to include additional backend servers:
  ```haproxy
  server mysql_backend_2 <new-server-ip>:3306 check
  ```
- Create the `haproxy_check` user on each new server.

---

### **Advantages of HAProxy Load Balancing**
- Distributes load effectively, reducing the risk of server overloading.
- Simplifies scaling by allowing new servers to be added with minimal changes.
- Provides robust health checks to monitor backend server availability.
