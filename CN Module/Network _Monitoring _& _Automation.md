# Network Monitoring & Automation - Notes


## HTTP Methods or Verbs

### **Overview of HTTP:**
- **HTTP (Hypertext Transfer Protocol)** is a foundational protocol used in the client-server communication model, which powers most of the web today.
  - In this model, a client (typically a web browser or mobile app) makes requests to a server (where resources like web pages, images, or data are hosted).
  - HTTP defines how messages are sent and how requests from clients are interpreted and processed by the server.
  - It is stateless, meaning each request is treated independently without retaining any information from previous interactions.

### **HTTP Methods or Verbs:**
- HTTP methods, also referred to as **verbs**, specify the type of operation the client wishes to perform on a server resource.
  - Examples of operations include retrieving data, sending data, updating resources, or deleting resources.
  - The choice of HTTP method is critical in defining the intent of the communication between client and server.

### **Idempotency Concept**:
- **Idempotency** is a key concept in HTTP and refers to operations that, when executed multiple times, have the same effect as executing them once.
  - **Idempotent operations**: These operations produce the same outcome, even when repeated multiple times. For example, a multiplication operation like `1 * 1 = 1` will always result in `1`, regardless of how many times it’s performed.
  - **Non-idempotent operations**: These operations lead to different results when performed multiple times. For example, multiplying numbers like `2 * 2 = 4`, and then `4 * 2 = 8`, produces different outcomes with each iteration.

Idempotency is essential in web communication to avoid unintended effects, especially in scenarios where network requests might be resent due to timeouts or retries.

---

### **Common HTTP Methods**:

1. **GET**:
   - The **GET** method is used to **retrieve** data from a server without making any changes to the resource.
   - **Idempotent**: The GET method is idempotent, meaning that multiple identical GET requests will always return the same data, without modifying the resource.
   - **Example**: 
     - When a user visits a webpage like google.com, the browser sends a GET request to the server to fetch the page content. 
     - Refreshing the page (sending the GET request again) will display the same data each time because no changes are made to the server.
     - Another analogy would be **counting books in a library**. A GET request is like counting the number of books without changing their arrangement or quantity.

2. **POST**:
   - The **POST** method is used to **send data to the server**, typically to create a new resource.
   - **Not Idempotent**: Unlike GET, POST is not idempotent. If the same POST request is made multiple times, it may result in **duplicate resources** or **repeated actions** on the server.
   - **Use case**: 
     - When a user submits a registration form or uploads a file, the data (such as the user's information) is sent to the server using a POST request. 
     - If the same POST request is sent repeatedly, multiple user accounts or files might be created, causing potential issues such as duplication.

3. **PUT**:
   - The **PUT** method is used to **update or replace an existing resource** on the server.
   - **Idempotent**: Multiple identical PUT requests result in the same outcome, as PUT either updates the resource to the same state or creates it if it doesn’t exist.
   - **Example**:
     - When updating a user profile, a PUT request might be sent to change the user’s email address. If the same PUT request is sent multiple times, the user’s email will still be updated to the same value, ensuring no duplication or unintended changes.

4. **DELETE**:
   - The **DELETE** method is used to **remove a resource** from the server.
   - **Idempotent**: Like GET and PUT, DELETE is idempotent. Once a resource has been deleted, further DELETE requests will have no additional effect, as the resource no longer exists.
   - **Use case**:
     - Deleting a record from a database or removing a file from a server. After a DELETE request is successfully processed, repeating the request will simply confirm that the resource has already been deleted.

5. **PATCH**:
   - The **PATCH** method is used to **partially update an existing resource**.
   - **Difference from PUT**: While PUT replaces the entire resource, PATCH only updates the specified part of the resource.
   - **Idempotent**: Like PUT, PATCH is idempotent, meaning that multiple PATCH requests will produce the same result.
   - **Example**: 
     - If you want to update only the email address of a user without modifying other fields like the username or password, a PATCH request would allow you to make just that partial change.

6. **HEAD**:
   - The **HEAD** method is similar to GET, but it **retrieves only the headers** of the resource, not the body.
   - **Idempotent**: Like GET, HEAD is idempotent, meaning that the same request will return the same headers each time.
   - **Use case**: 
     - HEAD requests are often used to check if a resource exists or to retrieve metadata (like content length or type) without downloading the entire resource.

7. **OPTIONS**:
   - The **OPTIONS** method is used to determine the **HTTP methods** that a server supports for a given resource.
   - **Idempotent**: The OPTIONS request always returns the same information unless the server's configuration changes.
   - **Use case**: 
     - Before sending a POST or PUT request, a browser may use the OPTIONS request to check which methods are allowed for the specified URL.

8. **CONNECT**:
   - The **CONNECT** method is used to establish a **tunnel** to the server, often for SSL or TLS connections.
   - **Not Idempotent**: Each CONNECT request creates a new connection, so it is not idempotent.
   - **Use case**: 
     - CONNECT is commonly used when accessing **secure websites (HTTPS)**, where the client needs to establish an encrypted connection with the server.

9. **TRACE**:
   - The **TRACE** method is used for **diagnostics**. It performs a loopback test by tracing the path the request takes to the server.
   - **Idempotent**: TRACE is idempotent, meaning repeated TRACE requests will trace the same path.
   - **Use case**: 
     - TRACE is useful for debugging and can be thought of as similar to the `traceroute` command, which traces the route that data packets take across the network.


## Curl with HTTP

### **Curl Overview**:
- **Curl** is a command-line tool used to transfer data to and from a server using various protocols, including HTTP and HTTPS. 
- It allows developers to interact with web servers, test APIs, and troubleshoot HTTP requests from the terminal.

### **Making HTTP Requests with Curl**:

1. **GET Request**:
   - **Syntax**: `curl -X GET <API link>`
   - The **GET** method can be used to fetch data from a specified API endpoint or server.
   - **Example**: 
     - A developer might use `curl -X GET` to fetch data from a database or API, such as retrieving information about users from a user management API.
     - A request like `curl http://example.com/api/users` retrieves a list of users in JSON or XML format.

2. **POST Request**:
   - **Syntax**: `curl -X POST -d "username=deeper" <API link>`
   - The **POST** method is used to send data to the server, often for the purpose of creating a new resource.
   - **Example**: 
     - When submitting data to a server (e.g., creating a new user), a POST request is used. The `-d` flag allows you to pass data such as form fields or JSON payloads in the request body.
     - A request like `curl -X POST -d "username=johndoe" http://example.com/api/users` would create a new user with the username "johndoe" on the server.

### **Using Curl with Google**:
- When using `curl http://google.com`, the request typically returns a **301 status code**, which indicates that the page has been **permanently redirected**.
  - Google redirects HTTP requests to HTTPS, which is why you encounter a redirection response.

### **Curl Verbose Mode**:
- **Syntax**: `curl -v <API link>`
  - The `-v` flag stands for **verbose mode**, which provides detailed information about the request.
  - In verbose mode, curl outputs the HTTP request and response headers, along with other metadata such as the status code, request method, and server response.
  - This is especially useful for debugging or examining how the server handles a request.

> **Note**: When making **HTTPS** requests, you may need to authenticate the client with an SSL/TLS certificate to establish a secure connection.


## HTTPS Status Codes

### **Overview of Status Codes**:
- **HTTP status codes** are standardized response codes returned by the server to indicate the result of a client’s request. They are grouped into five categories based on their first digit:
  1. **1xx**: Inform

ational responses.
  2. **2xx**: Success responses.
  3. **3xx**: Redirection responses.
  4. **4xx**: Client error responses.
  5. **5xx**: Server error responses.

### **Detailed Breakdown of Status Code Series**:

1. **1xx Series (Informational)**:
   - These status codes indicate that the server has received the request and the client should continue the process.
   - **Example**:
     - **100 Continue**: The server has received the request headers and asks the client to proceed with sending the body of the request.
     - **101 Switching Protocols**: The server is switching protocols as requested by the client, typically used for upgrading from HTTP to WebSockets.

2. **2xx Series (Success)**:
   - These codes indicate that the request was successfully received, understood, and accepted.
   - **Examples**:
     - **200 OK**: The standard response for a successful HTTP request.
     - **201 Created**: The request was successful, and a new resource has been created as a result (e.g., after a POST request).

3. **3xx Series (Redirection)**:
   - This series is used to tell the client that additional actions are required to complete the request, typically through redirection to another URL.
   - **Examples**:
     - **301 Moved Permanently**: The resource requested has been moved permanently to a new URL, and future requests should use this new URL.
     - **302 Found**: The requested resource has been temporarily moved to a different URL but will return to the original in the future.

4. **4xx Series (Client Errors)**:
   - These codes indicate that the client made an error in the request, such as sending malformed syntax or requesting a resource that doesn't exist.
   - **Examples**:
     - **400 Bad Request**: The server cannot process the request due to malformed syntax.
     - **401 Unauthorized**: The requested resource requires authentication.
     - **403 Forbidden**: The server understands the request but refuses to authorize it.
     - **404 Not Found**: The requested resource could not be found on the server.
     - **429 Too Many Requests**: The client has made too many requests in a given period (rate limiting).

5. **5xx Series (Server Errors)**:
   - These codes indicate that the server failed to fulfill a valid request due to some internal error.
   - **Examples**:
     - **500 Internal Server Error**: A generic error message indicating an unexpected condition on the server.
     - **502 Bad Gateway**: The server, acting as a gateway, received an invalid response from an upstream server.
     - **503 Service Unavailable**: The server is currently unable to handle the request, often due to maintenance or overload.
     - **504 Gateway Timeout**: The server, acting as a gateway, did not receive a timely response from an upstream server.


## Network Monitoring

### **Why Monitor the Network?**
- **Network monitoring** is crucial for maintaining the health, performance, and security of a network. By continuously tracking network activity, organizations can:
  1. **Detect Issues Early**: Catch network problems before they escalate into major failures.
  2. **Optimize Performance**: Ensure that the network is running efficiently, handling traffic without bottlenecks or slowdowns.
  3. **Maintain Uptime**: Downtime can be costly, especially for businesses reliant on online services.
  4. **Enhance Security**: Monitor for unusual traffic patterns or potential attacks (e.g., DDoS).

### **Scenario: Large E-commerce Sale**
- Consider a large e-commerce site (e.g., **Amazon** or **Flipkart**) preparing for a major sale event. When millions of users access the site simultaneously, it can cause **network congestion** and slowdowns. Monitoring the network during this critical period helps:
  - Predict traffic spikes and take preventative measures.
  - Allocate additional bandwidth to prevent bottlenecks.
  - Maintain site performance and avoid costly downtime.

### **Key Metrics to Monitor**:

1. **Bandwidth Utilization**:
   - Measures the amount of data being transmitted over the network at a given time.
   - **Why it matters**: High bandwidth usage can lead to congestion, resulting in slower network performance.
   - **Example**: A sudden spike in bandwidth usage could indicate a DDoS attack or a traffic surge during a high-demand event.

2. **Latency**:
   - Latency refers to the time it takes for data to travel from one point to another on the network.
   - **Why it matters**: High latency can cause delays in data transmission, leading to poor user experience, especially in real-time applications.
   - **Tools**: `ping` and `traceroute` are common tools to measure latency between network devices.

3. **Packet Loss**:
   - The percentage of packets that fail to reach their destination.
   - **Impact**: High packet loss can result in repeated retransmissions, slow data transfer, and incomplete communication.
   - Monitoring packet loss helps identify poor network conditions or faulty hardware.

4. **Error Rates**:
   - Measures the number of corrupted or dropped packets.
   - **Why it matters**: High error rates often signal hardware failures, misconfigured network devices, or issues with the physical cabling.
   - Monitoring error rates helps isolate problematic areas of the network that need attention.

5. **Uptime and Downtime**:
   - **Uptime**: Refers to the amount of time the network is operational and available.
   - **Downtime**: Refers to periods when the network is unavailable, resulting in disruptions to services.
   - **Why it matters**: Maximizing uptime is crucial for businesses that rely on continuous network availability. High uptime equals reliability and customer satisfaction.

6. **Resource Utilization**:
   - Monitors the usage of network resources such as CPU, memory, and disk space on networking devices.
   - **Example**: Tools like **Grafana** provide real-time visualization of resource utilization and help identify potential bottlenecks or overloads before they cause performance degradation.


### **Practical Monitoring Tools**:

1. **TCP Dump**:
   - A command-line tool used to capture and analyze network packets in real-time.
   - **Example**: `sudo tcpdump -i eth0 tcp port 80` captures TCP traffic on port 80, which is typically used for HTTP traffic. This helps analyze the incoming and outgoing traffic on a web server.

2. **Application Performance Monitoring (APM) Tools**:
   - **Datadog**, **New Relic**, and **Dynatrace** are popular tools used to monitor the performance of applications, servers, and cloud infrastructure.
   - **Purpose**: These tools help track response times, resource usage, and errors within applications to ensure smooth operation and performance.

3. **Log-based Monitoring Tools**:
   - **ELK Stack (Elastic Search, Logstash, Kibana)** and **Splunk** are widely used for log aggregation and analysis.
   - **Purpose**: These tools allow administrators to collect logs from various services (e.g., NGINX, Apache) and analyze them for issues like server load, traffic patterns, and error occurrences.
   - Log-based monitoring is essential for understanding how applications and servers handle traffic over time.


## Questions for Learners

1. **Find 5xx HTTP Errors**:
   - Using logs, identify the most frequently occurring **5xx HTTP errors** (server errors) and return the corresponding IP addresses.
   - **Hint**: The approach has already been covered in earlier modules, and learners can use tools like log analyzers (e.g., ELK Stack or Splunk) to filter error logs.

2. **Block an IP Address**:
   - Use **IP tables** to block an IP address that is causing a significant number of 5xx errors or other suspicious activity.
   - **Implementation**: IP tables allow network administrators to define rules for handling traffic and can be used to drop traffic from specific IP addresses.

3. **Automating Certificate Expiry Checks**:
   - **Problem**: Certificates expire periodically, and it is crucial to automate the process of checking expiry and renewing certificates before they expire.
   - **Automation Flow**:
     1. **Send a GET request** to fetch the certificate’s expiration date.
     2. If the certificate is close to expiry or has expired, **send a POST request** to generate a new certificate (for example, using **Let’s Encrypt**).
     3. **Send a PUT request** to replace the old certificate with the new one.
   - By automating this flow, businesses can ensure uninterrupted secure communication without manual intervention.
