# Typed Notes on Introduction to Shell Scripting

## Agenda of the Lecture

Today's lecture will cover a range of essential topics related to shell scripting. These include:

1. **Types of Shell** – A detailed exploration of the various types of shells available in Linux, including their paths and purposes.
2. **PATH** – Understanding the importance of the `$PATH` environment variable, how it works, and how to modify it.
3. **Wildcards** – Learning about wildcard characters and how they are used in shell scripting to manipulate and interact with file names.
4. **Control Structures** – Examining control structures such as if-else statements, loops, and case statements, which allow for logical flow in scripts.

---

## Types of Shell

### What is a Shell?

Before diving into the specific types of shells, it’s crucial to understand what a **shell** is in the context of Linux. A shell is a command-line interface (CLI) that allows users to interact with the operating system by typing commands. The shell interprets these commands and communicates them to the system kernel for execution. In essence, the shell acts as a bridge between the user and the operating system.

There are multiple shells available in Linux, each with its own features and advantages. While users can install and use a variety of shells, two shells are predominantly used in most environments: **sh (Bourne Shell)** and **bash (Bourne Again Shell)**. These shells are located in the `/bin/` directory, with their names as part of the path (e.g., `/bin/sh`, `/bin/bash`).

### Common Shell Types in Linux

1. **sh (Bourne Shell)**:
   - **Path:** `/bin/sh`
   - The Bourne Shell is one of the oldest and most fundamental shells in Unix. It is widely supported and provides basic scripting capabilities. Although many users prefer more feature-rich shells today, the Bourne Shell is still significant for its portability and simplicity.
   
2. **bash (Bourne Again Shell)**:
   - **Path:** `/bin/bash`
   - Bash is an improved version of the original Bourne Shell and is one of the most commonly used shells in modern Linux distributions. It includes advanced scripting capabilities, enhanced command-line features, and is backward compatible with the Bourne Shell. Bash is used for the majority of shell scripting tasks, making it the de facto standard for many users.

3. **ksh (Korn Shell)**:
   - **Path:** `/bin/ksh`
   - The Korn Shell was developed as a comprehensive shell that combines features of the Bourne Shell and the C Shell. It includes improved performance and scripting capabilities, making it a preferred shell for many Unix users.

4. **csh (C Shell)**:
   - **Path:** `/bin/csh`
   - The C Shell uses a syntax similar to the C programming language. It is popular among users who are comfortable with C-style syntax, and it introduces features like aliasing and job control.

5. **tcsh (Tenex C Shell)**:
   - **Path:** `/bin/tcsh`
   - Tcsh is an enhanced version of the C Shell that adds features such as command-line completion and command history, making it more user-friendly for interactive use.

6. **zsh (Z Shell)**:
   - **Path:** `/bin/zsh`
   - Zsh is known for its advanced interactive features, such as spell correction, improved tab completion, and plugin support. It is often preferred by users who want a customizable and feature-rich shell.

7. **fish (Friendly Interactive Shell)**:
   - **Path:** `/bin/fish`
   - Fish is designed to be user-friendly with syntax highlighting, auto-suggestions, and simple configuration. It aims to provide an easy-to-use interactive experience for new users.

### Key Differences Between `bash` and `sh`

- **Bash (`/bin/bash`)**: Bash provides numerous enhancements over `sh`, including extended scripting capabilities, better error handling, and additional features such as arrays, functions, and user-friendly command-line editing.
- **Sh (`/bin/sh`)**: Sh refers to the standard Bourne Shell. While it’s less feature-rich than Bash, it remains a standard for many Unix-based systems due to its simplicity and portability.

### Creating a Simple Script in `bash`

To illustrate how these shells work, we can create a simple script using `bash`. Follow these steps:

1. **Open a terminal** and navigate to your home directory.
2. **Create a new directory** for your scripts using the following command:
   ```bash
   mkdir intro_scripts; cd intro_scripts
   ```
   This command will create a directory named `intro_scripts` and navigate into it using the `cd` command.
   
3. **Open or create a new script** file using the `vi` text editor:
   ```bash
   vi 1st_script.sh
   ```
   This opens the Vi editor, allowing you to create and edit files directly in the terminal.

4. **Write a simple script** in the file:
   ```bash
   #!/bin/bash
   echo "Hello, World!"
   ```
   - The first line `#!/bin/bash` is known as the **shebang**. It tells the operating system which shell to use to interpret the script. In this case, it specifies the `bash` shell.
   - The second line is a simple command that outputs the text "Hello, World!" to the terminal.

5. **Save and exit** the editor by typing `:wq`.

6. **Change the file permissions** to make the script executable:
   ```bash
   chmod 744 1st_script.sh
   ```
   The `chmod` command changes the permissions of the file, allowing the owner to read, write, and execute it, and others to read it.

7. **Execute the script** using the following command:
   ```bash
   ./1st_script.sh
   ```
   This will run the script, and you should see the output:
   ```
   Hello, World!
   ```

---

## PATH Environment Variable

### What is `$PATH`?

The `$PATH` is an important **environment variable** in Linux that defines a list of directories where executable files are located. When you enter a command into the terminal, the shell searches these directories to find the corresponding executable file. This allows you to run commands like `ls`, `echo`, or `mkdir` without specifying their full paths.

For example, when you type `ls`, the shell looks in the directories listed in `$PATH` to find the `ls` executable. If the shell finds the executable, it runs the command; if not, you will see an error indicating that the command was not found.

### Viewing the Current `$PATH`

You can see the current `$PATH` by typing the following command:
```bash
echo $PATH
```
This will output a list of directories separated by colons (`:`), like this:
```
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin
```
Each directory in this list is checked sequentially whenever you run a command in the shell.

### Modifying the `$PATH`

You can modify the `$PATH` variable to add or remove directories. This is useful when you want to include custom directories where you store executable scripts or programs.

- **Appending to the `$PATH`:**
   ```bash
   export PATH="$PATH:/new/directory"
   ```
   This command adds `/new/directory` to the existing `$PATH`, meaning the shell will now look in this directory for executables when you run commands.

- **Replacing the `$PATH`:**
   ```bash
   export PATH="/new/directory"
   ```
   This will replace the current `$PATH` entirely with `/new/directory`, so you’ll need to specify all required directories manually if you use this method.

By appending directories rather than replacing them, you ensure that essential system directories remain in the `$PATH`, preventing issues with system commands.

---

## Wildcards in Shell Scripting

Wildcards are special characters used in shell scripting and command-line operations to represent one or more characters. They allow you to efficiently interact with multiple files or directories at once, making your scripts more flexible and powerful.

### Common Wildcards

1. **`*` (Asterisk)**:  
   - This wildcard matches zero or more characters in a file name.
   - Example:  
     ```bash
     echo test*
     ```
     This command will display all files in the current directory that start with the word "test". For example, if your directory contains `test1.txt`, `test2.log`, and `testing`, they will all be listed.

2. **`[]` (Brackets)**:  
   - Brackets are used to match a single character within the specified range or set of characters.
   - Example:  
     ```bash
     echo file[1-3]
     ```
     This will output `file1`, `file2`, and `file3` if these files exist. The range `[1-3]` matches any single digit between 1 and 3.

### Escape Characters

Escape characters allow you to include special characters in your output or to alter the behavior of the shell.

- **`\n`**: Inserts a new line.
- **`\\`**: Inserts a backslash (`\`) in the output.
- **`\"`**: Allows double quotes to be included in a string.
   - Example:  
     ```bash
     echo "My name is \"Deepak\""
     ```
     This will output:
     ```
     My name

 is "Deepak"
     ```

### Variables in Shell Scripting

- **Local Variables**: These variables exist only within the script and are not accessible outside it.  
   - Example:
     ```bash
     user_name="Ram"
     ```
     Here, the `user_name` variable is assigned the value "Ram", but this value is only available within the script where it is defined.

- **Global (Environment) Variables**: These variables are accessible throughout the entire system and can be used by any process or script.  
   - Example:
     ```bash
     export PATH
     ```
     This command makes changes to the `$PATH` variable system-wide, meaning they will affect the environment even after the script finishes executing.

---

## Control Structures in Shell Scripting

Control structures are essential in shell scripting for managing the flow of execution based on conditions or iterations. These structures help scripts make decisions, repeat actions, or respond to specific input.

### 1. **If-Else Statement**

The `if-else` statement is used to execute commands conditionally. If the specified condition is true, the commands inside the `if` block will run. Otherwise, the commands inside the `else` block will execute.

#### Syntax:
```bash
if [ condition ]; then
    # commands to execute if the condition is true
else
    # commands to execute if the condition is false
fi
```
#### Example:
```bash
if [ -f /etc/passwd ]; then
    echo "File exists"
else
    echo "File does not exist"
fi
```
This script checks whether the file `/etc/passwd` exists. If it does, the message "File exists" will be printed; otherwise, "File does not exist" will be printed.

### 2. **For Loop**

The `for` loop is used to iterate over a series of values. It allows you to execute a set of commands repeatedly for each value in the list.

#### Syntax:
```bash
for item in list; do
    # commands to execute for each item
done
```
#### Example:
```bash
for file in *.txt; do
    echo "Processing $file"
done
```
This loop iterates over all `.txt` files in the current directory and prints "Processing" followed by the file name.

### 3. **While Loop**

The `while` loop executes a set of commands as long as the specified condition is true.

#### Syntax:
```bash
while [ condition ]; do
    # commands to execute while the condition is true
done
```
#### Example:
```bash
counter=1
while [ $counter -le 5 ]; do
    echo "Counter: $counter"
    counter=$((counter + 1))
done
```
This loop prints the value of the `counter` variable five times, incrementing it with each iteration.

### 4. **Case Statement**

The `case` statement allows for multi-branch decision-making. It compares a variable or expression against multiple patterns and executes commands based on the first matching pattern.

#### Syntax:
```bash
case $variable in
    pattern1) 
        # commands to execute if $variable matches pattern1
        ;;
    pattern2)
        # commands to execute if $variable matches pattern2
        ;;
    *)
        # default commands if no patterns match
        ;;
esac
```
#### Example:
```bash
read -p "Enter a letter: " letter
case $letter in
    [a-z])
        echo "You entered a lowercase letter."
        ;;
    [A-Z])
        echo "You entered an uppercase letter."
        ;;
    *)
        echo "Invalid input."
        ;;
esac
```
This script checks the input from the user and responds based on whether the input is a lowercase letter, an uppercase letter, or something else.
