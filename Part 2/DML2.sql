INSERT INTO A2.CarModel (make, model, category, capacity)
VALUES ("Honda", "CR-V", "SUV", 5);

INSERT INTO A2.CarBay (name, address, description, latitude, longitude)
VALUES ("Chinatown", "Around city area", -33.880, 151.199);

INSERT INTO A2.MembershipPlan (title, monthly_fee, hourly_fee, km_rate, daily_rate, daily_km_rate, daily_km_included)
VALUES ("Cheap plan", $300, $7, $3, $13, $11, "10km");

INSERT INTO A2.Car
VALUES ("BBB 111", "Swag", 2008, "Automatic", "Honda", "CR-V", "Chinatown");

INSERT INTO A2.Member
VALUES ("abc@hotmail.com", "9999", "Ms.", "Hilary", "Clinton", "987654321", "01/01/2018", "99 bye street", 01/01/1950, 2017/04, "HClinton", "Cheap Plan");

INSERT INTO A2.Phone
VALUES ("abc@hotmail.com", 0449111111);

INSERT INTO A2.Booking
VALUES (30/04/2016, 900, 1, "BBB 111", "abc@hotmail.com");

INSERT INTO A2.PaymentMethod
VALUES (2, "abc@hotmail.com");

INSERT INTO A2.BankAccount
VALUES (2, "Hilary Clinton", 000011113333, 1111);

INSERT INTO A2.PayPal
VALUES (2, "abc@hotmail.com");

INSERT INTO A2.CreditCard
VALUES (2, "Hilary Clinton", "Master", "04/2017", 543210);
