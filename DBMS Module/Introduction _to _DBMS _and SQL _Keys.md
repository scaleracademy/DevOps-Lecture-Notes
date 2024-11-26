## Topics to be discussed
 
- Issues with using files as a database  
- Types of databases: relational and non-relational  
- Essential properties of Relational Database Management Systems (RDBMS)  
- A detailed discussion on keys in RDBMS: Super, Candidate, Primary, Composite, and Foreign Keys  
- Practical demonstration: Running MySQL in Linux  

---

## Issue with File as a Database  

### Why Files Alone are Inefficient for Databases  
Using files as standalone data storage presents significant challenges:  

1. **Fetching Data is Inefficient**:  
   Searching for specific data in files requires sequential processing, making it slow as the file size grows. For example, retrieving a customer's transaction history from a text file may require scanning through thousands of lines.  

2. **Lack of Data Integrity**:  
   Files do not enforce data consistency. This means unrelated or incorrect data types can be mixed. For example, transaction records may inadvertently include audio files, leading to confusion and errors.  

3. **No Concurrency Control**:  
   Files do not allow multiple users to safely access and modify data at the same time. If two users update the same file, one user’s changes might overwrite the other's, causing data loss.  

### Introduction to Databases and DBMS  
To overcome these issues, we use **Databases**, which are structured collections of related data designed for efficient access and management.  

A **Database Management System (DBMS)** is software that enables the following:  
- Organized storage and retrieval of data.  
- Creating, updating, and deleting records while ensuring integrity and consistency.  
- Handling concurrent access efficiently, ensuring that data remains accurate even with multiple users.  

---

## Types of Databases  
Databases are broadly categorized based on how they store and manage data:  

### 1. **Relational Databases**  
- Relational databases store data in a tabular format, using rows and columns. Each table represents an entity, and relationships between tables are established using keys.  
- Data is structured with a **strict schema**, ensuring consistency.  
- Relationships among tables are defined, enabling complex queries and operations.  

**Examples**:  
- **MySQL**: Popular open-source database for web applications.  
- **PostgreSQL**: Known for its robustness and support for advanced data types.  
- **Oracle**: Enterprise-grade database with advanced features for large-scale applications.  

### 2. **Non-relational Databases**  
- Non-relational databases, also called **NoSQL databases**, store data in formats such as documents, key-value pairs, or graphs instead of tables.  
- They may or may not enforce a strict schema, providing flexibility in data storage.  
- These databases are often used in scenarios requiring high scalability and performance, such as real-time data processing.  

**Examples**:  
- **MongoDB**: Document-based database suitable for unstructured data.  
- **Redis**: Key-value store optimized for speed.  
- **Cassandra**: Distributed database designed for handling large amounts of data.  

---

## Properties of Relational Database Management Systems (RDBMS)  

An RDBMS is a system designed to manage data stored in relational databases. It adheres to several key properties:  

1. **Collection of Tables**:  
   Data is stored in multiple tables, each representing a distinct entity. For example, an "Employees" table stores employee details, while a "Departments" table stores department information.  

2. **Unique Rows**:  
   Each row in a table must be unique, meaning there is always a way to distinguish one record from another. For instance, an employee’s unique ID ensures no duplication.  

3. **Consistent Data Types**:  
   Columns in a table must have a consistent data type. For example, a "Salary" column cannot store both numeric values and text.  

4. **Atomic Values**:  
   Each cell in a table contains a single, indivisible value. For example, a "Full Name" column cannot store both first and last names together if they need to be searched individually.  

5. **Unordered Column Sequence**:  
   The sequence of columns in a table is not guaranteed to remain the same when data is retrieved, allowing flexibility in queries.  

---

## Keys in RDBMS  

Keys play a crucial role in relational databases, ensuring that data is uniquely identifiable and that relationships between tables are maintained effectively.  

### 1. **Super Key**  
- A **super key** is any set of columns in a table that can uniquely identify a row.  
- It may include additional attributes beyond the minimal requirement for uniqueness.  

**Example**:  
In an "Employees" table with columns: EmployeeID, FirstName, LastName, Email, and PhoneNumber:  
- A super key could be a combination of EmployeeID + Email or EmployeeID + PhoneNumber.  


### 2. **Candidate Key**  
- A **candidate key** is a minimal super key, meaning no additional attributes are included.  
- A table can have multiple candidate keys, but only one is chosen as the primary key.  

**Example**:  
From the super keys above, if "EmployeeID" alone is sufficient to uniquely identify a row, it becomes a candidate key.  

### 3. **Primary Key**  
- A **primary key** is a specific candidate key selected to uniquely identify records.  
- It is essential for ensuring data integrity.  

**Characteristics**:  
- Should be small in size for efficiency.  
- Enables fast sorting and retrieval.  

### 4. **Composite Key**  
- A **composite key** consists of two or more columns that, together, uniquely identify a row.  
- For example, in a "CourseEnrollment" table, the combination of StudentID and CourseID can serve as a composite key.  

### 5. **Foreign Key**  
- A **foreign key** is a column in one table that refers to a primary key in another table, establishing a relationship between the two tables.  

**Orphaning in Foreign Keys**:  
If a referenced row in the parent table is deleted, the rows in the child table pointing to it become "orphaned" (referencing non-existent data).  

**MySQL Constraints to Handle Orphaning**:  
- **CASCADE**: Deletes or updates related rows in the child table automatically.  
- **SET NULL**: Sets the foreign key column to `NULL` when the referenced row is deleted.  
- **SET DEFAULT**: Assigns a default value when the referenced row is deleted.  
- **NO ACTION**: Prevents deletion of the referenced row if child rows exist (default behavior).  

---

## Running MySQL in Linux  

### Basic Commands to Get Started  

1. **Creating a Database**:  
   ```sql
   CREATE DATABASE mydatabase;
   ```
   Creates a database named "mydatabase".  

2. **Selecting the Database**:  
   ```sql
   USE mydatabase;
   ```
   Sets "mydatabase" as the active database for subsequent commands.  

3. **Creating a Table**:  
   Example:  
   ```sql
   CREATE TABLE students (
       id INT AUTO_INCREMENT,
       firstName VARCHAR(50) NOT NULL,
       lastName VARCHAR(50) NOT NULL,
       email VARCHAR(100) UNIQUE NOT NULL,
       dateOfBirth DATE NOT NULL,
       enrollmentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       psp DECIMAL(3, 2) CHECK (psp BETWEEN 0.00 AND 100.00),
       batchId INT,
       isActive BOOLEAN DEFAULT TRUE,
       PRIMARY KEY (id)
   );
   ```  

4. **Describing the Table**:  
   ```sql
   DESCRIBE students;
   ```
   Displays the structure of the "students" table.  

5. **Dropping a Table (If Exists)**:  
   ```sql
   DROP TABLE IF EXISTS students;
   ```
   Deletes the table "students" if it exists.  
