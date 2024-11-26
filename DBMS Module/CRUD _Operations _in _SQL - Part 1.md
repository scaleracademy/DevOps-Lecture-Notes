## Topics to be discussed

- **CREATE**: Adding new data to a table.  
- **READ**: Retrieving and viewing data from a table.  
- **UPDATE**: Modifying existing data in a table (covered in Part 2).  
- **DELETE**: Removing data from a table (covered in Part 2).  

---

## CREATE Operation  

The **CREATE** operation allows you to add new entries (rows) to a table in the database. The **INSERT** statement is used to perform this operation.  

### Syntax of INSERT Command:  
```sql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES 
    (value1, value2, value3, ...),
    (value1, value2, value3, ...),
    (value1, value2, value3, ...);
```

### Key Points:  
1. The values must correspond to the column order specified in the `INSERT` statement.  
   Example:  
   ```sql
   INSERT INTO employees (first_name, last_name, email)
   VALUES ('John', 'Doe', 'john.doe@example.com');
   ```  

2. If you do not specify the column names, values will be inserted into the table columns in the order they were defined during table creation.  
   Example:  
   ```sql
   INSERT INTO employees
   VALUES (1, 'John', 'Doe', 'john.doe@example.com', 'HR');
   ```  

3. **NULL and DEFAULT Values**:  
   - If a column value is not provided or explicitly set as **NULL**, the value of that column will be `NULL`.  
   - If the column has a **DEFAULT** value, using the `DEFAULT` keyword will assign that value to the column.  
     Example:  
     ```sql
     INSERT INTO employees (first_name, last_name, department)
     VALUES ('Jane', 'Smith', DEFAULT);
     ```  

---

## READ Operation  


The **READ** operation retrieves data from a table, typically using the **SELECT** statement. This operation allows you to extract specific columns, filter rows, or apply conditions to obtain the required data.  

### Basic Syntax of SELECT Command:  
1. **Select All Columns**:  
   ```sql
   SELECT * FROM employees;
   ```  

2. **Select Specific Columns**:  
   ```sql
   SELECT first_name, last_name FROM employees;
   ```  

3. **Using Column Aliases**:  
   You can rename columns in the result set using aliases for better readability.  
   ```sql
   SELECT first_name AS fname, last_name AS lname FROM employees;
   ```  
   Note: Aliases are temporary and do not alter the actual column names in the table.  

### Selecting Distinct Values  
To eliminate duplicate rows, use the **DISTINCT** keyword.  
Example:  
```sql
SELECT DISTINCT job_title FROM employees;
```  

### Selecting Constant Values  
You can include constant values in your result set along with table columns.  
Example:  
```sql
SELECT first_name, 'Employee' AS role FROM employees;
```  
This query returns each employee's first name along with the constant value `'Employee'` under the column "role".  

### Inserting Data from Another Table  
You can copy data from one table to another using the **INSERT INTO ... SELECT** statement.  
Example:  
```sql
INSERT INTO archived_employees (first_name, last_name, email)
SELECT first_name, last_name, email
FROM employees;
```   

---

## WHERE Clause  

The **WHERE** clause is used to filter rows based on specific conditions, allowing you to retrieve only the relevant data from a table.  

### Syntax of WHERE Clause:  
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```  

### Examples of WHERE Clause:  
1. **Simple Condition**:  
   Retrieve employees with a salary greater than 50,000.  
   ```sql
   SELECT first_name, last_name, salary
   FROM employees
   WHERE salary > 50000;
   ```  

2. **Multiple Conditions (AND/OR)**:  
   Combine conditions using **AND** or **OR** operators.  
   ```sql
   SELECT first_name, last_name, salary
   FROM employees
   WHERE salary > 50000 AND department = 'Sales';
   ```  
   This query retrieves employees with a salary greater than 50,000 who work in the Sales department.  

3. **Using NOT**:  
   Exclude specific rows using the **NOT** operator.  
   ```sql
   SELECT first_name, last_name, department
   FROM employees
   WHERE NOT department = 'HR';
   ```  
   This query retrieves employees who are not part of the HR department.  

4. **Using IN Clause**:  
   The **IN** operator allows you to specify multiple possible values for a column.  
   ```sql
   SELECT first_name, last_name, department
   FROM employees
   WHERE department IN ('HR', 'Sales', 'Finance');
   ```  
   This query retrieves employees working in HR, Sales, or Finance departments.  

### Key Points about WHERE Clause:  
- Conditions can include comparisons (`>`, `<`, `=`, etc.), ranges (`BETWEEN`), and patterns (`LIKE`).  
- Combine multiple conditions for more complex queries.  

**[Message for Instructor]**: Demonstrate queries using different WHERE clauses, showing how conditions refine the result set.  

---

## Summary of Part 1  

1. **CREATE** operation: Adds new rows to a table using the **INSERT** statement.  
2. **READ** operation: Retrieves data from a table using the **SELECT** statement, with options for filtering and formatting the results using aliases, DISTINCT, and WHERE clauses.  
3. Demonstrated the syntax and practical examples for:  
   - Adding data to tables.  
   - Retrieving data with and without filters.  
   - Using the WHERE clause to refine data selection.  

In the next session, we will cover:  
- **UPDATE** operation: Modifying existing rows.  
- **DELETE** operation: Removing data from tables.  
