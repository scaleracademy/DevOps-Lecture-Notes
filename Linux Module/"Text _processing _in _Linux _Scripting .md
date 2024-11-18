# Typed Notes on Text Processing in Linux Scripting

---

## What is Text Processing?

Text processing involves the manipulation and analysis of text from files and documents. This can include extracting specific information, searching for patterns, or even transforming the data. When dealing with large sets of files, it is impractical to manually sift through the text to locate relevant information. Text processing tools automate this process, making it faster and more efficient.

Linux provides several powerful tools for text processing, including:

1. **Grep**: A utility for searching plain-text data for lines that match a regular expression.
2. **Awk**: A versatile language for pattern scanning and processing, often used to extract fields from text.
3. **Sed**: A stream editor that can filter and transform text, often used for substitution or deletion of text.

![Image](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/089/383/original/Screenshot_2024-09-12_085456.png?1726111555)

---

## Grep: Searching with Patterns

`grep` is a command-line utility used to search for patterns within files. This is done by specifying a pattern or regular expression (regex), along with a file or multiple files to search through.

### Syntax:
```bash
grep [options] 'pattern' filename
```

For example, to search for the word "error" in a file named `log.txt`, you would use the following command:

```bash
grep 'error' log.txt
```

### Common `grep` options:

- **-i**: Perform a case-insensitive search. This means that both "Error" and "error" will be considered a match.
- **-n**: Display the line number where the match occurs. This is helpful when you need to pinpoint exactly where in the file the pattern appears.
- **-c**: Count the number of matching lines, instead of displaying them.
- **-B, -A, -C**: These options allow you to display additional lines around a match:
    - **-B (before)**: Shows lines that occur before the matching line.
    - **-A (after)**: Shows lines that occur after the matching line.
    - **-C (context)**: Displays lines before and after the matching line.

    #### Example: 
    If you have an error message on line 5 in `abc.log`, you can display lines before and after the match:

    ```bash
    grep -C 2 "error" abc.log
    ```
    This command will show the line with the error, along with two lines before and two lines after it.

    ![Example Image](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/089/388/original/Screenshot_2024-09-12_091155.png?1726112523)

- **-v**: Invert the search to return all lines **except** those that match the pattern.
    - **Example**: 
        ```bash
        grep -v "error" abc.log
        ```
        This command will display all lines except those that contain the word "error."

- **-E**: Enables the use of extended regular expressions, allowing you to search for multiple patterns.
    - **Example**: 
        ```bash
        grep -E 'error|warning' abc.log
        ```
        This will return lines containing either "error" or "warning".

---

## Sed: Stream Editor

`sed` is a powerful stream editor used to filter and transform text. Unlike `grep`, which only searches for text, `sed` can also modify the contents of a file.

### Searching and Replacing Text:

A common use of `sed` is to replace text. Consider a scenario where you've written an essay about animals using the word "cat" repeatedly, but now you want to replace "cat" with "dog."

- **Example:**
    ```bash
    sed 's/cat/dog/' essay.txt
    ```

    This command searches for the first occurrence of "cat" on each line and replaces it with "dog". However, it only replaces the **first** occurrence of "cat" in each line.

### In-Place Editing:

If you want to edit the file in-place (modifying the original file), you can use the `-i` option:
```bash
sed -i 's/cat/dog/' essay.txt
```

This will replace "cat" with "dog" directly in the `essay.txt` file without creating a backup.

### Global Replacement:

To replace **every** occurrence of "cat" with "dog" in the file, add the `g` (global) flag:
```bash
sed 's/cat/dog/g' essay.txt
```

This command ensures that all occurrences of "cat" on each line are replaced.

### Deleting Lines:

You can also use `sed` to delete lines based on a pattern match. For example, to delete lines containing the word "error":
```bash
sed '/error/d' log.txt
```

This will remove all lines that contain "error" from the output.

---

## Awk: Pattern Scanning and Processing

`awk` is another tool used in text processing, particularly for dealing with text structured in columns or fields. It reads input line by line and splits each line into fields based on a delimiter (default is whitespace).

### Syntax:
```bash
awk '{print $Column_Number}' filename
```

#### Example:
If a file contains the line:
```
my name is abc
```
You can print the second field (word "name") by using:
```bash
awk '{print $2}' filename
```

### Custom Field Separators:

By default, `awk` uses whitespace as the field separator. However, you can specify a different delimiter using the `-F` option.

#### Example:
```bash
awk -F '.' '{print $1}' filename
```

In this example, `.` is set as the field separator, and the command will print the first field of each line split by `.`.

### Reading Specific Ranges of Lines:

`awk` can also be used to extract a range of lines between two patterns:
```bash
awk '/start_pattern/,/end_pattern/' filename
```

#### Example:
This will display lines between the occurrences of "start" and "end" in the file.

![Example Image](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/089/417/original/Screenshot_2024-09-12_124501.png?1726125313)

---

## Regular Expressions (Regex) for Pattern Matching

Regular expressions are a language used for text processing and pattern matching. They allow for powerful searches by defining complex patterns.

### Basic Regex Operators:

1. **Dot (.)**: Matches any single character.
    - **Example**: The pattern `a.c` will match "abc", "aac", "adc", etc.

2. **Caret (^)**: Anchors the search to the **start** of a line.
    - **Example**: The pattern `^abc` will match lines that start with "abc".

3. **Dollar ($)**: Anchors the search to the **end** of a line.
    - **Example**: The pattern `abc$` will match lines that end with "abc".

### Character Classes and Ranges:

- **Character Classes**: Allow you to search for any one of a set of characters.
    - **Example**: `[Aa]pple` will match both "Apple" and "apple".
  
- **Ranges**: Allow you to search for characters within a specific range.
    - **Example**: `[a-c]pple` will match "apple", "bpple", and "cpple". You can also use ranges like `[0-9]`.

### Negation:

Negation allows you to exclude certain characters from a match.
- **Example**: `[^1-8]45` will match "045" or "945", but not "145", "245", etc.

---

## Quantifiers in Regex:

Quantifiers specify how many instances of a character or pattern you want to match.

1. **Asterisk (*)**: Matches 0 or more of the preceding element.
    - **Example**: `lo*` will match "l", "lo", "loo", "looo", etc.
    
    ```bash
    grep "lo*" filename
    ```

2. **Plus (+)**: Matches 1 or more of the preceding element.
    - **Example**: `lo+` will match "lo", "loo", "looo", but not "l".

3. **Braces ({})**: Used for specifying an exact number of repetitions.
    - **Example**: `a{2,3}` will match "aa" or "aaa", but not a single "a".

---

## Practice Problem:

Consider the following regex-based problem:
![Problem Image](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/089/445/original/Screenshot_2024-09-12_144930.png?1726132780)
