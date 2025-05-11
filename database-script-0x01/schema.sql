CREATE TABLE USERS (
    user_id INTEGER PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR NULL,
    role VARCHAR CHECK (role IN ('guest', 'host', 'admin')) NOT NULL,
    created_at DATETIME DEFAULT GETDATE() -- get the curretnt date and time
);
--Add a trigger to update the updated_at column
GO
CREATE TRIGGER update_timestamp
ON USERS
AFTER UPDATE
AS
BEGIN
    UPDATE USERS
    SET created_at = GETDATE() -- set the creted at column to the current date and time
    FROM USERS
    INNER JOIN inserted ON USERS.user_id = inserted.user_id;
END;
GO

ALTER TABLE USERS
ALTER COLUMN first_name VARCHAR(20) NOT NULL;

ALTER TABLE USERS
ALTER COLUMN last_name VARCHAR(20) NOT NULL;

ALTER TABLE USERS
ALTER COLUMN email VARCHAR(50) NOT NULL;

ALTER TABLE USERS
ALTER COLUMN password_hash VARCHAR(50) NOT NULL;
ALTER TABLE USERS
ALTER COLUMN first_name VARCHAR(50) NOT NULL;

ALTER TABLE USERS
ALTER COLUMN role VARCHAR(50) NOT NULL;


ALTER TABLE USERS
ALTER COLUMN phone_number VARCHAR(50) NULL;

CREATE TABLE PROPERTY(
    property_id INTEGER PRIMARY KEY,
    host_id INTEGER NOT NULL,
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE() ,
    updates_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (host_id) REFERENCES USERS(user_id)
);
--Add a trigger to update the updated_at column
GO
CREATE TRIGGER update_property_timestamp
ON PROPERTY
AFTER UPDATE
AS
BEGIN
    UPDATE PROPERTY
    SET updates_at = GETDATE()
    FROM PROPERTY
    INNER JOIN inserted ON PROPERTY.property_id = inserted.property_id;
END;
GO


ALTER TABLE PROPERTY
ALTER COLUMN name VARCHAR(50) NOT NULL;

ALTER TABLE PROPERTY
ALTER COLUMN description VARCHAR(50) NOT NULL;

ALTER TABLE PROPERTY
ALTER COLUMN location VARCHAR(50) NOT NULL;


CREATE TABLE BOOKING(
    booking_id INTEGER PRIMARY KEY,
    property_id INTEGER NOT NULL,
    guest_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    status VARCHAR CHECK (status IN ('pending', 'confirmed', 'cancelled')) NOT NULL,
    FOREIGN KEY (property_id) REFERENCES PROPERTY(property_id),
    FOREIGN KEY (guest_id) REFERENCES USERS(user_id)
);
--Add a trigger to update the updated_at column
GO
CREATE TRIGGER update_booking_timestamp
ON BOOKING  
AFTER UPDATE
AS  
BEGIN
    UPDATE BOOKING
    SET created_at = GETDATE()
    FROM BOOKING
    INNER JOIN inserted ON BOOKING.booking_id = inserted.booking_id;
END;
GO

ALTER TABLE BOOKING
ALTER COLUMN status VARCHAR(20) NOT NULL;


CREATE TABLE Payment(
    payment_id INTEGER PRIMARY KEY,
    booking_id INTEGER NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    payment_method VARCHAR CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id)
);
--Add a trigger to update the updated_at column
GO
CREATE TRIGGER update_payment_timestamp
ON Payment
AFTER UPDATE
AS
BEGIN
    UPDATE Payment
    SET payment_date = GETDATE()
    FROM Payment
    INNER JOIN inserted ON Payment.payment_id = inserted.payment_id;
END;
GO

ALTER TABLE Payment
ALTER COLUMN payment_method VARCHAR(20) NOT NULL;

CREATE TABLE REVIEW(
    review_id INTEGER PRIMARY KEY,
    property_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    comment TEXT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (property_id) REFERENCES PROPERTY(property_id),
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);
--Add a trigger to update the updated_at column
GO
CREATE TRIGGER update_review_timestamp  
ON REVIEW
AFTER UPDATE
AS
BEGIN
    UPDATE REVIEW
    SET created_at = GETDATE()
    FROM REVIEW
    INNER JOIN inserted ON REVIEW.review_id = inserted.review_id;
END;
GO

ALTER TABLE REVIEW
ALTER COLUMN comment VARCHAR(50) NULL;

CREATE TABLE MESSAGE(
    message_id INTEGER PRIMARY KEY,
    sender_id INTEGER NOT NULL,
    receiver_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    message_body TEXT NOT NULL,
    sent_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (sender_id) REFERENCES USERS(user_id),
    FOREIGN KEY (receiver_id) REFERENCES USERS(user_id),
    FOREIGN KEY (property_id) REFERENCES PROPERTY(property_id)
);
--Add a trigger to update the updated_at column
GO
CREATE TRIGGER update_message_timestamp
ON MESSAGE
AFTER UPDATE
AS
BEGIN
    UPDATE MESSAGE
    SET sent_at = GETDATE()
    FROM MESSAGE
    INNER JOIN inserted ON MESSAGE.message_id = inserted.message_id;
END;
GO

ALTER TABLE MESSAGE
ALTER COLUMN message_body VARCHAR(100) NOT NULL;


-- Indexes for PROPERTY table
CREATE NONCLUSTERED INDEX idx_property_location
ON PROPERTY (location);

CREATE NONCLUSTERED INDEX idx_property_host
ON PROPERTY (host_id);

-- Indexes for BOOKING table
CREATE NONCLUSTERED INDEX idx_booking_status
ON BOOKING (status);

CREATE NONCLUSTERED INDEX idx_booking_guest
ON BOOKING (guest_id);

CREATE NONCLUSTERED INDEX idx_booking_dates
ON BOOKING (start_date, end_date);

CREATE NONCLUSTERED INDEX idx_booking_created_at
ON BOOKING (created_at);

-- Indexes for MESSAGE table
CREATE NONCLUSTERED INDEX idx_message_receiver
ON MESSAGE (receiver_id);

CREATE NONCLUSTERED INDEX idx_message_property
ON MESSAGE (property_id);

CREATE NONCLUSTERED INDEX idx_message_sent_at
ON MESSAGE (sent_at);

-- Indexes for REVIEW table
CREATE NONCLUSTERED INDEX idx_review_property
ON REVIEW (property_id);

CREATE NONCLUSTERED INDEX idx_review_user_property
ON REVIEW (user_id, property_id);

CREATE NONCLUSTERED INDEX idx_review_created_at
ON REVIEW (created_at);

-- Indexes for PAYMENT table
CREATE NONCLUSTERED INDEX idx_payment_date
ON Payment (payment_date);

CREATE NONCLUSTERED INDEX idx_payment_method
ON Payment (payment_method);

-- Indexes for USERS table
CREATE NONCLUSTERED INDEX idx_users_email
ON USERS (email);

CREATE NONCLUSTERED INDEX idx_users_role
ON USERS (role);

CREATE NONCLUSTERED INDEX idx_users_name
ON USERS (first_name, last_name);       

