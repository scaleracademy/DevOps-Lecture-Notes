# Design Shell Scripts

---

## Agenda of the Lecture
The focus of today's lecture is on designing shell scripts, exploring various concepts such as bracket types, functions, variable scope, arrays, case statements, and I/O redirection. The session will also involve practical examples to demonstrate each concept in action.

---

## Brackets in Shell Scripting

In shell scripting, different types of brackets are used for various operations. Understanding the use of each bracket is essential for writing efficient and correct scripts. Let’s explore the specific purposes of each bracket type.

### Curly Braces: `{}`

- **Purpose**: Curly braces are used to clearly indicate where a variable begins and where it ends in a shell script. Without braces, the shell might misinterpret parts of a variable name, especially when adjacent to other characters or strings.
  
  - **Example**:  
    When you have a variable `name` set to "Deepak", using braces ensures that the shell recognizes it correctly:
    ```bash
    name="Deepak"
    echo ${name}  # Output: Deepak
    ```
    Here, the curly braces `{}` tell the shell to treat `name` as a complete variable.

- **Use case for sequence expansion**: Curly braces are also very useful for generating sequences or patterns. For example, if you want to create or list multiple files with similar names, this can be done easily using curly braces.
  
  - **Example**:  
    The command below prints file names ranging from `file1.txt` to `file100.txt`:
    ```bash
    echo file{1..100}.txt
    ```
    This will output:
    ```
    file1.txt file2.txt ... file100.txt
    ```
    This is particularly helpful when you need to work with a large number of files or perform batch operations.

### Parentheses: `()`

- **Purpose**: Parentheses are used in shell scripting to execute a command and capture its output. This process is known as command substitution.

  - **Example**:  
    The following script captures the current date using the `date` command and stores it in the variable `today`:
    ```bash
    today=$(date)
    echo $today  # Outputs today's date
    ```
    Here, `$(date)` runs the `date` command and assigns its output to the variable `today`. This differs from directly assigning `$date`, which would only refer to a variable called `date`, not the output of the `date` command.

- **Key difference**:  
  If you use `$date` or `${date}` without parentheses, the shell will interpret it as a variable, not as a command to be executed. For example:
  ```bash
  today=$date
  ```
  In this case, `$date` must have been previously defined as a variable. Otherwise, it will result in an empty value or an error.

### Square Brackets: `[]`

- **Purpose**: Square brackets are primarily used for evaluating conditions in shell scripts, particularly within `if` statements and loops.

  - **Example for conditional evaluation**:  
    The following condition checks if a variable `number` is greater than or equal to 90, and based on the result, prints a grade:
    ```bash
    if [ $number -ge 90 ]; then
      echo "A"
    fi
    ```

- **Use with arrays**:  
  Square brackets are also used to access elements within arrays. For example, if you have an array of fruits:
  ```bash
  fruits=("Apple" "Banana" "Cherry")
  ```
  You can access the second element (`Banana`) using square brackets like this:
  ```bash
  echo ${fruits[1]}  # Output: Banana
  ```
  Notice how square brackets specify the index, and curly braces are used to reference the variable itself.

### Double Parentheses: `(())`

- **Purpose**: Double parentheses are used for arithmetic operations within shell scripts. Unlike single parentheses, double parentheses allow you to perform mathematical calculations directly.

  - **Example**:  
    The following script performs an addition operation and stores the result in the `sum` variable:
    ```bash
    ((sum=5+3))
    echo ${sum}  # Output: 8
    ```
    This syntax simplifies mathematical operations, making them easier to write and read.

---

## Functions in Shell Scripting

Functions allow you to define reusable blocks of code in shell scripts. They help structure code and make it easier to maintain by encapsulating specific tasks. Here’s how to define, call, and manage functions in shell scripts.

### Defining a Function

There are two common syntaxes for defining functions in shell scripts:

1. Without the `function` keyword:
    ```bash
    function_name() {
      # commands
    }
    ```

2. Using the `function` keyword:
    ```bash
    function function_name {
      # commands
    }
    ```

Both syntaxes are valid, and you can use either depending on your preference. Here’s an example of a function that accepts two arguments and prints them:
```bash
function_name() {
  echo "Parameter 1 is $1"
  echo "Parameter 2 is $2"
}
```
- `$1` refers to the first argument passed to the function, and `$2` refers to the second argument.

### Calling a Function

To call a function, simply use its name followed by any arguments:
```bash
function_name "arg1" "arg2"
```
This will print:
```
Parameter 1 is arg1
Parameter 2 is arg2
```

### Return Values from Functions

Shell functions can return values using the `return` statement. By default, functions return an exit status (0 for success, non-zero for failure).

- **Example**:
    ```bash
    function_name() {
      # commands
      return 0  # Explicitly return success
    }
    ```
    After calling the function, you can check the exit status using `$?`:
    ```bash
    function_name
    echo "Return state: $?"  # Output: 0
    ```
    The `$?` variable holds the exit status of the last executed command or function.

---

## Variables and Their Scope in Shell Scripting

Variables in shell scripts can either be **global** or **local**, depending on where they are defined and how they are used.

### Global Variables

A global variable is accessible throughout the entire script, including within functions. It is defined outside any function and can be referenced anywhere in the script.

- **Example**:
    ```bash
    global_var="I am global"
    ```

### Local Variables

A local variable is only accessible within the function where it is defined. It is declared using the `local` keyword, and its scope is limited to that function.

- **Example**:
    ```bash
    function_1() {
      local local_var="I am local"
      echo $global_var $local_var
    }
    ```

### Scope Example

Consider the following script:
```bash
global_var="I am global"
function_1(){
    local local_var="I am local"
    echo $global_var $local_var
}
echo $global_var $local_var  # Error: local_var not accessible here
function_1()  # Output: I am global I am local
```

- In this example, the variable `global_var` is accessible both inside and outside the function, but `local_var` is only accessible within `function_1`.
- Predict the output of the above script:
- First, the global variable will print "I am global", but accessing `local_var` outside the function will produce an error.
- Then, when the function `function_1()` is executed, it will print "I am global I am local" because both variables are accessible within the function.

---

## Array Arguments in Shell Scripting

Arrays allow you to store multiple values in a single variable. Shell scripting provides simple methods to handle arrays.

### Printing an Array

To print all elements of an array, you use the `@` symbol. It expands the array into its individual elements.

- **Example**:
    ```bash
    numbers=(1 2 3 4 5)
    print_numbers(){
        echo "Numbers: $@"
    }
    print_numbers "${numbers[@]}"
    ```
    Output:
    ```
    Numbers: 1 2 3 4 5
    ```

- The `${numbers[@]}` expands all the elements of the array `numbers`, and `echo $@` prints them as separate arguments.

**Instructor’s Note**: Demonstrate the practical use of this command by running it in the terminal.

### Printing Array Elements in a Loop

If you want to print each number on a separate line, you can use a loop:
```bash
for num in "${numbers[@]}"; do
  echo $num
done
```
This will output:
```
1
2
3
4
5
```

---

## Case Statements in Shell Scripting

Case statements in shell scripts are used to handle multiple conditions in a structured and readable way. They are particularly useful when working with flags or multiple possible input options.

### Example: Handling Flags with Case

Suppose you have a function that processes data based on different options:
```bash
process_data(){
  local option="$1"
  case $option in
    -d) echo "Deleting data";;
    -s) echo "Saving data";;
    *) echo "Invalid option";;
  esac
}
process

_data -d  # Output: Deleting data
```
- In this example, when `-d` is passed as an argument, the function prints "Deleting data". For `-s`, it prints "Saving data". If any other option is passed, it prints "Invalid option".

### Homework

- Write a script to calculate the area of a rectangle.
- Write a script that accepts a password as input and checks if it meets the following conditions:
  - Contains at least one uppercase letter.
  - Contains at least one lowercase letter.
  - Contains at least one number.
  - Is longer than 8 characters.

---

## I/O Redirection in Shell Scripting

I/O redirection allows you to control where input and output data is sent. It’s essential for managing files and error handling in scripts.

### Types of I/O Redirection

1. **`>` (Output Redirection)**:
    - Redirects standard output to a file, overwriting the file if it exists.
    - **Example**:
      ```bash
      echo "Hello World" > file.txt
      ```
      This command writes "Hello World" to `file.txt`.

2. **`<` (Input Redirection)**:
    - Redirects input from a file to a command.
    - **Example**:
      ```bash
      sort < users.txt
      ```
      This command takes the contents of `users.txt` and passes it to the `sort` command.

3. **`>>` (Append Output)**:
    - Appends output to a file without overwriting it.
    - **Example**:
      ```bash
      echo "Additional text" >> file.txt
      ```
      This adds "Additional text" to `file.txt`, preserving its existing contents.

4. **`2>` (Error Redirection)**:
    - Redirects error messages to a file.
    - **Example**:
      ```bash
      ls non_existent_file 2> error_log.txt
      ```
      This captures the error message generated by trying to list a non-existent file and writes it to `error_log.txt`.

5. **`&>` (Output and Error Redirection)**:
    - Redirects both standard output and errors to a file.
    - **Example**:
      ```bash
      command &> output_and_errors.txt
      ```
      This captures both the output and any errors produced by the command.

6. **`tee` (Read and Write to Multiple Destinations)**:
    - The `tee` command reads from standard input and writes to both standard output and one or more files.
    - **Example**:
      ```bash
      echo "Data" | tee file1.txt file2.txt
      ```
      This writes "Data" to both `file1.txt` and `file2.txt`.
