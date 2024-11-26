## Topics to be discussed

- Advanced operators in the **READ** operation.  
- Additional clauses like **ORDER BY** and **LIMIT** for refining and controlling query results.  
- Modifying existing data using the **UPDATE** operation.  
- Removing data from tables with the **DELETE**, **TRUNCATE**, and **DROP** commands.  

---

## Operators in READ 

This section expands on the **READ** operation using advanced operators to filter, sort, and limit query results more effectively.

---

### 1. **BETWEEN Operator**  

The **BETWEEN** operator is used to filter records within a specified range. It works with numeric, date, and text data types.  

**Key Points**:  
- The range is **inclusive**, meaning it includes the boundary values.  
- It simplifies queries involving ranges.  

**Syntax**:  
```sql
SELECT column1, column2, ...
FROM table_name
WHERE column_name BETWEEN value1 AND value2;
```

**Example**: Retrieve employees with salaries between $40,000 and $70,000:  
```sql
SELECT first_name, last_name, salary
FROM employees
WHERE salary BETWEEN 40000 AND 70000;
```

---

### 2. **LIKE Operator**  

The **LIKE** operator filters rows based on patterns in text data. It is commonly used for partial matches and supports wildcard characters.  

**Wildcards**:  
- **%**: Matches any sequence of characters (including zero characters).  
- **_**: Matches exactly one character.  

**Syntax**:  
```sql
SELECT column1, column2, ...
FROM table_name
WHERE column_name LIKE pattern;
```

**Examples**:  
- To find employees whose first names start with "J":  
  ```sql
  SELECT first_name, last_name
  FROM employees
  WHERE first_name LIKE 'J%';
  ```
- To find employees whose last names have "a" as the second character:  
  ```sql
  SELECT first_name, last_name
  FROM employees
  WHERE last_name LIKE '_a%';
  ```
  
![LIKE Operator Example](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/096/925/original/regex1.png?1732040596)

---

### 3. **NULL Operator**  

The **NULL** operator checks for missing or unknown values in a column. SQL handles null values using **IS NULL** or **IS NOT NULL** because standard comparison operators cannot be used with NULL.

**Key Points About NULL**:  
- NULL is different from a zero or an empty string.  
- Use `IS NULL` or `IS NOT NULL` to filter rows with or without null values.  

**Syntax**:  
- Checking for NULL:  
  ```sql
  SELECT column1, column2, ...
  FROM table_name
  WHERE column_name IS NULL;
  ```
- Checking for NOT NULL:  
  ```sql
  SELECT column1, column2, ...
  FROM table_name
  WHERE column_name IS NOT NULL;
  ```

**Example**: Retrieve employees with no email addresses:  
```sql
SELECT first_name, last_name
FROM employees
WHERE email IS NULL;
```

---

### 4. **ORDER BY Clause**  

The **ORDER BY** clause sorts query results based on one or more columns. Sorting can be done in ascending (**ASC**) or descending (**DESC**) order.  

**Syntax**:  
```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;
```

**Examples**:  
1. Sort employees by salary in ascending order:  
   ```sql
   SELECT first_name, last_name, salary
   FROM employees
   ORDER BY salary;
   ```
2. Sort by department (ascending) and salary (descending) within each department:  
   ```sql
   SELECT first_name, last_name, department, salary
   FROM employees
   ORDER BY department ASC, salary DESC;
   ```

**ORDER BY with DISTINCT**:  
Retrieve distinct job titles and sort them alphabetically:  
```sql
SELECT DISTINCT job_title
FROM employees
ORDER BY job_title ASC;
```

---

### 5. **LIMIT Clause**  

The **LIMIT** clause restricts the number of rows returned by a query, often used for pagination or fetching a subset of data.  

**Syntax**:  
```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column_name [ASC|DESC]
LIMIT number_of_rows;
```

**Examples**:  
1. Retrieve the top 5 highest-paid employees:  
   ```sql
   SELECT first_name, last_name, salary
   FROM employees
   ORDER BY salary DESC
   LIMIT 5;
   ```
2. Use LIMIT with OFFSET for pagination:  
   ```sql
   SELECT first_name, last_name, salary
   FROM employees
   ORDER BY salary DESC
   LIMIT 5 OFFSET 5;
   ```
   This retrieves the second group of 5 highest-paid employees.  

---

## UPDATE Operation  

**Duration**: 10 minutes  

The **UPDATE** statement modifies existing records in a table.  

**Syntax**:  
```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

**Key Points**:  
- Always use a **WHERE** clause to specify which rows to update. Omitting it will update all rows in the table.  

**Examples**:  
1. Update an employee's salary and job title:  
   ```sql
   UPDATE employees
   SET salary = 85000, job_title = 'Senior Developer'
   WHERE employee_id = 102;
   ```

---

## DELETE Operation  

**Duration**: 10 minutes  

The **DELETE** statement removes records from a table.  

**Syntax**:  
```sql
DELETE FROM table_name
WHERE condition;
```

**Key Points**:  
- Use a **WHERE** clause to specify which rows to delete.  
- Omitting the WHERE clause will delete all rows in the table but retain the table structure.  

**Examples**:  
1. Delete a specific employee by ID:  
   ```sql
   DELETE FROM employees
   WHERE employee_id = 101;
   ```
2. Delete all rows in a table:  
   ```sql
   DELETE FROM employees;
   ```

---

## TRUNCATE Command  

The **TRUNCATE** command removes all rows from a table but retains the table structure. It is faster than DELETE because it performs minimal logging.  

**Syntax**:  
```sql
TRUNCATE TABLE table_name;
```

**Example**:  
```sql
TRUNCATE TABLE employees;
```

---

## DROP Command  

The **DROP** command completely removes a table, database, or schema from the system.  

**Syntax**:  
```sql
DROP TABLE table_name;
DROP DATABASE database_name;
```

**Example**:  
- Remove the `employees` table:  
  ```sql
  DROP TABLE employees;
  ```

---

## Differences: DELETE, TRUNCATE, DROP  

| Feature               | DELETE                      | TRUNCATE                  | DROP                      |
|-----------------------|-----------------------------|---------------------------|---------------------------|
| **Purpose**           | Remove specific rows        | Remove all rows           | Remove entire table/schema|
| **Table Structure**   | Retained                   | Retained                  | Deleted                   |
| **Speed**             | Slower                     | Faster                    | Irrelevant                |
| **Transaction Support** | Yes                     | Limited                   | No                        |
| **Use Case**          | Remove certain records      | Clear all data quickly    | Permanently remove table/database |

---

## Summary  

1. **Advanced Operators**: BETWEEN, LIKE, NULL, ORDER BY, and LIMIT enhance the flexibility of the **READ** operation.  
2. **UPDATE**: Modify existing data with precision using the SET and WHERE clauses.  
3. **DELETE**: Remove specific rows or all rows from a table, retaining its structure.  
4. **TRUNCATE**: Quickly remove all rows, resetting the table.  
5. **DROP**: Permanently delete a table or database, including its structure.  
