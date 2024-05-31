mysql-101
==

# THIS IS STILL A DRAFT

It's a mixture of notes that needs to be cleaned up.

## Installatiom

### On Desktop (Mac OS)

* https://www.mysql.com/downloads/
* Install Community edition

### Online

* https://onecompiler.com/mysql

### Via Docker

Running MySQL in Docker on a Mac involves several steps, including installing Docker, pulling the MySQL image, and running a MySQL container. Here’s a step-by-step guide:

### Step 1: Install Docker

1. **Download Docker for Mac:**
   - Go to the [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop) page.
   - Click "Download for Mac" and follow the instructions to download the installer.

2. **Install Docker:**
   - Open the downloaded `.dmg` file.
   - Drag the Docker icon to the Applications folder.
   - Open Docker from the Applications folder.
   - Follow the installation prompts and enter your password if prompted.

3. **Verify Docker Installation:**
   - Open a terminal.
   - Run the command: `docker --version`
   - You should see the Docker version information.

### Step 2: Pull the MySQL Docker Image

1. **Open Terminal:**
   - You can open Terminal from the Applications folder or by using Spotlight Search (Cmd + Space and type "Terminal").

2. **Pull the MySQL Image:**
   - In the terminal, run the following command to pull the latest MySQL image from Docker Hub:
     ```sh
     docker pull mysql:latest
     ```

### Step 3: Run a MySQL Container

1. **Run the MySQL Container:**
   - Use the following command to run a MySQL container:
     ```sh
     docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest
     ```
   - Here, `--name mysql-container` names the container, `-e MYSQL_ROOT_PASSWORD=my-secret-pw` sets the root password for MySQL, and `-d` runs the container in detached mode.

2. **Verify the Container is Running:**
   - Run the command:
     ```sh
     docker ps
     ```
   - You should see your MySQL container listed.

### Step 4: Connect to the MySQL Container

1. **Connect to MySQL:**
   - To connect to the MySQL server running in the container, you can use the `docker exec` command to open a bash shell inside the container:
     ```sh
     docker exec -it mysql-container mysql -uroot -p
     ```
   - Enter the root password (`my-secret-pw` in this example) when prompted.

### Step 5: Optional - Persistent Data Storage

By default, data stored in the MySQL container is ephemeral and will be lost when the container is removed. To persist data, you need to mount a volume.

1. **Run MySQL with a Volume:**
   - Use the following command to create a MySQL container with a mounted volume:
     ```sh
     docker run --name mysql-container -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest
     ```
   - This mounts a named volume `mysql-data` to the MySQL data directory inside the container.

### Step 6: Stop and Remove the Container (Optional)

1. **Stop the Container:**
   - Run the command:
     ```sh
     docker stop mysql-container
     ```

2. **Remove the Container:**
   - Run the command:
     ```sh
     docker rm mysql-container
     ```

3. **Remove the Volume (if used):**
   - Run the command:
     ```sh
     docker volume rm mysql-data
     ```

### Summary of Commands

- Install Docker for Mac
- Pull MySQL image: `docker pull mysql:latest`
- Run MySQL container: `docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest`
- Connect to MySQL: `docker exec -it mysql-container mysql -uroot -p`
- Run MySQL with a volume: `docker run --name mysql-container -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest`
- Stop the container: `docker stop mysql-container`
- Remove the container: `docker rm mysql-container`
- Remove the volume: `docker volume rm mysql-data`

This guide should help you get MySQL running in a Docker container on your Mac.

## Issues

* The **make connect** command waits for the user to enter a password, but the screen doesn't indicate that's what it's doing.

## MySQL Workbench

Will get incompatibility warning is version later than 8.0:

* https://dev.mysql.com/downloads/workbench/


* * *

## General Usage

1. Launch MySQL Workbench
2. Create a new Schema
3. Use the SQL editor to create a table like this:

```sql
USE `my-schema`;

-- create
CREATE TABLE EMPLOYEE (
  empId INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  dept TEXT NOT NULL
);

-- insert
INSERT INTO EMPLOYEE VALUES (0001, 'Clark', 'Sales');
INSERT INTO EMPLOYEE VALUES (0002, 'Dave', 'Accounting');
INSERT INTO EMPLOYEE VALUES (0003, 'Ava', 'Sales');

-- fetch 
SELECT * FROM EMPLOYEE WHERE dept = 'Sales';
```

