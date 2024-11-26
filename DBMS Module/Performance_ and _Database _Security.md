# Performance and Database Security


## Agenda of the Lecture

- **Topics to Cover**:
  1. Introduction
  2. Creation of Certificates
  3. Audit Logging


## Introduction

### SQL Monitoring: Then and Now

**[Ask Learners] How did monitoring work 4–5 years ago?**  
In earlier times, monitoring relied on simple scripts and Linux utilities to track critical metrics such as CPU usage, memory consumption, and database size. Modern tools like Grafana have since streamlined this process by visualizing data more effectively.

### Key Metrics for Monitoring

1. **CPU Usage**:
   - Tracks how much processing power the database consumes.

2. **Memory Usage**:
   - Command to monitor memory:
     ```bash
     free -h
     ```

3. **Database Size**:
   - Command to calculate database size:
     ```bash
     sudo mysql -u root -e "SELECT table_schema AS 'Database', SUM(data_length + index_length)/1024/1024 AS 'Size (MB)' FROM information_schema.TABLES GROUP BY table_schema;"
     ```

### Creating a Basic Monitoring Script

Example script to log CPU, memory, and database size:
```bash
#!/bin/bash
echo "Logging system metrics..."
echo "CPU Usage:" >> sql_monitor.log
top -b -n1 | grep "Cpu(s)" >> sql_monitor.log
echo "Memory Usage:" >> sql_monitor.log
free -h >> sql_monitor.log
echo "Database Sizes:" >> sql_monitor.log
sudo mysql -u root -e "SELECT table_schema AS 'Database', SUM(data_length + index_length)/1024/1024 AS 'Size (MB)' FROM information_schema.TABLES GROUP BY table_schema;" >> sql_monitor.log
```
- Save the script as `logs_monitor_script_sql.sh` and execute:
  ```bash
  chmod +x logs_monitor_script_sql.sh
  ./logs_monitor_script_sql.sh
  ```

### Securing the Database Installation

1. Use the `mysql_secure_installation` utility to enhance security:
   ```bash
   sudo mysql_secure_installation
   ```
   - Prompts include:
     - Remove anonymous users.
     - Disallow remote root login.
     - Remove test database.
     - Strengthen password requirements.

2. Example configuration:
   ![image](https://hackmd.io/_uploads/S1OPTIvMkg.png)

### Modern Monitoring Tools

- **Grafana**:
  - Collects and visualizes data from databases.
  - Enhances monitoring by providing intuitive dashboards.



## Creation of Certificates

### What Are Certificates?

Certificates authenticate servers and secure communications between clients and servers. MySQL supports SSL certificates to ensure secure database connections.

### Creating SSL Certificates

1. **Prepare Directory**:
   - Create a directory for certificates:
     ```bash
     sudo mkdir /etc/mysql/certs
     sudo chmod 700 /etc/mysql/certs
     sudo chown mysql:mysql /etc/mysql/certs
     ```

2. **Generate CA Key**:
   ```bash
   openssl genrsa 2048 > /etc/mysql/certs/ca-key.pem
   ```

3. **Create a CA Certificate**:
   ```bash
   openssl req -new -x509 -nodes -days 365 -key /etc/mysql/certs/ca-key.pem -out /etc/mysql/certs/ca-cert.pem -subj "/CN=MySQL_CA"
   ```

4. **Create a Server Key**:
   - Generate a server key for MySQL:
     ```bash
     openssl genrsa 2048 > /etc/mysql/certs/server-key.pem
     openssl req -new -key /etc/mysql/certs/server-key.pem -out /etc/mysql/certs/server-req.pem -subj "/CN=MySQL_Server"
     ```

5. **Sign the Server Certificate**:
   ```bash
   openssl x509 -req -new -in /etc/mysql/certs/server-req.pem -days 365 -CA /etc/mysql/certs/ca-cert.pem -CAkey /etc/mysql/certs/ca-key.pem -set_serial 01 -out /etc/mysql/certs/server-cert.pem
   ```

6. **Secure Certificates**:
   ```bash
   sudo chmod 600 /etc/mysql/certs/*.pem
   sudo chown mysql:mysql /etc/mysql/certs/*.pem
   ```

### Configuring MySQL to Use SSL

1. Edit the MySQL configuration file:
   ```bash
   sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
   ```
   - Add certificate paths:
     ```
     ssl-ca=/etc/mysql/certs/ca-cert.pem
     ssl-cert=/etc/mysql/certs/server-cert.pem
     ssl-key=/etc/mysql/certs/server-key.pem
     ```

2. Restart MySQL:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl restart mysql
   ```

3. Verify SSL:
   ```sql
   SHOW VARIABLES LIKE 'have_ssl';
   SHOW VARIABLES LIKE 'ssl_%';
   ```


## Audit Logging

### What is Audit Logging?

Audit logging tracks system and database activities to maintain security and operational oversight. It is crucial for identifying unauthorized access and understanding system changes.

### Key Benefits

1. **User Login Attempts**:
   - Logs successful and failed login attempts, identifying potential unauthorized access.
   
2. **Query Execution**:
   - Tracks all executed queries, helping in change audits.

3. **Administrative Actions**:
   - Records user creation, deletion, and permission changes for accountability.

### Implementation

1. **Use Audit Plugins**:
   - Plugins like `audit_log` in MySQL provide detailed logs of user actions.

2. **Enable Audit Logging**:
   - Add to the MySQL configuration file:
     ```
     plugin-load-add=audit_log.so
     audit_log_policy=ALL
     audit_log_file=/var/log/mysql_audit.log
     ```

3. **Restart MySQL**:
   ```bash
   sudo systemctl restart mysql
   ```

4. **Review Logs**:
   - Check audit logs for user activities:
     ```bash
     cat /var/log/mysql_audit.log
     ```

## Comparing Server and CA Certificates

| **Feature**             | **Server Certificate**                                                   | **CA Certificate**                                           |
|--------------------------|--------------------------------------------------------------------------|--------------------------------------------------------------|
| **Purpose**              | Authenticates a specific server for secure communication.               | Establishes trust for server certificates.                   |
| **Role in Security**     | Used for client-server data exchange security.                          | Validates and signs server certificates.                     |
| **Usage**                | Applied in HTTPS, SSL, and TLS connections.                             | Used in creating and verifying server and client certificates. |

