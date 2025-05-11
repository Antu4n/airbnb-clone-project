INSERT INTO USERS VALUES 
(1, 'Luke', 'Skywalker', 'luke@jedi.com', 'pass123', '1234567890', 'guest', GETDATE()),
(2, 'Leia', 'Organa', 'leia@rebellion.com', 'pass456', '0987654321', 'host', GETDATE()),
(3, 'Han', 'Solo', 'han@falcon.com', 'pass789', NULL, 'admin', GETDATE()),
(4, 'Chewbacca', 'Wookiee', 'chewie@kashyyyk.com', 'roar123', NULL, 'guest', GETDATE());

INSERT INTO PROPERTY VALUES 
(1, 2, 'Rebel Base', 'Secret base in the Yavin system', 'Yavin IV', 150.00, GETDATE(), GETDATE()),
(2, 2, 'Cloud City', 'A city in the clouds on Bespin', 'Bespin', 200.00, GETDATE(),GETDATE());

INSERT INTO BOOKING (booking_id, property_id, guest_id, start_date, end_date, total_price, created_at, status) 
VALUES
(1, 1, 4, '2025-06-01', '2025-06-07', 1200.00, GETDATE(), 'confirmed'),
(2, 2, 1, '2025-07-15', '2025-07-20', 750.00, GETDATE(), 'pending'),
(3, 1, 3, '2025-08-10', '2025-08-14', 800.00, GETDATE(), 'cancelled');

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) 
VALUES
(1, 1, 1200.00, GETDATE(), 'credit_card'),
(2, 2, 750.00, GETDATE(), 'paypal'),
(3, 3, 800.00, GETDATE(), 'stripe');

INSERT INTO REVIEW (review_id, property_id, user_id, rating, comment, created_at) 
VALUES
(1, 1, 4, 5, 'Fantastic stay! The Falcon Nest is a dream.', GETDATE()),
(2, 2, 1, 4, 'Nice place, but a bit too remote for my liking.', GETDATE());

INSERT INTO MESSAGE (message_id, sender_id, receiver_id, property_id, message_body, sent_at) 
VALUES
(1, 4, 2, 1, 'Is Falcon Nest available from 1st June?', GETDATE()),
(2, 1, 2, 2, 'I would like more details about the Wookiee Hut.', GETDATE()),
(3, 3, 2, 1, 'Please confirm the booking details for the Falcon Nest.', GETDATE());

SELECT * FROM USERS;
SELECT * FROM PROPERTY;
SELECT * FROM BOOKING;
SELECT * FROM Payment;
SELECT * FROM REVIEW;
SELECT * FROM MESSAGE;
