BEGIN TRANSACTION;

SET search_Path = '$user', public, A2;

INSERT INTO CarModel VALUES ('Toyota', 'Corolla', 'Midsize', 5);
INSERT INTO CarModel VALUES ('Mitsubishi', 'Outlander', 'Van', 10);
INSERT INTO CarModel VALUES ('Nissan', 'Nissan X-Trail', 'Compact', 3);
INSERT INTO CarModel VALUES ('Suzuki', 'Swift', 'Ute', 8);
INSERT INTO CarModel VALUES ('Mazda', 'Mazda BT-50', 'Economy', 6);

INSERT INTO CarBay VALUES ('Sydney Uni', 'Around Usyd area', 'Uni student only', 33.885264, 151.185237);
INSERT INTO CarBay VALUES ('Central', 'Central Sydney', NULL, 62.884324, 112.623627);
INSERT INTO CarBay VALUES ('CBD', 'Central Business District', NULL, -25.135613, 121.262187);
INSERT INTO CarBay VALUES ('Beach', 'Bondi Junction', 'For everyone', -23.467884, 111.126487);
INSERT INTO CarBay VALUES ('UTS', 'Near Central Station', NULL, 91.834484, 101.753187);

INSERT INTO MembershipPlan VALUES ('Plan1', 500, 10, 4, 20, 15, 15);
INSERT INTO MembershipPlan VALUES ('Plan2', 400, 20, 3, NULL, 15, 20);
INSERT INTO MembershipPlan VALUES ('Plan3', 300, 30, 2, 20, 15, 19);
INSERT INTO MembershipPlan VALUES ('Plan4', 200, 40, 6, 20, NULL, 18);
INSERT INTO MembershipPlan VALUES ('Plan5', 100, 50, 7, NULL, 15, 17);

INSERT INTO Car VALUES ('AAA001', 'Car1', 2000, 'automatic', 'Toyota', 'Corolla', 'Sydney Uni');
INSERT INTO Car VALUES ('AAA002', 'Car2', 2001, 'manual', 'Mitsubishi', 'Outlander', 'Central');
INSERT INTO Car VALUES ('AAA003', 'Car3', 2002, 'automatic', 'Nissan', 'Nissan X-Trail', 'CBD');
INSERT INTO Car VALUES ('AAA004', 'Car4', 2003, 'manual', 'Suzuki', 'Swift', 'Beach');
INSERT INTO Car VALUES ('AAA005', 'Car5', 2004, 'automatic', 'Mazda', 'Mazda BT-50', 'UTS');

INSERT INTO Member VALUES ('1@gmail.com', '1111', 'M', 'Gordon', 'Ramsay', 'A1234', '01/01/2017', '12 hello street', '01/01/1981', '2015/04', 'DSmith', 'Plan1');
INSERT INTO Member VALUES ('2@gmail.com', '2222', 'F', 'Gordon', 'Ramsay', 'B1234', '01/02/2017', '15 hello street', '01/01/1982', '2015/05', NULL, 'Plan2');
INSERT INTO Member VALUES ('3@gmail.com', '3333', 'M', 'Gordon', 'Ramsay', 'C1234', '01/03/2017', '14 hello street', '01/01/1983', '2015/06', 'HSmith', 'Plan3');
INSERT INTO Member VALUES ('4@gmail.com', '4444', 'F', 'Gordon', 'Ramsay', 'D1234', '01/04/2017', '13 hello street', '01/01/1984', '2015/07', NULL, 'Plan4');
INSERT INTO Member VALUES ('5@gmail.com', '5555', 'M', 'Gordon', 'Ramsay', 'E1234', '01/05/2017', '11 hello street', '01/01/1985', '2015/08', 'DaSmith', 'Plan5');

INSERT INTO Phone VALUES ('1@gmail.com', 04490000);
INSERT INTO Phone VALUES ('2@gmail.com', 04490063);
INSERT INTO Phone VALUES ('3@gmail.com', 04490000);
INSERT INTO Phone VALUES ('4@gmail.com', 03436346);
INSERT INTO Phone VALUES ('5@gmail.com', 04634623);

INSERT INTO Booking VALUES ('26/04/2016', 1500, 2, 'AAA001', '1@gmail.com');
INSERT INTO Booking VALUES ('25/04/2016', 1600, 3, 'AAA002', '2@gmail.com');
INSERT INTO Booking VALUES ('24/04/2016', 1700, 4, 'AAA003', '3@gmail.com');
INSERT INTO Booking VALUES ('23/04/2016', 1800, 5, 'AAA004', '4@gmail.com');
INSERT INTO Booking VALUES ('22/04/2016', 1900, 6, 'AAA005', '5@gmail.com');

INSERT INTO PaymentMethod VALUES (1, '1@gmail.com');
INSERT INTO PaymentMethod VALUES (2, '2@gmail.com');
INSERT INTO PaymentMethod VALUES (3, '3@gmail.com');
INSERT INTO PaymentMethod VALUES (4, '4@gmail.com');
INSERT INTO PaymentMethod VALUES (5, '5@gmail.com');

INSERT INTO BankAccount VALUES (1, 'Gordon', 000011, 9999);
INSERT INTO BankAccount VALUES (2, 'Gordon', 062346, 9319);

INSERT INTO PayPal VALUES (4, '4@gmail.com');
INSERT INTO PayPal VALUES (5, '5@gmail.com');

INSERT INTO CreditCard VALUES (3, 'Gordon', 'MASTERCARD', '02/2017', 268258);

COMMIT;