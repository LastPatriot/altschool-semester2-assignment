
# SERVER PROVISIONING AND WEB SERVER DEPLOYMENT WITH REVERSE PROXY - Opeyemi Oluwadare

This project involves setting up a server and deploying a dynamic webpage. Key elements include configuring a reverse proxy to efficiently route requests and implementing a self-signed certificate to mirror certificate configuration (SSL/TLS encryption to secure data transmission).

![image](https://github.com/user-attachments/assets/b5c81bcb-41ae-4302-a049-dd2948f91526)

## PROJECT URL
See the live project first!!
- [Proxied page on HTTP](http://ec2-18-212-40-40.compute-1.amazonaws.com/profile/)
- [Proxied page on HTTPS](https://ec2-18-212-40-40.compute-1.amazonaws.com/profile/)
- [Default NGINX page on HTTP](http://ec2-18-212-40-40.compute-1.amazonaws.com)
- [Default NGINX page on HTTPS](https://ec2-18-212-40-40.compute-1.amazonaws.com)

## Outline

 - [Technologies Used](#tech)
 - [Provisioning the server](#server-provisioning)
 - [Installing the necessary dependencies](#dependencies)
 - [NGINX Installation](#nginx)
 - [Deploying the node web-server for Reverse Proxy](#node-app)
 - [Configuring Reverse Proxy on nginx](#reverse-proxy)
 - [Running the node webserver as Daemon to maintain uptime](#daemon)
 - [Enabling port 443 on NGINX using self-signed certificate](#port-443)
 - [Screenshots of the rendered page in a web browser](#render)


## Technologies Used <a id="tech"></a>

This project utilized the following technologies:

- AWS EC2: For provisioning and managing the virtual server instance.
- Ubuntu Server: The operating system running on the EC2 instance.
- Nginx: Used as the web server and reverse proxy.
- Node.js: For developing and running the dynamic web application.
- Express.js: A Node.js web application framework used for the web server.
- OpenSSL: For generating the self-signed SSL/TLS certificate.
- Systemd: For managing the Node.js web server as a daemon.

## Server Provisioning <a id="server-provisioning"></a>

The server provisioning was done using the AWS cloud console services. An EC2 instance was provisioned with the name `opeyemi-semester-2`. Please see images below.

<img width="1800" alt="Screenshot 2025-06-15 at 12 42 46" src="https://github.com/user-attachments/assets/4e7360a3-a810-4021-8f7d-21d90d98aa27" />
<img width="1800" alt="Screenshot 2025-06-15 at 12 43 33" src="https://github.com/user-attachments/assets/0671e843-270e-4acb-8963-d9ea28e05066" />
<img width="1800" alt="Screenshot 2025-06-15 at 12 43 54" src="https://github.com/user-attachments/assets/7b98971c-60d4-468e-8b23-528bc2248b05" />
<img width="1800" alt="Screenshot 2025-06-15 at 12 45 30" src="https://github.com/user-attachments/assets/ca54597b-7bda-408b-b9b8-195dd03ea2df" />


## Installing the necessary dependencies <a id="dependencies"></a>

To install the necessary dependencies, run

```bash
  sudo apt update
```
```bash
  sudo apt upgrade
```
```bash
  sudo apt install nodejs
```

## Demo

A demonstration video on how to install node js

https://github.com/user-attachments/assets/c1e36396-fbe3-4805-aa7a-05551b2dfe31


## Installing NGINX as the default web server <a id="nginx"></a>

- To install nginx, run

```bash
  sudo apt install nginx
```

## Demo

A demonstration video on how to install nginx

https://github.com/user-attachments/assets/d344a961-4785-432b-b79f-3c48e28f2aca

- Then I renamed an already prepared `html` document to `index.nginx-debian.html` (the name for the default html file for nginx)
- I moved this file to the location of the default nginx html path - `/var/www/html`
- Then i executed the command below to reload nginx
  ```bash
  sudo systemctl reload nginx
  ```

A demonstration video on file movement to nginx default path

https://github.com/user-attachments/assets/00abc9be-c3af-4ffb-88d0-33c63bca8763

## Deploying the node web server to be used for reverse proxy <a id="node-app"></a>

- I moved the web-server code file into the designated folder. Web Server code can be found [here](https://github.com/LastPatriot/altschool-semester2-assignment/blob/master/web-server/app.js)
- Moved the required `html file` into the same folder.
- Then run the below to bring the server up

```bash
  node app.js
```
- To confirm that server is working as expected, on a seperate terminal, run
```bash
  curl -vk http://localhost:3000
```

## Demo

A demonstration video confirming that deployment works as expected.

https://github.com/user-attachments/assets/c1368d3b-6749-4b73-8925-ae1a8f02b61c

## Configure Reverse Proxy on NGINX <a id="reverse-proxy"></a>

- Navigate to `/etc/nginx/sites-available`
- Open the file named `default`
- Maintain the configuration for reverse proxy
  ```bash
          location /profile/ {
        # The 'rewrite' directive is crucial here.
        # It removes the '/proxy' prefix before forwarding the request to Node.js.
        # For example, if the client requests /proxy/users, Node.js will receive /users.
        rewrite ^/profile/(.*)$ /$1 break;

        proxy_pass http://127.0.0.1:3000; # Forward requests to the Node.js app
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade; }
  ```
- This will ensure that traffic that matches the pattern `/profile/` will be re-routed to the node web-server.

## Demo

A demonstration video showing reverse proxy configuration on nginx.

https://github.com/user-attachments/assets/fdd32c67-f617-4983-90af-71a1aa08c839

## Running the node web server as Daemon to maintain uptime <a id="daemon"></a>
- To maintain uptime for the node web server, I decided to outsource the management to the Linux server by creating a service file for it.
- This service will be managed by `systemD` and it makes it easy to manage the app using the regular `systemctl` command
- The service file and instruction on how to execute it can be found [here](https://github.com/LastPatriot/altschool-semester2-assignment/blob/master/nodeapp.service)
- This ensures that the web server starts serving as soon as the Linux server is up and can be managed using the following commands.
  ```bash
  sudo systemctl stop nodeapp.service
  sudo systemctl start nodeapp.service
  sudo systemctl restart nodeapp.service
  ```
<img width="1800" alt="Screenshot 2025-06-16 at 23 29 53" src="https://github.com/user-attachments/assets/8d7b00aa-151b-4637-a422-a7ac531e0f77" />

## Enabling port 443 on NGINX using self-signed certificate <a id="port-443"></a>
- I leveraged `open ssl` to generate a self-signed certificate
- Certificate was generated using the command below
  ```bash
  sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsignedlocal.key -out /etc/ssl/certs/nginx-selfsignedlocal.crt
  ```
- The path to the certificate and its key were maintained in the config file for nginx. Please see configuration below.
  ```bash
  server {
    listen 443 ssl;
    server_name localhost; # Use your IP or domain if you have one

    ssl_certificate /etc/ssl/certs/nginx-selfsignedlocal.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsignedlocal.key;

    # Optional: basic SSL settings
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

        root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location /profile/ {
        # The 'rewrite' directive is crucial here.
        # It removes the '/proxy' prefix before forwarding the request to Node.js.
        # For example, if the client requests /proxy/users, Node.js will receive /users.
        rewrite ^/profile/(.*)$ /$1 break;

        proxy_pass http://127.0.0.1:3000; # Forward requests to the Node.js app
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade; }
  ```

## Demo

A demonstration video showing self signed configuration on nginx.

https://github.com/user-attachments/assets/f2a47785-4461-4d23-be58-239fc32e1a9b

A pictorial representation of the self-signed certificate on the webpage

<img width="1800" alt="Screenshot 2025-06-16 at 23 46 28" src="https://github.com/user-attachments/assets/9e6c9a10-2a71-4085-b222-bc96116273d9" />


## Screenshots of the rendered page in a web browser <a id="render"></a>

- Proxied Page
  <img width="1800" alt="Screenshot 2025-06-17 at 00 00 39" src="https://github.com/user-attachments/assets/dcf5ade2-8bb3-4a15-9761-f7ac4b1569fd" />
- Default nginx page
<img width="1800" alt="Screenshot 2025-06-17 at 00 01 15" src="https://github.com/user-attachments/assets/1892ce1b-4f63-433d-88da-ec4f9d0b2205" />


## Contact

For inquiries, you can reach Opeyemi Oluwadare at:
* **Phone:** 08167877918
* **Email:** oluwadareopeyemis1@gmail.com

