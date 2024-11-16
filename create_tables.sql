---- Query to create the table transactions

CREATE TABLE IF NOT EXISTS  transactions (
    transaction_id VARCHAR(36), 
    user_id VARCHAR(36),
    amount DECIMAL(15, 2),
    timestamp DATETIME,
    transaction_type VARCHAR(50)
);

---- Query to create the table packages
CREATE TABLE IF NOT EXISTS  packages (
    package_id VARCHAR(36), 
    courier VARCHAR(50),
    delivery_date DATETIME,
    delivery_status VARCHAR(50),
    user_id VARCHAR(36)
);

---- Query to create the table users
CREATE TABLE IF NOT EXISTS  users (
    user_id VARCHAR(36), 
    name VARCHAR(75),
    email VARCHAR(100),
    join_date DATETIME
);

