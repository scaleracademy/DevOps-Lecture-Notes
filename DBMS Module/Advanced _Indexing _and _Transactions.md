# Advanced Indexing and Transactions


## Agenda of the Lecture

- **Topics to Cover**:
  1. Covering Index
  2. Composite Index
  3. Transactions
  4. Isolation Levels
  5. Live Demo

## Covering Index

### Understanding Covering Index

- **Definition**: A covering index in MySQL includes all columns needed for a query, allowing data retrieval directly from the index without accessing the main table.
- **Purpose**: Enhances performance by reducing table traversals and I/O operations.

### Benefits of Using a Covering Index

- **Reduced Table Access**: Queries retrieve results using only the index, lessening the load on the main table.
- **Faster Query Performance**: Optimized steps lead to quicker execution times.
- **Improved Cache Utilization**: Streamlined data access results in efficient caching.

#### Example of Covering Index

**SQL Syntax**:
```sql
CREATE INDEX idx_film_covering ON film (rating, rental_rate, title, release_year);
```

**Query Using the Index**:
```sql
SELECT title, release_year
FROM film
WHERE rating = 'PG-13' AND rental_rate = 2.99;
```

- **Effectiveness**:
  - The query fetches `title` and `release_year` without directly accessing the `film` table.
  - Filters on `rating` and `rental_rate` ensure minimal rows are traversed.

### Key Takeaways

- **Best Practice**: Use covering indexes for queries accessing frequently used column groups.
- **Execution**: MySQL prioritizes filtering (`WHERE`), then sorting (`ORDER BY`), leveraging the indexed columns.
- **Efficiency**: Creates a balance between performance improvement and storage costs.



## Composite Index

### What is a Composite Index?

- **Definition**: An index containing multiple columns, ideal for queries filtering on several row-based conditions.
- **Order Matters**: MySQL processes columns left-to-right; place frequently queried columns first.

#### Example of Composite Index

**SQL Syntax**:
```sql
CREATE INDEX idx_rental_customer_date ON rental (customer_id, rental_date);
```

**Query Example**:
```sql
SELECT rental_id, rental_date 
FROM rental 
WHERE customer_id = 123 
AND rental_date BETWEEN '2024-01-01' AND '2024-12-31';
```

- **Functionality**:
  - Filters on `customer_id` first, then narrows down using `rental_date`.
  - Significantly fewer rows are checked compared to non-indexed tables.

### Composite Index vs. Covering Index

| **Feature**         | **Composite Index**                         | **Covering Index**                                |
|----------------------|---------------------------------------------|--------------------------------------------------|
| **Purpose**          | Filters multiple columns (`WHERE`, `JOIN`) | Satisfies queries entirely using the index       |
| **Storage**          | Lower storage requirement                  | Higher storage requirement                       |
| **Usage**            | Efficient for partial column matches       | Requires all queried columns in the index        |

**Key Notes**:
- Use composite indexes for filtering across multiple columns.
- Opt for covering indexes when queries rely heavily on `SELECT` columns.

## Transactions

### Overview of Transactions

- **Definition**: A sequence of operations where either all succeed or none apply, ensuring consistency.
- **Steps**:
  1. Begin with `START TRANSACTION;`.
  2. Execute the required operations.
  3. Use `COMMIT` to finalize or `ROLLBACK` to revert.

#### Example

```sql
START TRANSACTION;
INSERT INTO rental (C1, C2, C3, C4) VALUES (A, B, C, D);
COMMIT;  -- Finalizes changes
ROLLBACK; -- Reverts if an issue arises
```

### SAVEPOINTs

- **Purpose**: Checkpoints within transactions to selectively roll back changes.
- **Example**:
  ```sql
  START TRANSACTION;
  INSERT INTO rental (C1, C2, C3, C4) VALUES (A, B, C, D);
  SAVEPOINT AFTER_INSERT;
  ```
  - Roll back to the savepoint with:
    ```sql
    ROLLBACK TO SAVEPOINT AFTER_INSERT;
    ```

### Key Notes

- SAVEPOINTs allow partial rollbacks.
- Releasing unused savepoints optimizes system resources:
  ```sql
  RELEASE SAVEPOINT AFTER_INSERT;
  ```


## Isolation Levels

### Importance of Isolation Levels

- **Objective**: Ensure that transactions do not interfere with one another, preserving data integrity.
- **Levels**:

1. **READ UNCOMMITTED**:
   - Uncommitted changes are visible to others (**Dirty Reads**).
   - Example: A change not finalized by User 1 is readable by User 2.

2. **READ COMMITTED**:
   - Only committed changes are visible.
   - Ensures users cannot see ongoing, uncommitted transactions.

3. **REPEATABLE READ**:
   - Guarantees consistent data during a transaction.
   - Example: A user’s view of the data remains unchanged, even if another user modifies it.

4. **SERIALIZABLE**:
   - Highest isolation level, ensuring transactions execute in a strict sequence.
   - Example: Transactions wait for preceding ones to finish before execution.

### Practical Usage

- **READ COMMITTED**: Suitable for most applications needing reliable data reads.
- **SERIALIZABLE**: Used in systems requiring strict accuracy, e.g., banking.


## Live Demo

### Objectives

- Demonstrate behavior across different isolation levels.

### Steps

1. **Setup**:
   - Open two terminals and log into the same database.

2. **READ COMMITTED Example**:
   - **Terminal 1**:
     ```sql
     START TRANSACTION;
     ```
     Update an entry without committing.
   - **Terminal 2**:
     Run the same query. Changes from **Terminal 1** are not visible until committed.

3. **SERIALIZABLE Example**:
   - **Terminal 1**:
     Start a transaction and make updates.
   - **Terminal 2**:
     Attempt to update the same data; transaction blocks until **Terminal 1** completes.

### Key Insights

- **READ COMMITTED**: Prevents dirty reads by hiding uncommitted changes.
- **SERIALIZABLE**: Ensures complete isolation but may delay transaction completion.

