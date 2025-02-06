## Hands-on Project Building a Simple Network


### Agenda of the Lecture

1. **Load Balancing**
2. **Blocking Client Manually**
3. **Rate Limiting**


### Load Balancing

#### Overview

- **server1**: Load balancer (Nginx)
- **server2**, **server3**: Web servers
- **server4**: Client or local machine

**Objective**: Set up **Nginx** as a load balancer on **server1** to distribute traffic evenly between **server2** and **server3**.

#### Part 1: Load Balancer Setup

1. The client (server4) sends requests to **server1**.
2. **Server1** (Nginx load balancer) distributes traffic to **server2** and **server3**.
3. Nginx's default method is round-robin, sending requests alternately between servers.

##### Server1: Nginx Load Balancer Configuration

1. **Update the system**:
    ```bash
    sudo apt update -y
    ```
2. **Install Nginx**:
    ```bash
    sudo apt install nginx -y
    ```
3. **Start Nginx**:
    ```bash
    sudo systemctl start nginx
    ```
4. **Check Nginx Status**:
    ```bash
    sudo systemctl status nginx
    ```
5. **Configure Nginx for Load Balancing**:
   - Open the Nginx configuration:
     ```bash
     sudo vi /etc/nginx/conf.d/load_balancing.conf
     ```
   - Add the following configuration:
     ```nginx
     upstream backend {
         server 192.168.1.2;  # Server 2
         server 192.168.1.3;  # Server 3
     }

     server {
         listen 80;
         location / {
             proxy_pass http://backend;
         }
     }
     ```
   - Replace IPs with actual server2 and server3 IPs.

6. **Reload Nginx** to apply the changes:
    ```bash
    sudo systemctl reload nginx
    ```
7. **Test connection** by sending a request:
    ```bash
    curl http://<server1-ip>
    ```

##### Server2: Web Server Setup (Nginx)

1. **Install Nginx**:
    ```bash
    sudo apt install nginx -y
    ```
2. **Create an HTML response**:
    ```bash
    echo "Welcome to Server 2" | sudo tee /var/www/html/index.html
    ```
3. **Restart Nginx**:
    ```bash
    sudo systemctl restart nginx
    ```

##### Server3: Web Server Setup (Apache)

1. **Install Apache**:
    ```bash
    sudo apt install apache2 -y
    ```
2. **Enable Apache to start on boot**:
    ```bash
    sudo systemctl enable apache2
    ```
3. **Create an HTML response**:
    ```bash
    echo "<h1>Hello from Server 3 $(hostname)</h1>" | sudo tee /var/www/html/index.html
    ```


### Blocking Client Manually

#### Part 2: Blocking a Client

1. **Check access logs** on **server2**:
    ```bash
    vi /var/log/nginx/access.log
    ```
2. **Identify suspicious requests**:
   - Open the **load balancer logs** on **server1** to find the origin IP.
3. **Manually block an IP**:
   ```bash
   sudo iptables -A INPUT -s 122.162.148.247 -p tcp --dport 80 -j DROP
   ```
   - This command blocks incoming requests from the specified IP on port 80.
4. **View blocked IPs**:
   ```bash
   sudo iptables -L
   ```

##### Automating Client Blocking

1. **Extract unique IP addresses**:
   ```bash
   awk '{print $1}' /var/log/nginx/access.log | uniq
   ```
2. **Block each IP using iptables**:
   ```bash
   awk '{print $1}' /var/log/nginx/access.log | uniq | xargs -I {} sudo iptables -A INPUT -s {} -p tcp --dport 80 -j DROP
   ```

3. **Unblock an IP**:
   ```bash
   sudo iptables -D INPUT -s 122.162.148.247 -p tcp --dport 80 -j DROP
   ```
4. **Flush all IP tables** (use cautiously):
   ```bash
   sudo iptables -F
   ```


### Rate Limiting

#### Part 3: Implementing Rate Limiting

1. **Use Nginx for rate limiting**.
2. **Open the Nginx configuration file**:
   ```bash
   sudo vi /etc/nginx/nginx.conf
   ```

##### Nginx Rate Limiting Configuration

1. **Add rate limiting rules** inside the HTTP block:
   ```nginx
   limit_req_zone $binary_remote_addr zone=mylimit:10m rate=5r/m;
   ```
   - This limits 5 requests per minute from the same IP.

2. **Apply the rate limiting rule** inside the server block:
   ```nginx
   limit_req zone=mylimit burst=5 nodelay;
   ```

3. **Reload Nginx** to apply the changes:
    ```bash
    sudo systemctl reload nginx
    ```

4. **Test the rate limiting** by sending multiple requests:
    ```bash
    curl http://<server1-ip>
    ```



### Why Rate Limiting?

- **Automates traffic control** to prevent overload.
- Tools like **Nginx** simplify implementation, making it scalable across environments.

