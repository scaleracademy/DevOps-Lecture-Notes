
# Introduction to Operating Systems (Continued)

## Agenda of the Lecture
### Overview
Today’s session will cover the following topics:
- A **small quiz** to review previous concepts.
- Introduction to **more Linux commands**.
- Understanding **file permissions** in Linux.
- Learning how to use the **Vim editor**.

---

## Quizzes

### Quiz 1: Linux Filesystem Hierarchy
**Question:** Which of the following directories is NOT part of the Linux filesystem hierarchy?
- /bin
- **/exe**
- /var
- /etc

**Answer Explanation:** The `/exe` directory does not exist in the Linux filesystem hierarchy. Common directories include `/bin`, which stores essential binaries, `/var` for variable data files, and `/etc`, which contains system configuration files.

### Quiz 2: Viewing Directory Contents
**Question:** Which command is used to view the contents of a directory in Linux?
- view
- **ls**
- open
- dir

**Answer Explanation:** The `ls` command is used in Linux to list the files and directories within a directory. The other options are either incorrect or pertain to different operating systems or applications.

### Quiz 3: Functions of the Operating System
**Question:** Which of the following is NOT a function of the Operating System?
- Memory Management
- **Virus Scanning**
- Process Management
- Device Management

**Answer Explanation:** Virus scanning is typically handled by specialized antivirus software, not by the operating system itself. OS functions include memory management, process management, and device management.

---

# More Commands

## Revising Previous Commands
Before learning new commands, let's quickly revise the commands from the last session:
```bash
ls
pwd
cd /bin
cd ..
mkdir
mkdir -p test/test2/
```
### Useful Tips:
- **Tab Auto-Completion**: Pressing the Tab key can auto-complete commands or filenames, saving time.
- **Absolute vs. Relative Path**:
  - **Absolute Path**: Specifies the complete path from the root directory to the desired file (e.g., `cd /bin`).
  - **Relative Path**: Specifies the path relative to the current directory (e.g., `cd bin` when you are in the parent directory).

## Learning More Commands

### Deleting Directories
- **Remove an Empty Directory**:
    ```bash
    rmdir test
    ```
- **Recursively and Forcefully Delete a Directory**:
    ```bash
    rm -rf test
    ```
    - **Caution**: This command permanently deletes the directory and all its contents without confirmation.

### Copying Files and Directories
- **Copy a File**:
    ```bash
    cp test.sh /tmp/
    ```
    - Copies `test.sh` to the `/tmp/` directory.
- **Copy a Directory Recursively**:
    ```bash
    cp -r scalar /tmp/
    ```
    - Copies the `scalar` directory and all its subdirectories to `/tmp/`.

### Moving and Renaming Files/Directories
- **Move a Directory**:
    ```bash
    mv scalar /tmp/
    ```
    - Moves the `scalar` directory to `/tmp/`.
- **Rename a File**:
    ```bash
    mv test.sh abc.sh
    ```
    - Renames `test.sh` to `abc.sh`.

### Creating Files
- **Create an Empty File**:
    ```bash
    touch filename.txt
    ```
- **Create a File with Content**:
    ```bash
    echo "text" > filename.txt
    ```
    - Creates `filename.txt` containing the text "text".
- **Append Content to a File**:
    ```bash
    echo "additional text" >> filename.txt
    ```
    - Adds "additional text" to `filename.txt` without removing existing content.

### Reading File Content
- **Display File Content**:
    ```bash
    cat filename.txt
    ```
- **Show First Two Lines of a File**:
    ```bash
    head -n 2 filename.txt
    ```
- **Show Last Two Lines of a File**:
    ```bash
    tail -n 2 filename.txt
    ```
- **Monitor a File in Real-Time**:
    ```bash
    tail -f filename.txt
    ```
    - Continuously monitors `filename.txt` for updates.

### Checking Disk and Memory Usage
- **Check Disk Space Usage**:
    ```bash
    df
    df -h
    ```
    - `df` displays disk usage in bytes, while `df -h` converts this to a human-readable format (e.g., MB, GB).
- **Check Directory Size**:
    ```bash
    du -sh
    ```
    - Displays the size of the current directory and its subdirectories.
- **Check RAM Usage**:
    ```bash
    free
    free -h
    ```
    - `free` shows RAM usage in bytes, while `free -h` gives a human-readable output. This data is gathered from the `/proc/meminfo` file, which provides detailed memory information.

---

# Vim Editor

## Introduction to Vim
Vim is a powerful text editor commonly used in Linux. It offers multiple modes and commands for efficient text editing.

### Opening Vim
- **Open Vim**:
    ```bash
    vim
    ```
- **Open a Specific File**:
    ```bash
    vim filename
    ```

### Modes in Vim
Vim operates in several modes:
1. **Normal Mode**: The default mode for navigation and command execution. Press `Esc` to return to Normal Mode from any other mode.
2. **Insert Mode**: Used for text input. Enter Insert Mode by pressing any of these keys: `i`, `I`, `a`, `A`, `o`, `O`.
3. **Visual Mode**: Used for text selection. Enter Visual Mode by pressing `v`, `V`, or `Ctrl-v`.
4. **Command-Line Mode**: Used to execute commands like saving or searching. Enter this mode by pressing `:`.

### Navigating in Vim
- **Mouse Navigation**:
    - On Windows: Use *Shift + Left Click*.
    - On Mac: Use *Option + Left Click*.
- **Keyboard Navigation**:
    - `h`: Move left.
    - `j`: Move down.
    - `k`: Move up.
    - `l`: Move right.
    - `0`: Move to the beginning of the line.
    - `$`: Move to the end of the line.
    - `gg`: Go to the beginning of the file.
    - `G`: Go to the end of the file.
    - `:n`: Go to line `n`.

### Saving and Quitting
- **Save and Quit**:
    ```bash
    :wq
    ```
- **Quit Without Saving**:
    ```bash
    :q!
    ```
- **Save File**:
    ```bash
    :w
    ```
- **Save with a Different Name**:
    ```bash
    :w newfilename
    ```

### Selecting and Manipulating Text
- **Copy Selected Text**:
    1. Enter Visual Mode by pressing `v`.
    2. Select the desired text.
    3. Press `y` to copy.

### Deleting Text
- **Delete a Line**:
    ```bash
    dd
    ```
- **Delete a Character**:
    ```bash
    x
    ```
    - Deletes the character under the cursor.
- **Delete from Cursor to End of Line**:
    ```bash
    d$
    ```

### Searching in Vim
- **Forward Search**:
    ```bash
    /pattern
    ```
- **Backward Search**:
    ```bash
    ?pattern
    ```
- **Next Occurrence**:
    ```bash
    n
    ```
- **Previous Occurrence**:
    ```bash
    N
    ```

### Find and Replace
- **Replace Text Globally**:
    ```bash
    :%s/old/new/g
    ```
    - Replaces every occurrence of `old` with `new` in the entire file.
