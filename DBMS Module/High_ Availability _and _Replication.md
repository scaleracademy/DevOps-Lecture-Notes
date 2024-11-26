# High Availability and Replication

## Agenda of the Lecture

- **Topics to Cover**:
  1. High Availability
  2. Types of Replication in MySQL
  3. Live Demo
  4. Factors to Monitor in Replication


## High Availability

### Understanding High Availability

- **Definition**: High availability ensures a system remains operational and accessible despite failures, minimizing downtime and impact on services.
- **Example**: A bank with multiple branches can continue functioning if one branch is closed, as transactions shift to other locations. While there may be delays, complete downtime is avoided.

### Importance of High Availability

1. **Minimizing Downtime**: 
   - Reduces service unavailability.
   - Example: For global services like Google or Instagram, even seconds of downtime can be unacceptable. In contrast, banking systems may tolerate short delays.
   - Acceptable downtime must be defined based on the system's criticality.

2. **Protection Against Data Loss**:
   - **Data Redundancy**: Multiple copies of data in different locations protect against complete data loss.
   - Example: A library with backups in multiple locations minimizes losses in case of fire or disaster.

3. **Ensuring Continuous Operations**:
   - Systems remain online and accessible during hardware failures or maintenance tasks.

4. **Enhancing User Experience**:
   - Reliability reduces disruptions and ensures user trust.

### Key Components of High Availability Architecture in MySQL

1. **Replication**:
   - Data is copied across multiple servers.
   - Ensures availability during server failures by redirecting traffic to replicas.

2. **Failover**:
   - Automatic redirection from the primary server to a secondary server if the primary fails.
   - Balances traffic during outages.

3. **Load Balancing**:
   - Distributes incoming requests across servers to prevent overload.
   - Improves system stability and performance.


## Types of Replication in MySQL

### Overview

Replication in MySQL involves duplicating data between servers to ensure consistency, high availability, and disaster recovery.

### Types of Replication

1. **Source-Replica (Master-Slave) / Asynchronous Replication**:
   - **How It Works**: 
     - The master handles read/write operations.
     - Replicas handle only read operations, ensuring consistency.
   - **Key Characteristics**:
     - A **locking mechanism** prevents "dirty reads" during write operations.
     - Asynchronous: The master does not wait for replicas to sync before continuing.
   - **Failover**: A replica can be promoted to master if the original master fails.
   - **Diagram**:  
     ![image](https://hackmd.io/_uploads/H169uP5Zkx.png)

2. **Semi-Synchronous Replication**:
   - **How It Works**:
     - The primary server waits for at least one replica to acknowledge data receipt before proceeding.
   - **Pros**:
     - Ensures data reliability by confirming at least one replica has up-to-date information.
   - **Cons**:
     - Slower performance due to the acknowledgment process.
     - Affected by network delays.
   - **Diagram**:  
     ![image](https://hackmd.io/_uploads/SygZ9wcZ1g.png)

3. **Group Replication**:
   - **How It Works**:
     - A cluster of MySQL servers (multi-master setup) handles both read and write operations.
     - Data is replicated across all nodes.
   - **Benefits**:
     - Fault tolerance: Surviving nodes continue handling requests if one fails.
     - Ideal for systems requiring seamless failover and load balancing.

## Live Demo

### Objective

- Demonstrate how to set up replication between two MySQL servers.

### Steps

1. **Create Two Servers**:
   - Open two terminals and set up `server1` and `server2` with MySQL installed.

2. **Enable Binary Logging on `server1`**:
   - Edit the MySQL configuration file to enable binary logging and set the server ID.
   - **Command**:
     ```bash
     sudo systemctl restart mysql
     ```

3. **Create a Replication User**:
   - On `server1`:
     ```sql
     CREATE USER 'replicator'@'%' IDENTIFIED BY 'Devl@1234';
     GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';
     ```

4. **Lock Tables on `server1`**:
   - Use:
     ```sql
     FLUSH TABLES WITH READ LOCK;
     ```
   - Prevents writes while setting up replication.

5. **Configure `server2`**:
   - Edit `my.cnf` to point `server2` to `server1`:
     ```bash
     sudo vi /etc/mysql/my.cnf
     ```
   - Add:
     ```
     server-id = 2
     replicate-do-db = demo
     ```

6. **Start Replication**:
   - Run on `server2`:
     ```sql
     CHANGE MASTER TO
     MASTER_HOST='54.206.122.120',
     MASTER_USER='replicator',
     MASTER_PASSWORD='Devl@1234',
     MASTER_LOG_FILE='mysql-bin.000001',
     MASTER_LOG_POS=839;
     START SLAVE;
     ```

7. **Verify Replication**:
   - On `server2`:
     ```sql
     SHOW SLAVE STATUS\G;
     ```
   - Ensure replication is active and no errors are reported.

8. **Replication Test**:
   - Create a database and table on `server1`:
     ```sql
     CREATE DATABASE demo;
     USE demo;
     CREATE TABLE students (id INT, name VARCHAR(50));
     INSERT INTO students VALUES (1, 'John Doe');
     ```
   - Verify the data is replicated on `server2`.

9. **Network Configuration**:
   - Update MySQL configuration to allow external connections:
     ```bash
     sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
     ```
   - Set `bind-address` to `0.0.0.0`.

10. **Verify Connectivity**:
    - Test with:
      ```bash
      telnet 54.206.122.120 3306
      ```


## Factors to Monitor in Replication

### Key Metrics

1. **Replication Lag**:
   - Monitored using:
     ```sql
     SHOW REPLICA STATUS\G;
     ```
   - Indicates delays in data synchronization.
   - High lag can cause inconsistencies in read operations.

2. **Duplicate Key Errors**:
   - Occurs when duplicate entries are created due to replication delays.
   - Error logs can be reviewed:
     ```bash
     vi /var/log/mysql/error.log
     ```

3. **Network Issues**:
   - Network disruptions can halt replication.
   - Logs record errors related to connectivity issues.

### Best Practices

- Monitor logs regularly for replication errors or lag.
- Use alert systems to notify of issues in real-time.
- Test failover scenarios periodically to ensure readiness.
