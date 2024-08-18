DROP SCHEMA IF EXISTS parking_management CASCADE;
CREATE SCHEMA IF NOT EXISTS parking_management;

DROP TABLE IF EXISTS parking_management.user_subscriptions;
DROP TABLE IF EXISTS parking_management.vehicle_registration;
DROP TABLE IF EXISTS parking_management.transaction_records;
DROP TABLE IF EXISTS parking_management.parking_records;
DROP TABLE IF EXISTS parking_management.users;

CREATE TABLE parking_management.users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(10) NOT NULL
);
CREATE TABLE parking_management.user_subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES parking_management.users(user_id),
    start_date DATE,
    end_date DATE,
    parking_space INT
);

CREATE TABLE parking_management.vehicle_registration (
    registration_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES parking_management.users(user_id),
    registration_number VARCHAR(7)
);

CREATE TABLE parking_management.transaction_records (
    transaction_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES parking_management.users(user_id),
    transaction_date DATE,
    amount DECIMAL(10, 2),
    description TEXT
);

CREATE TABLE parking_management.parking_records (
    record_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES parking_management.users(user_id),
    entry_time TIMESTAMP,
    leave_time TIMESTAMP,
    parking_space INT
);

INSERT INTO parking_management.users (full_name, email, password, phone_number)
VALUES
('John Doe', 'user1@example.com', 'password1', '1234567890'),
('Jane Smith', 'user2@example.com', 'password2', '1234567891'),
('Robert Brown', 'user3@example.com', 'password3', '1234567892'),
('Emily Davis', 'user4@example.com', 'password4', '1234567893'),
('Michael Wilson', 'user5@example.com', 'password5', '1234567894'),
('Sarah Johnson', 'user6@example.com', 'password6', '1234567895'),
('William Lee', 'user7@example.com', 'password7', '1234567896'),
('Jessica White', 'user8@example.com', 'password8', '1234567897'),
('David Harris', 'user9@example.com', 'password9', '1234567898'),
('Susan Martin', 'user10@example.com', 'password10', '1234567899'),
('Daniel Thompson', 'user11@example.com', 'password11', '1234567800'),
('Laura Garcia', 'user12@example.com', 'password12', '1234567801');

INSERT INTO parking_management.vehicle_registration (user_id, registration_number)
VALUES
(1, 'AB10FFV'),
(2, 'AG49XRF'),
(3, 'AR05DAN'),
(4, 'BC10VIC'),
(5, 'BH19ERP'),
(6, 'BN23GOA'),
(7, 'BR50ETT'),
(8, 'BT41XYZ'),
(9, 'BV91ABC'),
(10, 'CJ69CLJ'),
(11, 'CL33DFE'),
(12, 'CS73SAD');

INSERT INTO parking_management.user_subscriptions (user_id, start_date, end_date, parking_space)
VALUES
(1, '2024-01-01', '2024-12-31', 1),
(2, '2024-02-01', '2024-11-30', 2),
(3, '2024-03-01', '2024-10-31', 3),
(4, '2024-04-01', '2024-09-30', 4),
(5, '2024-05-01', '2024-08-31', 5),
(6, '2024-06-01', '2024-07-31', 6),
(7, '2024-07-01', '2024-06-30', 1),
(8, '2024-08-01', '2024-05-31', 2),
(9, '2024-09-01', '2024-04-30', 3),
(10, '2024-10-01', '2024-03-31', 4),
(11, '2024-11-01', '2024-02-29', 5),
(12, '2024-12-01', '2024-01-31', 6);

INSERT INTO parking_management.transaction_records (user_id, transaction_date, amount, description)
VALUES
(1, '2024-01-01', 100.00, 'Monthly subscription payment'),
(2, '2024-02-01', 90.00, 'Monthly subscription payment'),
(3, '2024-03-01', 80.00, 'Monthly subscription payment'),
(4, '2024-04-01', 70.00, 'Monthly subscription payment'),
(5, '2024-05-01', 60.00, 'Monthly subscription payment'),
(6, '2024-06-01', 50.00, 'Monthly subscription payment'),
(7, '2024-07-01', 40.00, 'Monthly subscription payment'),
(8, '2024-08-01', 30.00, 'Monthly subscription payment'),
(9, '2024-09-01', 20.00, 'Monthly subscription payment'),
(10, '2024-10-01', 10.00, 'Monthly subscription payment'),
(11, '2024-11-01', 5.00, 'Monthly subscription payment'),
(12, '2024-12-01', 1.00, 'Monthly subscription payment');

INSERT INTO parking_management.parking_records (user_id, entry_time, leave_time, parking_space)
VALUES
(1, '2024-01-01 08:00:00', '2024-01-01 18:00:00', 1),
(2, '2024-02-01 08:00:00', '2024-02-01 18:00:00', 2),
(3, '2024-03-01 08:00:00', '2024-03-01 18:00:00', 3),
(4, '2024-04-01 08:00:00', '2024-04-01 18:00:00', 4),
(5, '2024-05-01 08:00:00', '2024-05-01 18:00:00', 5),
(6, '2024-06-01 08:00:00', '2024-06-01 18:00:00', 6),
(7, '2024-07-01 08:00:00', '2024-07-01 18:00:00', 1),
(8, '2024-08-01 08:00:00', '2024-08-01 18:00:00', 2),
(9, '2024-09-01 08:00:00', '2024-09-01 18:00:00', 3),
(10, '2024-10-01 08:00:00', '2024-10-01 18:00:00', 4),
(11, '2024-11-01 08:00:00', '2024-11-01 18:00:00', 5),
(12, '2024-12-01 08:00:00', '2024-12-01 18:00:00', 6);
