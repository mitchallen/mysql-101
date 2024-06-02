DROP DATABASE IF EXISTS hello_world_db;

-- Create a new database
CREATE DATABASE hello_world_db;

-- Switch to the new database
USE hello_world_db;

-- Create a new table
CREATE TABLE greetings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL
);

-- Insert a "Hello, World!" message into the table
INSERT INTO greetings (message) VALUES ('Hello, World!');

-- Select the message from the table
SELECT message FROM greetings;

-- Output should be: "Hello, World!"
