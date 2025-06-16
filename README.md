
# SERVER PROVISIONING AND WEBSERVER DEPLOYMENT - Opeyemi Oluwadare

This project involves setting up a server and deploying a dynamic webpage. Key elements include configuring a reverse proxy to efficiently route requests and implementing SSL/TLS encryption to secure data transmission.


## Outline

 - [Provisioning the server](#server-provisioning)
 - [Installing the necessary dependencies](#dependencies)
 - [NGINX Installation](#nginx)
  - [Installing Node and deploying the node App](https://awesomeopensource.com/project/elangosundar/awesome-README-templates)



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



