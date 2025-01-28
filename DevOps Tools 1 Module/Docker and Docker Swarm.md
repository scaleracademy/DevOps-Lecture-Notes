# Typed Notes of Docker and Docker Swarm

### 📘 **How Dockerfile Works?**

A Dockerfile is a script with a set of instructions used to automate the creation of Docker images. Here’s a conceptual breakdown:

- In a typical Linux environment, developers often run **shell scripts** or **Python applications** directly on the machine.
- However, Docker introduces **containers**, which serve as isolated environments to run applications.
- With a **Dockerfile**, we can:
  1. Copy an application (e.g., a Python script) into a container.
  2. Run the application inside the container.
  
This means the container acts as a **lightweight virtual machine**.  
To run a container, you need:
1. **Application Code**  
2. **Dockerfile** – Docker will consume the application code and create an image based on the Dockerfile.

---

### 🧩 **Components of a Dockerfile**

#### 1️⃣ **EXPOSE**
- The `EXPOSE` instruction informs Docker about the ports on which the container will listen at runtime.

**Difference between EXPOSE and `-p` flag:**
| EXPOSE         | -p (publish)               |
|----------------|----------------------------|
| Informs Docker about the port | Maps the container port to the host machine |
| Works internally within Docker | Exposes the port externally to users |

#### 2️⃣ **HEALTH CHECK**
- Used to ensure the container is working as expected.  
Example:  
```bash
HEALTH CHECK --interval=30s --timeout=10s --retries=3 CMD curl http://localhost
```
This runs a health check every **30 seconds**, times out in **10 seconds**, and retries up to **3 times**.

---

#### 3️⃣ **ARG** (Build-time Variables)
- Defines variables that can be passed during the **build process** using the `docker build` command.

Example:
```dockerfile
ARG build_version
RUN echo "version $build_version"
```

Usage during build:
```bash
docker build --build-arg build_version=1.0 .
```

---

#### 4️⃣ **USER**
- The `USER` instruction specifies which user will execute subsequent Dockerfile commands.  
This is useful for running commands with **different permissions**.

📷 *Diagram: USER Instruction*  
![Docker USER Command](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/102/962/original/dockeruser.png?1736599792)

---

#### 5️⃣ **Multi-Stage Builds**
- **Multi-stage builds** help create smaller and more efficient Docker images by using multiple `FROM` statements in the same Dockerfile.  
- The **artifacts** generated in one stage can be copied into the final image, reducing image size.

📷 *Diagram: Multi-Stage Builds*  
![Multi-Stage Builds](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/102/963/original/dockermultistagebuilds.png?1736600048)

---

#### 6️⃣ **INSPECT**
- The `docker inspect` command provides detailed information about a container or image, including its configuration, state, and network settings.

Common usage examples:
```bash
docker inspect container_id
docker inspect --format='{{.NetworkSettings.IPAddress}}' container_id
```
The second command returns the **IP address** of the container.

---

# 🔧 **Building Efficient Images**

To optimize Docker images, follow these best practices:

### ✅ **Best Practices for Building Efficient Docker Images**

1. **Use Multi-Stage Builds**  
   - Reduce image size by building artifacts in one stage and copying them to the final stage.

2. **Minimize the Number of Layers**  
   - Instead of creating a new layer for each instruction, combine related instructions into a single `RUN` command.

**Example:**
❌ Incorrect approach:
```dockerfile
RUN apt-get update
RUN apt-get install curl
RUN apt-get install vim
```

✅ Correct approach:
```dockerfile
RUN apt-get update && apt-get install -y curl vim
```

3. **Use a `.dockerignore` File**  
   - Exclude unnecessary files and directories from the image to reduce its size.

4. **Avoid Installing Unnecessary Packages**  
   - Only install packages that are essential for your application.

5. **Clean Up After Installations**  
   - Remove cached files or unnecessary dependencies after installations.

6. **Use `ARG` for Build-Time Variables**  
   - Leverage `ARG` to pass variables during the build process.

---

# 📏 **Flattening a Docker Image**


### 🛠️ **What is Flattening a Docker Image?**

Flattening a Docker image involves combining all the **layers** of an image into a **single layer**. This can help simplify images and optimize them for deployment.

### 📋 **Why Flatten an Image?**
1. **Reduce Complexity**  
   - Fewer layers mean a simpler image structure.
2. **Reduce Size**  
   - Flattening can help remove unnecessary layers and reduce image size.
3. **Increase Security**  
   - Reduces the risk of leftover sensitive files in layers.
4. **Optimize for Deployment**  
   - Faster deployment due to reduced size and complexity.

---

### 📘 **Steps to Flatten an Image**

1. **Run the Image and Create a Container**  
   ```bash
   docker run --name my_container my_image
   ```

2. **Export the Container Filesystem**  
   ```bash
   docker export my_container -o flat_image.tar
   ```

3. **Import the Flattened Image as a New Image**  
   ```bash
   docker import flat_image.tar my_flat_image
   ```

---

# 📌 **Summary of Key Commands**
| **Command**              | **Description**                              |
|--------------------------|----------------------------------------------|
| `EXPOSE 80`              | Informs Docker that the container listens on port 80 |
| `HEALTH CHECK`           | Adds a health check to verify container health |
| `ARG build_version`      | Defines a build-time variable                |
| `USER myuser`            | Specifies the user to run subsequent commands |
| `docker inspect`         | Inspects a container or image configuration  |
| `docker run`             | Runs a Docker container                      |
| `docker export`          | Exports a container filesystem as a tar file |
| `docker import`          | Imports a tar file as a new Docker image     |
