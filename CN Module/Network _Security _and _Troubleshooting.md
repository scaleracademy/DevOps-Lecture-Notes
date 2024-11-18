

# Network Security and Troubleshooting

---

## Common Security Threats

### 1. **Unauthorized Access**
- **Definition:** Unauthorized access occurs when an individual who lacks proper permission or credentials successfully gains access to a system or data. This could involve viewing, modifying, or performing actions on a server or within a network without the necessary authorization.
- **Example:** Imagine a user without admin privileges who manages to bypass security protocols and retrieves sensitive information from a company's database. This could happen through various methods, such as exploiting weak passwords or vulnerabilities in software.

### 2. **Distributed Denial of Service (DDoS) Attacks**
- **Definition:** A **DDoS attack** is a malicious attempt to disrupt the normal traffic of a targeted server, service, or network by overwhelming it with a flood of internet traffic. The goal is to make the service unavailable to legitimate users by consuming its bandwidth, CPU, or other resources.
- **Mechanism:** The attacker uses multiple compromised systems (often part of a botnet) to send a massive volume of requests to the target server. As the server tries to handle this overwhelming number of requests, it becomes sluggish, unresponsive, or crashes entirely.
- **Impact:** DDoS attacks can lead to significant downtime, resulting in loss of business, customer trust, and even financial damage, especially for organizations that rely heavily on online operations.

---

## Methods of Prevention

### 1. **Firewall**
- **Definition:** A firewall is a network security device or software designed to monitor and filter incoming and outgoing traffic based on pre-established security rules. It acts as a barrier between a trusted internal network and untrusted external networks, such as the internet.
- **Functionality:** Firewalls help prevent unauthorized access to or from private networks by examining each packet of data and determining whether it should be allowed through or blocked based on security policies.

#### Types of Firewalls:
- **Host-Based Firewall:**  
  - Protects a single device or host by filtering traffic to and from that specific machine.
  - Example: Personal firewalls on individual laptops or desktop computers.
- **Network-Based Firewall:**  
  - Protects an entire network by controlling traffic between the external (untrusted) network and the internal (trusted) network.
  - Example: Corporate firewalls that guard the boundary between the internet and the internal network.

---

### 2. **Uncomplicated Firewall (UfW)**
- **Overview:**  
  UfW (Uncomplicated Firewall) is the default firewall management tool for Ubuntu-based Linux distributions. It is designed to simplify the process of configuring firewall rules, making it easier for users to manage security settings without dealing with complex command-line syntax.
  
- **Key Features:**  
  UfW provides basic protection by allowing users to easily enable or disable the firewall, allow or block specific ports or services, and manage rules for specific IP addresses or ranges.

- **Common UfW Commands:**
  - **Enable the Firewall:**  
    This command activates the firewall, enforcing any predefined rules.  
    ```bash
    sudo ufw enable
    ```
  
  - **Disable the Firewall:**  
    Disables the firewall, meaning all incoming traffic is allowed without restriction.  
    ```bash
    sudo ufw disable
    ```
  
  - **Check Firewall Status:**  
    This command shows whether the firewall is currently active or inactive, and displays the list of active rules.  
    ```bash
    sudo ufw status
    ```
  
  - **Allow a Specific Port (e.g., Port 22 for SSH):**  
    Opens a specific port to allow traffic for a service, such as SSH (port 22).  
    ```bash
    sudo ufw allow 22
    sudo ufw allow ssh
    ```
  
  - **Deny a Specific Port (e.g., Port 23):**  
    Blocks a specific port from receiving or sending traffic.  
    ```bash
    sudo ufw deny 23
    ```
  
  - **Allow a Specific IP Address:**  
    Permits traffic from a designated IP address, such as a trusted internal or external device.  
    ```bash
    sudo ufw allow 192.168.x.xx
    ```
  
  - **Allow a Range of Ports:**  
    This command opens a range of ports for communication, typically used for services that need multiple ports open.  
    ```bash
    sudo ufw allow limit_1:limit_2/tcp
    ```
  
  - **Temporarily Block an IP Address (e.g., for too many requests):**  
    Limits incoming requests from a specific IP address, especially useful for protecting against brute-force attacks.  
    ```bash
    sudo ufw limit ssh
    ```
  
  - **Delete a Specific Rule by Rule Number:**  
    Removes an existing firewall rule, referenced by its rule number.  
    ```bash
    sudo ufw delete rule_number
    ```

---

## Domain Name System (DNS)

### Overview:
- The **Domain Name System (DNS)** is an essential part of the internet that converts human-readable domain names (like www.example.com) into machine-readable IP addresses (like 192.0.2.1). DNS enables users to access websites without needing to remember complex IP addresses.
  
### How DNS Works:
- When a user types a domain name into their web browser, DNS translates this domain into the IP address of the corresponding server. This process is necessary because while domain names are easy for humans to remember, computers communicate using IP addresses.

### Key Components of DNS:
1. **Domain Name:** The human-readable name (e.g., www.google.com) that is mapped to an IP address.
2. **IP Address:** The numerical label assigned to each device connected to a network. It identifies the device and its location.
3. **DNS Servers:** These servers store the mappings between domain names and IP addresses and respond to user requests for translations.
4. **Resolvers:** DNS resolvers are responsible for sending queries to various DNS servers to resolve domain names into IP addresses.

### Steps of DNS Resolution (How DNS Works):
1. **User Query:**  
   When a user enters a domain name, the local system first checks its **local cache** to see if the domain’s IP address is already stored from a previous request.
  
2. **Recursive DNS Resolver:**  
   If the IP address is not found in the local cache, the request is sent to a **Recursive DNS Resolver**, usually managed by the Internet Service Provider (ISP). This resolver is tasked with finding the IP address by querying other DNS servers.
  
3. **Root DNS Server:**  
   The recursive resolver contacts a **Root DNS Server** if it cannot resolve the domain. Root servers are responsible for directing the resolver to the correct **Top-Level Domain (TLD) Server** (such as .com, .org, .net).
  
4. **Authoritative DNS Server:**  
   The **TLD Server** refers the request to the **Authoritative DNS Server**, which contains the actual IP address for the requested domain. The resolver retrieves this IP and returns it to the user’s system.
  
5. **Final Step:**  
   The IP address is now used to establish a connection to the server, and the requested website is displayed in the user’s browser.

---

## DNS Records

- DNS records are critical pieces of data stored in DNS servers. They provide information about a domain, such as the corresponding IP address or server information.

### Common DNS Record Types:
1. **A Record:**  
   Maps a domain name to an **IPv4** address. This is the most commonly used DNS record.
   
2. **AAAA Record:**  
   Maps a domain name to an **IPv6** address, enabling communication with devices that use the newer IP addressing format.
   
3. **CNAME Record:**  
   Stands for **Canonical Name Record**. It allows one domain to be an alias for another domain. For example, www.example.com can be an alias for example.com, so both domains point to the same website.

---

## Virtual Private Network (VPN)

### Overview:
- A **Virtual Private Network (VPN)** creates a secure and encrypted connection over a public network (such as the internet), allowing users to access private networks securely. VPNs ensure privacy and data integrity by hiding the user's IP address and encrypting all communication.

### Types of VPNs:
1. **Site-to-Site VPN:**  
   - This type of VPN connects entire networks to each other, often between remote offices and a central corporate network.
   - Example: A company’s remote office in one city is securely connected to the headquarters in another city using a site-to-site VPN.
  
2. **Remote Access VPN:**  
   - This allows individual users to securely connect to a remote network, such as a company’s internal network, from any location.
   - Example: Employees working from home use a remote access VPN to connect to their company’s internal resources.

---

## Network Troubleshooting Commands

### 1. **Ping Command:**
- **Function:**  
  The ping command is used to test network connectivity between two devices. It sends a series of small data packets to the target device and waits for a reply, measuring the time taken for the round-trip.
- **Use Case:**  
  Helpful in determining whether a specific host is reachable or if there are network issues such as packet loss or latency.

### 2. **Traceroute Command:**
- **Function:**  
  The traceroute command is used to trace the path data packets take from your computer to a destination. It displays each "hop" the packets take and the time taken for each hop.
- **Use Case:**  
  Useful for diagnosing network routing problems or understanding delays between points in a network.



### 3. **Dig Command:**
- **Definition :** **Dig** stands for Domain Information Groper. It is a network administration command-line tool used to query DNS servers and retrieve domain-related information. It is widely used for DNS troubleshooting, such as verifying DNS records or identifying potential issues with DNS resolution.

---

