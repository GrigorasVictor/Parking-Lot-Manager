-- Create Schema
CREATE SCHEMA IF NOT EXISTS parking_management;

-- Drop Tables if they exist
DROP TABLE IF EXISTS parking_management.user_subscriptions;
DROP TABLE IF EXISTS parking_management.vehicle_registration;
DROP TABLE IF EXISTS parking_management.users;
DROP TABLE IF EXISTS parking_management.transaction_records;
DROP TABLE IF EXISTS parking_management.parking_records;

-- Create Tables

-- User Subscriptions Table
CREATE TABLE parking_management.user_subscriptions (
    user_id SERIAL PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    parking_space VARCHAR(50)
);

-- Users Table
CREATE TABLE parking_management.users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50) NOT NULL
);

-- Vehicle Registration Table
CREATE TABLE parking_management.vehicle_registration (
    user_id INTEGER REFERENCES parking_management.users(user_id),
    registration_number VARCHAR(50),
    PRIMARY KEY (user_id, registration_number)
);

-- Transaction Records Table
CREATE TABLE parking_management.transaction_records (
    transaction_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES parking_management.users(user_id),
    transaction_date DATE,
    amount DECIMAL(10, 2),
    description TEXT
);

-- Parking Records Table
CREATE TABLE parking_management.parking_records (
    record_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES parking_management.users(user_id),
    entry_time TIMESTAMP,
    leave_time TIMESTAMP,
    parking_space VARCHAR(50)
);
