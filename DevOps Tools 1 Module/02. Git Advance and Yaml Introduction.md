# **Git Advanced Concepts & YAML Introduction**

This document provides a detailed discussion on **advanced Git concepts** such as branching, pull requests, merge conflicts, and Git workflows. It also introduces the foundational understanding of YAML, a human-readable data serialization format often used in DevOps for configuration files.

---

## Topics Covered:
1. Git  
   - Git Branches  
   - Understanding Git with Remote Repositories  
   - Pull Requests  
   - Merge Conflicts  
   - Merge, Rebase, and Reset  
   - Conflict Messages  
   - Git Fetch  
   - Forking  
   - Cherry-Picking  
   - Branching Strategies  
   - Git Stash  

---

# **Git Advanced Concepts**

---

## **Git Branches**  
A **branch** in Git is like a separate line of development, allowing multiple developers to work independently on different features without affecting the main codebase.

### Commands for Branching:
- `git branch`  
  Displays all branches in the repository and indicates the current branch.  
- `git checkout -b <new_branch_name>`  
  Creates a new branch and switches to it automatically.

### Key Points:
- When a branch is created, it contains all files from the parent branch.
- Changes made in one branch remain isolated unless they are **merged** into another branch.
- When changes are committed to a branch and pushed to a remote repository, a **pull request** (or **merge request**) can be created to merge those changes into the main branch.


---

## **Understanding Git by Remote Repository**  
A **remote repository** is hosted on a platform like **GitHub** or **GitLab** to store code and track changes from multiple developers.

### Steps to Work with a Remote Repository:
1. **Create a repository on GitHub**.  
2. **Clone the repository** locally:  
   ```bash
   git clone https://github.com/<github_account>/<repo_name>.git
   ```
3. **Create a new branch from the main branch**:  
   ```bash
   git checkout -b staging
   ```
4. **Make changes** in the branch, stage, commit, and push them:
   ```bash
   echo "Some text" > stag.txt
   git add stag.txt
   git commit -m "Added staging file"
   git push origin staging
   ```

**Key Question:**  
*Will these changes reflect on the main branch automatically?*  
No, changes must be merged through a **pull request**.

---

## **Pull Request**  
A **pull request** (or **merge request**) is a way to notify other developers about the changes you've made and request to merge them into the main branch.

### Creating a Pull Request:
- Define the **base branch** (the target branch) and the **compare branch** (the source branch with changes).
- GitHub checks for **merge conflicts**. If none are found, you can **merge the pull request**.
- After merging, the changes become part of the base branch.

---

## **Merge Conflicts**  
A **merge conflict** occurs when Git cannot automatically resolve differences between two branches.

### Example Scenario:
- **Main Branch** contains files: `file1` and `file2`.
- **Branch A** modifies `file1`, and **Branch B** modifies the same lines in `file1`.
- When Branch A is merged into the main branch, no conflict occurs.  
- When Branch B attempts to merge, a **merge conflict** arises.

---

## **Merge, Rebase, and Reset**  

### **1. Merge**  
Combines changes from different branches into a single branch.

**Example:**  
Two developers write on separate parts of a document and then combine their sections into a single document.  
```bash
git merge <branch_name>
```

---

### **2. Rebase**  
Moves the base of the current branch to a new commit, rewriting the commit history.

**Example:**  
Instead of combining two documents, you copy one section into another document to create a linear version.  
```bash
git rebase <branch_name>
```

---

### **3. Reset**  
Moves a branch pointer to a specific commit, effectively undoing changes made after that commit.

**Command:**  
```bash
git reset <commit_hash>
```

---

## **Conflict Message**  
When a conflict occurs, Git provides a message indicating the conflicting lines. The conflict message shows:  
- **HEAD**: Local changes.  
- **Incoming changes**: Changes from the remote repository.

To resolve the conflict, choose which changes to keep or keep both.

---

## **Git Fetch vs. Git Pull**  
- **git fetch**: Downloads changes from a remote repository without merging them.  
- **git pull**: Fetches changes and merges them into the current branch.

**Use Case:**  
If a new branch is created in the remote repository, you must fetch it before checking it out locally:  
```bash
git fetch
git checkout <branch_name>
```

---

## **Forking**  
**Forking** creates a personal copy of someone else’s repository on a remote server.

### Fork vs. Clone:
| **Fork**           | **Clone**              |
|--------------------|------------------------|
| Creates a personal copy on GitHub. | Creates a local copy on your machine. |

---

## **Cherry-Picking**  
The `git cherry-pick` command allows you to apply a specific commit from one branch to another.  
```bash
git cherry-pick <commit_hash>
```

**Use Case:**  
If a commit was mistakenly made to the wrong branch, cherry-picking can apply it to the correct branch.

---

## **Branching Strategies**  
Different branching strategies are used to manage workflows in Git:

### **1. Git Flow**  
A comprehensive branching model suitable for large projects.  
- Master, Develop, Feature, Release, and Hotfix branches.  

![Git Flow](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/098/514/original/git_flow.png?1733160914)

---

### **2. GitHub Flow**  
A simpler branching strategy focused on continuous deployment.  
- Main and Feature branches.  

![GitHub Flow](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/098/516/original/github_flow.png?1733160955)

---

### **3. GitLab Flow**  
Combines the best of Git Flow and GitHub Flow for managing multiple environments.

![GitLab Flow](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/098/517/original/gitlab_flow.png?1733160980)

---

## **Git Stash**  
The **git stash** command temporarily saves your changes and clears your working directory.

### Commands:
- **Stash changes**:  
  ```bash
  git stash
  ```
- **Apply stashed changes**:  
  ```bash
  git stash pop
  ```

**Use Case:**  
If you need to switch branches but have unsaved changes, stash the changes to avoid losing them.

---

# **Summary of Git Commands**
| **Command**               | **Description**                                   |
|---------------------------|---------------------------------------------------|
| `git branch`               | Shows the list of branches.                      |
| `git checkout -b <name>`   | Creates and switches to a new branch.            |
| `git merge <branch_name>`  | Merges a branch into the current branch.         |
| `git rebase <branch_name>` | Rebases the current branch onto another branch.  |
| `git reset <commit_hash>`  | Resets the branch pointer to a specific commit.  |
| `git fetch`                | Fetches updates from a remote repository.        |
| `git pull`                 | Fetches and merges updates from a remote repo.   |
| `git stash`                | Temporarily saves changes.                      |
| `git cherry-pick <hash>`   | Applies a specific commit to the current branch. |
