## Topics to be discussed

- Understanding JOINS in SQL.  
- Types of JOINS and their applications, including INNER JOIN, OUTER JOIN (LEFT, RIGHT, FULL), CROSS JOIN, and NATURAL JOIN.  
- Additional concepts: SELF JOIN, USING clause, ON vs. WHERE clause, and UNION.  

---

## JOINS in SQL  

When working with databases, data is often spread across multiple related tables. Joins enable us to combine data from these tables to create a meaningful dataset.  

### Example Scenario  

Consider a database for Scaler with the following tables:  

1. **Batches Table**  
   Stores batch details.  
   ![Batches Table](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/096/926/original/one.png?1732041132)  

2. **Students Table**  
   Stores student details.  
   ![Students Table](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/096/927/original/two.png?1732041169)  

**Problem**: Retrieve a table with two columns — the student’s `FirstName` and the `batchName` they are studying in.  

**Solution**: A single table cannot fulfill this requirement. This is where **JOINS** come into play. Joins combine rows from the `students` table and `batches` table based on a specified condition.  

### How JOINS Work  

Think of JOINS as "stitching" two tables together by combining rows that meet a specific condition.  
- **Condition**: Rows are combined where `students.batch_id = batches.batch_id`.  

**SQL Query**:  
```sql
SELECT students.FN, batches.batch_name 
FROM students
JOIN batches
ON students.batch_id = batches.batch_id;
```

---

### SELF JOIN  

A **SELF JOIN** is used when a table needs to reference itself.  

**Example Scenario**:  
Consider a `students` table with a `buddy_id` column, where each student is assigned a buddy (another student).  
![Students Table](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/096/928/original/three.png?1732041202)  

**Goal**: Retrieve the name of each student along with their buddy’s name.  

**Solution**: Use SELF JOIN to join the table to itself.  
- `s1` and `s2` are aliases representing the same table.  

**SQL Query**:  
```sql
SELECT s1.name AS StudentName, s2.name AS BuddyName
FROM students s1
JOIN students s2
ON s1.buddy_id = s2.id;
```

---

### COMBINED JOINS  

A **COMBINED JOIN** uses multiple conditions to join tables.  

**Example Scenario**:  
Compare movies from a `films` table, selecting pairs where one film was released within two years of the other.  
![Films Table](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/096/929/original/four.png?1732041225)  

**SQL Query**:  
```sql
SELECT f1.title AS Film1, f2.title AS Film2
FROM films f1
JOIN films f2
ON f1.release_year <= f2.release_year + 2
   AND f1.release_year >= f2.release_year - 2;
```

---

## Types of JOINS in SQL  

### 1. **INNER JOIN**  

An **INNER JOIN** returns only the rows where there is a match between both tables based on the join condition.  

**Example**: Retrieve students and their batch names.  
```sql
SELECT students.FN, batches.batch_name 
FROM students
INNER JOIN batches
ON students.batch_id = batches.batch_id;
```

---

### 2. **OUTER JOIN**  

An **OUTER JOIN** includes all rows from one or both tables, replacing missing values with `NULL` where there is no match.  

#### a) **LEFT JOIN**  
- Returns all rows from the left table and the matching rows from the right table.  
- If no match is found, columns from the right table are filled with `NULL`.  

**Example**:  
```sql
SELECT * 
FROM students s
LEFT JOIN batches b
ON s.batch_id = b.batch_id;
```
This query returns all students, even if they are not assigned to a batch.  

#### b) **RIGHT JOIN**  
- Returns all rows from the right table and the matching rows from the left table.  
- If no match is found, columns from the left table are filled with `NULL`.  

#### c) **FULL JOIN**  
- Combines results of both LEFT and RIGHT JOINs, returning all rows from both tables.  

---

### 3. **CROSS JOIN**  

A **CROSS JOIN** combines every row from one table with every row from another table, creating a Cartesian product.  

**Example**:  
```sql
SELECT * 
FROM students s
CROSS JOIN batches b;
```
If the `students` table has 5 rows and the `batches` table has 4 rows, the result will contain 5 × 4 = 20 rows.  

![CROSS JOIN Example](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/096/930/original/five.png?1732041266)

---

### 4. **NATURAL JOIN**  

A **NATURAL JOIN** automatically joins two tables based on columns with the same name and compatible data types.  
- It assumes the common column names as the join condition, eliminating the need for an `ON` clause.  

**Example**:  
```sql
SELECT * 
FROM students s
NATURAL JOIN batches b;
```
If both tables share a column like `batch_id`, the NATURAL JOIN will use it as the join condition.  

---

### USING Clause  

The **USING** clause specifies a common column for the join when its name is the same in both tables.  

**Example**:  
```sql
SELECT * 
FROM students
JOIN batches
USING (batch_id);
```
This query is equivalent to:  
```sql
SELECT * 
FROM students
JOIN batches
ON students.batch_id = batches.batch_id;
```

![USING Clause Example](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/096/931/original/six.png?1732041308)

---

## ON Clause vs. WHERE Clause  

The **ON** and **WHERE** clauses serve different purposes in SQL queries:  

| **Aspect**          | **ON Clause**                                    | **WHERE Clause**                                |
|---------------------|-------------------------------------------------|------------------------------------------------|
| **Purpose**         | Specifies how tables should be joined.           | Filters the rows in the result set after the join. |
| **Execution Order** | Applied during the join operation.               | Applied after the join operation is complete.  |
| **Use Case**        | To define relationships between tables.           | To filter the final results based on conditions. |

**Example**:  
- Use **ON** to join `students` and `batches`:  
  ```sql
  SELECT * 
  FROM students s
  LEFT JOIN batches b
  ON s.batch_id = b.batch_id;
  ```
- Use **WHERE** to filter rows where the batch name is "DSA":  
  ```sql
  SELECT * 
  FROM students s
  LEFT JOIN batches b
  ON s.batch_id = b.batch_id
  WHERE b.batch_name = 'DSA';
  ```

---

## UNION  

The **UNION** operator combines result sets from two or more `SELECT` queries into a single result set, eliminating duplicate rows by default.  

**Syntax**:  
```sql
SELECT column1, column2, ...
FROM table1
UNION
SELECT column1, column2, ...
FROM table2;
```

### Key Features:  
- Columns in the queries must have the same number and compatible data types.  
- To include duplicate rows, use **UNION ALL**.  

**Example**:  
```sql
SELECT first_name, last_name
FROM students
UNION
SELECT first_name, last_name
FROM alumni;
```

![UNION Example](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/096/932/original/seven.png?1732041334)

---

## Summary  

1. **Joins**: Essential for combining data from multiple tables based on conditions.  
2. **Types of Joins**:  
   - **INNER JOIN**: Matches rows between tables.  
   - **OUTER JOIN**: Includes unmatched rows with `NULL` values.  
   - **CROSS JOIN**: Produces Cartesian products.  
   - **NATURAL JOIN**: Automatically matches based on common columns.  
3. **ON vs. WHERE**: Define table relationships using `ON`, filter results using `WHERE`.  
4. **UNION**: Combines query results, eliminating duplicates unless `UNION ALL` is used.  

By understanding these concepts, you can efficiently manage and query relational databases to gain deeper insights from your data.
