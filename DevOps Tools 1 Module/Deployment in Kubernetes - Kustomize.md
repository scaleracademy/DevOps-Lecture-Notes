
# Deployment in Kubernetes - Kustomize

### Topics Covered:
- **Kustomize**: Overview and introduction to its purpose in Kubernetes.
- **Practical Demonstration**: Hands-on demo showcasing how to use Kustomize effectively.
- **Real-life Scenarios**: Practical examples of how Kustomize is used in production settings.
- **Interview Questions**: Key questions that might arise in interviews related to Kustomize.

---

## Kustomize

### What is Kustomize?
Kustomize is a **Kubernetes-native configuration management tool** that allows you to customize Kubernetes resource YAML files without modifying the original files. It dynamically applies configurations at runtime, making it easier to maintain multiple environment configurations, such as development, staging, and production.

---

### Working with Kustomize

#### Pre-existing YAML Files:
- You typically start with Kubernetes resource files:
  - `deployment.yaml`
  - `service.yaml`
  - `configmap.yaml`

#### Adding Kustomize:
1. Create a new file named **`kustomization.yaml`**.
2. Add your existing resource files to this file. For example:
   ```yaml
   resources:
     - deployment.yaml
     - service.yaml
   ```
3. Kustomize dynamically applies the configurations defined in the `kustomization.yaml` file to your original resource files **at runtime**.

#### Running Kustomize:
Use the following commands to execute Kustomize:
- **View transformed YAML**: 
  `kubectl kustomize .`
- **Apply configurations directly to your cluster**: 
  `kubectl apply -k .`
- **Chain commands for flexibility**: 
  `kubectl kustomize . | kubectl apply -f`

---

### Demonstration (Instructor Focus)

**Steps to demonstrate Kustomize:**
1. Create a `kustomization.yaml` file in the same directory as your resource files.
2. Show how parameters in the `kustomization.yaml` file are applied dynamically to existing files.
3. Explain the command outputs and how they affect the Kubernetes cluster.

Example `kustomization.yaml` file:
```yaml
resources:
  - deployment.yaml
  - service.yaml
```

---

### Organizing Kustomize with Directories

To manage environment-specific configurations, use the following directory structure:

#### Directory Structure:
- **`base` directory**:
  - Contains common YAML files, such as:
    - `deployment.yaml`
    - `service.yaml`
    - `configmap.yaml`
    - `kustomization.yaml`
- **`overlays` directory**:
  - Contains environment-specific configurations:
    - `dev/`
    - `staging/`
    - `prod/`

#### Example:
1. Move all base resources (`deployment.yaml`, `service.yaml`, etc.) into the `base` directory.
2. In each environment folder under `overlays`, create a `kustomization.yaml` file that references the base directory:
   ```yaml
   resources:
     - ../../base
   ```
3. Apply patches for specific environments using **`patchesStrategicMerge`**:
   - Add a new file `deployment-patch.yaml` inside the specific environment folder.
   - Reference this file in the `kustomization.yaml` for the environment:
     ```yaml
     patchesStrategicMerge:
       - deployment-patch.yaml
     ```

#### Applying the Configuration:
- To apply the dev configuration:
  ```bash
  kubectl apply -k overlays/dev/
  ```

![Kustomization Example](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/104/590/original/kustomization.png?1737643403)

For a more detailed example, refer to the following structure:

![Dev Environment Example](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/104/598/original/devkustomize.png?1737643872)

---

## Understanding Kustomize Terminologies

### Directory Structure:
1. **Base Directory**:
   - Contains shared resources for all environments.
   - Files:
     - `base-deployment.yaml`
     - `kustomization.yaml`
2. **Overlays Directory**:
   - Contains environment-specific configurations.
   - Files:
     - `kustomization.yaml`
     - `patch.yaml`

### Key Features of `kustomization.yaml`:
- **ConfigMap Generator**:
  Dynamically generate ConfigMaps:
  ```yaml
  configMapGenerator:
    - name: my-configmap
      literals:
        - key=value
  ```
- **Secret Generator**:
  Similar to ConfigMap generator but for secrets:
  ```yaml
  secretGenerator:
  ```
- **Common Labels and Annotations**:
  Add labels/annotations globally:
  ```yaml
  commonLabels:
    app: my-app
  ```
- **Cross-cutting Fields**:
  Fields like common labels, annotations, or namespaces defined in the `kustomization.yaml` file will apply across all resources.

### Patching Options:
- **Strategic Merge Patches**:
  Use the `patchesStrategicMerge` field to define YAML patches that selectively modify base resources.
- **JSON Patches**:
  Use the `patchJson6902` field for JSON-style patching.

### Variables:
Kustomize supports variables using the `$` syntax.

---

## Kustomize Examples

### Scenario 1: Multi-Datacenter Deployment
Suppose a company has four datacenters running an Nginx application. The environments are:
- Preview
- Sales
- Production

#### Configuration:
1. The **base directory** contains common Kubernetes resources:
   - Deployments
   - Services
   - ConfigMaps
2. Each datacenter has environment-specific configurations, including:
   - Environment variables
   - Secrets
   - Persistent Volumes (PV) and Persistent Volume Claims (PVC)
   - Role-based Access Control (RBAC) roles

Kustomize enables you to define the shared resources in the **base** directory and override environment-specific values in the respective **overlay** directories.

---

### Real-Life Example:
Consider a scenario with multiple clusters spread across different AWS regions. The challenges include:
- Managing **compliance issues**.
- Supporting **multi-tenancy** for different customers.
- Enabling **region-specific features**.

Kustomize simplifies this by:
- Providing a common base configuration for all clusters.
- Allowing region-specific customizations using overlays.

---

## Helm vs Kustomize

### Comparison Table:

| Feature          | **Helm**                              | **Kustomize**                          |
|------------------|---------------------------------------|----------------------------------------|
| **Type**         | Package Manager for Kubernetes        | Kubernetes Native Configuration Tool   |
| **Templating**   | Yes (with Go templates)               | No                                     |
| **Overlays**     | Uses values files for customization   | Uses patch-based overlays              |
| **Releases**     | Manages lifecycle (install/upgrade)   | Doesn’t manage state, just config      |
| **Dependencies** | Supports chart dependencies           | No built-in support                    |
| **Complexity**   | Can be complex for simple cases       | Simpler, focuses on YAML transformation|
| **Community**    | Large ecosystem (charts)              | Part of Kubernetes (kubectl integration)|
| **Versioning**   | Yes                                   | No, relies on Git for version control  |

### Key Takeaways:
- **Helm**: Ideal for managing complex applications with lifecycle management.
- **Kustomize**: Best for lightweight YAML transformations without requiring templating.

---
```
