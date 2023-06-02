USE mydb;

INSERT INTO customers (Name, Email, Phone)
VALUES ('John', 'John@email.com', '123456789');
INSERT INTO customers (Name, Email, Phone)
VALUES ('Joe', 'Joe@email.com', '123456789');

UPDATE customers  
SET Name = ('Bob'), Email = ('Bob@email.com'), Phone = ('123458568') 
WHERE id = 2;
UPDATE customers
SET Email = 'john.smith@email.com', Phone = '987654321'
WHERE Name = 'John';

Delete FROM customers 
WHERE Name = 'John' AND Email = 'John@email.com' AND Phone = '123456789';
DELETE FROM customers
WHERE Phone = '555555555';

ALTER TABLE customers
CHANGE COLUMN Phone Contact_Number VARCHAR(15);


INSERT INTO payments (Payment_Method, Payment_Amount)
VALUES ( 'Credit Card - Visa', '$1,250');
INSERT INTO payments (Payment_Method, Payment_Amount)
VALUES ( 'Check', '$5,000');

UPDATE payments 
SET Payment_Method = 'Credit Card - MasterCard', Payment_Amount = '$1,500'
WHERE Payment_Method = 'Credit Card - Visa' AND Payment_Amount = '$1,250';
UPDATE payments
SET Payment_Amount = '$1,800'
WHERE Payment_Method = 'Credit Card - MasterCard';

DELETE FROM payments
WHERE Payment_Method = 'Check' AND Payment_Amount = '$5,000';
DELETE FROM payments
WHERE Payment_Method = 'Cash';

ALTER TABLE payments
ADD CONSTRAINT FK_CustomerID
FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID);


INSERT INTO flights (Airline, Departure_City, Arrival_City, Departure_Time, Arrival_Time)
VALUES ('Delta', 'New York', 'Los Angeles', '08:00 AM', '11:00 AM');
INSERT INTO flights (Airline, Departure_City, Arrival_City, Departure_Time, Arrival_Time)
VALUES ('United', 'Chicago', 'San Francisco', '10:30 AM', '01:30 PM');

UPDATE flights
SET Departure_City = 'Los Angeles', Arrival_City = 'New York', Departure_Time = '10:00 AM', Arrival_Time = '03:00 PM'
WHERE Airline = 'Delta';
UPDATE flights
SET Departure_City = 'Phoenix', Arrival_Time = '06:00 PM'
WHERE Arrival_City = 'San Francisco';

DELETE FROM flights
WHERE Airline = 'United';
DELETE FROM flights
WHERE Departure_City = 'Boston' OR Arrival_City = 'Orlando';

ALTER TABLE flights
ADD COLUMN Flight_Status VARCHAR(50);


INSERT INTO hotels (Hotel_Name, Address, Destinations_id)
VALUES ('Grand Hotel', '123 Main Street, New York', 1);
INSERT INTO hotels (Hotel_Name, Address, Destinations_id)
VALUES ('Oceanfront Resort', '234 Seaside Drive, Los Angeles', 4);

UPDATE hotels
SET Address = '456 Broadway, New York', Destinations_id = 2
WHERE Hotel_Name = 'Grand Hotel';
UPDATE hotels
SET Address = '345 Beachfront Avenue, Los Angeles', Destinations_id = 5
WHERE Hotel_Name = 'Oceanfront Resort';

DELETE FROM hotels
WHERE Hotel_Name = 'Grand Hotel';
DELETE FROM hotels
WHERE Address = '234 Seaside Drive, Los Angeles' OR Destinations_id = 4;

ALTER TABLE hotels
MODIFY COLUMN Address TEXT;


INSERT INTO destinations (Name, Description, Price)
Values ('Paris', 'City of love and romance', 1500.00);
INSERT INTO destinations (Name, Description, Price)
Values ('Tokyo', 'Vibrant city with rich cultural heritage', 2000.00);

UPDATE destinations
SET Description = 'City of love and lights', Price = 1800.00
WHERE Name = 'Paris';
UPDATE destinations
SET Description = 'Modern metropolis with traditional charm', Price = 2300.00
WHERE Name = 'Tokyo';

DELETE FROM destinations
WHERE Name = 'Paris';
DELETE FROM destinations
WHERE Price <= 2000.00;

ALTER TABLE destinations
DROP COLUMN Price;


SELECT *
FROM flights AS f
JOIN hotels AS h ON f.DestinationID = h.DestinationID
JOIN destinations AS d ON f.DestinationID = d.DestinationID
JOIN payments AS p ON p.CustomerID = f.CustomerID
JOIN customers AS c ON c.CustomerID = p.CustomerID;


SELECT *
FROM flights
INNER JOIN destinations ON flights.DestinationID = destinations.DestinationID;
SELECT *
FROM flights
LEFT JOIN destinations ON flights.DestinationID = destinations.DestinationID;
SELECT *
FROM flights
RIGHT JOIN destinations ON flights.DestinationID = destinations.DestinationID;
SELECT *
FROM hotels
RIGHT JOIN destinations ON hotels.Destinations_id = destinations.DestinationID
INNER JOIN flights ON hotels.Destinations_id = flights.DestinationID;


SELECT DestinationID, COUNT(*) AS TotalFlights
FROM flights
GROUP BY DestinationID;

SELECT DestinationID, AVG(Price) AS AvgPrice
FROM hotels
GROUP BY DestinationID;

SELECT CustomerID, MAX(Payment_Amount) AS MaxPayment
FROM payments
GROUP BY CustomerID;

SELECT DestinationID, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM destinations
GROUP BY DestinationID;

SELECT d.DestinationID, COUNT(*) AS NumCustomers
FROM destinations d
JOIN flights f ON d.DestinationID = f.DestinationID
JOIN customers c ON f.CustomerID = c.CustomerID
JOIN payments p ON c.CustomerID = p.CustomerID
WHERE p.Payment_Amount > 1000
GROUP BY d.DestinationID;

SELECT d.DestinationID, SUM(p.Payment_Amount) AS TotalPayment
FROM destinations d
JOIN flights f ON d.DestinationID = f.DestinationID
JOIN customers c ON f.CustomerID = c.CustomerID
JOIN payments p ON c.CustomerID = p.CustomerID
GROUP BY d.DestinationID
HAVING SUM(p.Payment_Amount) >= 5000;

SELECT Airline, AVG(Departure_Delay) AS AvgDepartureDelay
FROM flights
GROUP BY Airline;


SELECT COUNT(*) AS TotalCustomers
FROM payments
GROUP BY CustomerID
HAVING SUM(Payment_Amount) > 1000;

SELECT CustomerID, AVG(Payment_Amount) AS AvgPaymentAmount
FROM payments
GROUP BY CustomerID
HAVING COUNT(*) >= 5;

SELECT City, MAX(Payment_Amount) AS MaxPaymentAmount
FROM customers
JOIN payments ON customers.CustomerID = payments.CustomerID
GROUP BY City;

SELECT Airline, COUNT(*) AS TotalFlights
FROM flights
GROUP BY Airline
HAVING COUNT(*) > 50;

SELECT DestinationID, AVG(Price) AS AvgHotelPrice
FROM hotels
GROUP BY DestinationID
HAVING COUNT(*) > 10;

SELECT DestinationID, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM destinations
GROUP BY DestinationID
HAVING AVG(Price) > 2000;

SELECT DestinationID, COUNT(*) AS NumDestinations
FROM flights
JOIN destinations ON flights.DestinationID = destinations.DestinationID
GROUP BY DestinationID
HAVING COUNT(*) > 100 AND AVG(Price) < 500;