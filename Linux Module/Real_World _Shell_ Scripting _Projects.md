# Typed Notes on Real-World Shell Scripting Projects

## 1. Implementing the Password Script

### Objective:
To implement a script that validates passwords based on the following conditions:
- Password must be longer than 8 characters.
- Must contain at least one uppercase letter.
- Must contain at least one lowercase letter.
- Must contain at least one number.

### Steps:

#### Step 1: Taking Input
We will first prompt the user to enter a password using the `read` command with the `-s` flag (to hide the input for privacy).

```bash
read -s -p "Enter your password: " user_pass
echo
```

- The `-s` flag hides the password input.
- `echo` creates an empty line after input for better readability.

#### Step 2: Calling the Validation Function
Next, we call a function to validate the password entered by the user:

```bash
validate_password() {
  # Function logic will be written here
}

read -s -p "Enter your password: " user_pass
echo
validate_password "$user_pass"
```

Here, `validate_password` takes the `user_pass` variable as an argument.

#### Step 3: Defining the `validate_password` Function

1. **Local Variable for Password**  
   Inside the function, we use a local variable `password` to capture the first argument (`$1`) passed to the function.

    ```bash
    validate_password() {
        local password="$1"
    }
    ```

2. **Checking if the Password is Greater than 8 Characters**
    Use `${#password}` to check the length of the password. If it’s less than 8, the script returns a failure message.

    ```bash
    if [ ${#password} -lt 8 ]; then
        echo "Weak Password"
        return 1
    fi
    ```

3. **Checking for Uppercase Letters**
    Use regular expressions to validate if the password contains at least one uppercase letter:

    ```bash
    if ! [[ "$password" =~ [A-Z] ]]; then
        echo "Weak Password"
        return 1
    fi
    ```

4. **Checking for Lowercase Letters**
    Similarly, we check for lowercase letters:

    ```bash
    if ! [[ "$password" =~ [a-z] ]]; then
        echo "Weak Password"
        return 1
    fi
    ```

5. **Checking for Numbers**
    We check if the password contains at least one numeric character:

    ```bash
    if ! [[ "$password" =~ [0-9] ]]; then
        echo "Weak Password"
        return 1
    fi
    ```

6. **Returning Success for Strong Passwords**
    If all the conditions are met, the script will output a message indicating the password is strong.

    ```bash
    echo "Strong Password"
    ```

### Final Script:

```bash
validate_password() {
  local password="$1"
  
  if [ ${#password} -lt 8 ]; then
    echo "Weak Password"
    return 1
  fi

  if ! [[ "$password" =~ [A-Z] ]]; then
    echo "Weak Password"
    return 1
  fi

  if ! [[ "$password" =~ [a-z] ]]; then
    echo "Weak Password"
    return 1
  fi

  if ! [[ "$password" =~ [0-9] ]]; then
    echo "Weak Password"
    return 1
  fi

  echo "Strong Password"
}

read -s -p "Enter your password: " user_pass
echo
validate_password "$user_pass"
```

### Explanation:
- The script checks all conditions for password strength.
- If any condition fails, it returns "Weak Password."
- A "Strong Password" message is displayed if all checks pass.

---

## 2. Basic Aspects of Scripting

### Elements of Scripting:
1. **Clear Objective**: Before starting, understand the task and what the script needs to accomplish.
2. **Flowchart**: Plan the flow of the script with a flowchart to better visualize and structure the logic.
3. **Modular Code**: Break down your script into reusable functions. For example, the `validate_password` function can be reused in other scripts.
4. **Comments**: Always include comments to explain key parts of the script. This helps in future maintenance and readability.

---

## 3. Real-World Project: Backup Script

### Objective:
To write a script that takes a backup of a user-specified directory in either `zip` or `tar.gz` format, with a timestamp added to the filename.

### Key Features of the Script:
1. **User Input**: The user specifies the directory and the compression method (`zip` or `tar`).
2. **Timestamp**: A timestamp is added to the backup filename for easy identification of when the backup was created.
3. **Error Handling**: The script checks if the directory exists and if the compression method is valid.

### Final Script:

```bash
# Function to display usage information
usage() {
    echo "Usage: $0 [-d directory] [-c compression (zip|tar)]"
    exit 1
}

# Parse options
while getopts ":d:c:" opt; do
  case $opt in
    d) directory=$OPTARG ;;
    c) compression=$OPTARG ;;
    \?) usage ;;
  esac
done

# Check if directory is specified and exists
if [[ -z "$directory" ]] || [[ ! -d "$directory" ]]; then
    echo "Error: Directory is not specified or does not exist."
    usage
fi

# Validate compression method
if [[ "$compression" != "zip" ]] && [[ "$compression" != "tar" ]]; then
    echo "Error: Compression method must be 'zip' or 'tar'."
    usage
fi

# Generate a timestamp
timestamp=$(date +'%Y-%m-%d_%H-%M-%S')

# Set filename based on the chosen compression method
if [[ "$compression" == "zip" ]]; then
    archive_name="${directory}_${timestamp}.zip"
    # Compress directory with zip
    zip -r "$archive_name" "$directory"
elif [[ "$compression" == "tar" ]]; then
    archive_name="${directory}_${timestamp}.tar.gz"
    # Compress directory with tar
    tar -czvf "$archive_name" "$directory"
fi

# Check if compression was successful
if [[ $? -ne 0 ]]; then
    echo "Error: Compression failed."
    exit 1
fi

echo "Archive created: $archive_name"
echo "Backup process completed successfully."
exit 0
```

### Explanation:
1. **Usage Function**: The script begins with a `usage` function that shows how to run the script.
2. **Option Parsing**: `getopts` is used to parse command-line options. The user provides the directory with `-d` and the compression type (`zip` or `tar`) with `-c`.
3. **Directory Check**: The script checks if the directory exists using `[[ -d "$directory" ]]`.
4. **Compression Validation**: It ensures the user selects either `zip` or `tar` for the compression method.
5. **Timestamp Creation**: The `timestamp` variable holds the current date and time to add to the backup file's name.
6. **File Compression**: Depending on the chosen compression method, either `zip` or `tar` is used.
7. **Success Check**: The script checks if the compression command was successful using `$?`.

### Practice Problem:
A script to automate this backup process to run every day at 11:00 AM, and store the backups in a designated directory.
