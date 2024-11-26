# SQL Administration

## Agenda of the Lecture

- **Topics to Cover**:
  1. User and Permission Management
  2. Maintenance Tasks in MySQL
  3. Monitoring the Database
  4. Managing Logs and Cleanup
  5. Optimizing Performance and Automation


## User and Permission Management

### Responsibilities of a DevOps Engineer

- Manage access to production environments.
- Ensure proper permission assignment, data security, and backups.
- Perform performance tuning and monitor database usage.

### Authentication vs. Authorization

- **Authentication**: Verifies the user's identity (e.g., using a username and password).
  - Example: Checking an ID to confirm entry to a building.
- **Authorization**: Determines what an authenticated user can do or access.
  - Example: Restricting access to certain floors in a building even after verifying the ID.

**Key Considerations**:
- Protect sensitive data from unauthorized access.
- Mitigate risks of internal threats by clearly defining and managing permissions.

### Creating Users and Assigning Permissions

**Create a New User**:
```sql
CREATE USER 'username'@'host' IDENTIFIED BY 'password';
```
- Example:
  ```sql
  CREATE USER 'John'@'%' IDENTIFIED BY 'Pass';
  ```
  - `@'host'`: Restricts the user to a specific IP (e.g., `@192.168.1.100`).
  - `@'%'`: Allows access from any IP.

**Granting Permissions**:
```sql
GRANT SELECT, INSERT ON database_name.* TO 'username'@'host';
```
- **Revoke Permissions**:
  ```sql
  REVOKE ALL PRIVILEGES ON database_name.* FROM 'username'@'host';
  ```

**Managing Roles**:
- **Create and Assign Roles**:
  ```sql
  CREATE ROLE 'developer_role';
  GRANT SELECT, UPDATE ON database_name.* TO 'developer_role';
  GRANT 'developer_role' TO 'username'@'host';
  ```

**Best Practice**:
- Use roles to simplify and standardize permission management for groups of users.



## Maintenance Tasks in MySQL

### Importance of Database Maintenance

Regular maintenance ensures:
- Data availability and security.
- Fast recovery in case of system failure.
- Efficient database performance.

### Types of Backups

1. **Logical Backup**:
   - **Definition**: Exports database content (schema and data) in a human-readable format, such as SQL.
   - **Command**:
     ```bash
     mysqldump -u user -p database_name > backup.sql
     ```
   - **Use Case**: Short-term backup needs or for data transfer between servers.

2. **Physical Backup**:
   - **Definition**: Creates a binary copy of database files (e.g., `.ibd` files).
   - **Tool**: `rsync` for syncing data with minimal resource usage.
   - **Command**:
     ```bash
     rsync -av --progress /var/lib/mysql /backup_location/
     ```
   - **Use Case**: Long-term backup, faster for large databases.

**Choosing Between Logical and Physical Backups**:
- Logical backups are better for smaller databases and when a readable format is required.
- Physical backups are more efficient for large databases.



## Monitoring the Database

### Key Areas to Monitor

1. **Query Performance**:
   - Identify and optimize slow queries.
   - **Enable Slow Query Log**:
     ```sql
     SET GLOBAL slow_query_log = 'ON';
     SET GLOBAL long_query_time = 2;
     ```
   - **Analyze Logs**: Use `mysqldumpslow` to review slow queries.

2. **Replication Status**:
   - Monitor data synchronization between primary and replica servers.
   - **Command**:
     ```sql
     SHOW SLAVE STATUS\G;
     ```
   - **Metric**: `Seconds_Behind_Master` indicates replication lag.

3. **Resource Utilization**:
   - Monitor server resources like CPU, memory, and disk I/O.
   - **Commands**:
     ```sql
     SHOW GLOBAL STATUS LIKE 'Threads_connected';
     SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_reads';
     ```

4. **Optimizing Table Performance**:
   - **Analyze Tables**: Updates table statistics for better query optimization:
     ```sql
     ANALYZE TABLE table_name;
     ```
   - **Optimize Tables**: Reclaims unused space and improves efficiency:
     ```sql
     OPTIMIZE TABLE table_name;
     ```



## Managing Logs and Cleanup

### Types of Logs

1. **General Query Logs**:
   - Enable and specify the log file location:
     ```sql
     SET GLOBAL general_log = 'ON';
     SET GLOBAL general_log_file = '/var/log/mysqllog';
     ```

2. **Binary Logs**:
   - Used for replication and recovery.
   - **Purge Old Logs**:
     ```sql
     PURGE BINARY LOGS TO 'mysql_bin.00010';
     ```

### Importance of Log Cleanup

- Prevent logs from consuming excessive disk space.
- Use cron jobs to automate periodic log archiving and cleanup.



## Optimizing Performance and Automation

### SQL Performance Optimization

1. **Optimize MySQL Configurations**:
   - Example settings:
     ```ini
     max_connections = 200
     query_cache_size = 0
     ```

2. **Query Optimization**:
   - Use `EXPLAIN` to analyze queries:
     ```sql
     EXPLAIN SELECT column_name FROM table_name WHERE condition;
     ```
   - Avoid `SELECT *` to minimize data transfer.

3. **Indexing**:
   - Index frequently queried columns to speed up data retrieval.

4. **Enable Slow Query Logs**:
   - Identify and optimize slow queries:
     ```sql
     SET GLOBAL slow_query_log = 'ON';
     ```

### Automating Database Backups

**Script for Automating Backups**:
```bash
#!/bin/bash
USER="username"
PASSWORD="password"
DATABASE="database_name"
BACKUP_PATH="/path/to/backup/"
FILE_NAME="${DATABASE}_$(date +%F_%H-%M-%S).sql"

mysqldump -u $USER -p$PASSWORD $DATABASE > $BACKUP_PATH$FILE_NAME
```
- **Explanation**:
  - The script uses `mysqldump` to back up the database with a timestamped filename.
  - Backups are organized and saved to the specified path.

**Automating with Cron Jobs**:
- Schedule the script to run at regular intervals using cron:
  ```bash
  crontab -e
  ```
  Example cron job for daily backups at midnight:
  ```
  0 0 * * * /path/to/backup_script.sh
  ```

**Result**:
- Regular, automated backups ensure data availability and minimize manual effort.

![Backup Script Example](https://hackmd.io/_uploads/BJWVVYMzJg.png)
![Backup File Example](https://hackmd.io/_uploads/SyUCEtGG1l.png)

This setup allows for consistent, automated database backups, with file organization to aid in quick retrieval. You can schedule this script using cron jobs to automate the process, ensuring timely and reliable backups.
