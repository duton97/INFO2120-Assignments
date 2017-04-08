INSERT INTO A2.CarModel (make, model, category, capacity)
VALUES ("Toyota", "Corolla", "Midsize Car", 5);

INSERT INTO A2.CarBay (name, address, description, latitude, longitude)
VALUES ("Sydney Uni Foot-bridge", "Around Usyd area", -33.884, 151.187);

INSERT INTO A2.MembershipPlan (title, monthly_fee, hourly_fee, km_rate, daily_rate, daily_km_rate, daily_km_included)
VALUES ("Best plan", $500, $10, $4, $20, $15, "15km");

INSERT INTO A2.Car
VALUES ("AAA 000", "Car", 2000, "Automatic", "Toyota", "Corolla", "Sydney Uni Foot-bridge");

INSERT INTO A2.Member
VALUES ("abc@gmail.com", "0000", "Mr.", "Smith", "Dick", "123456789", "01/01/2017", "12 hello street", 01/01/1980, 2016/04, "DSmith", "Best Plan");

INSERT INTO A2.Phone
VALUES ("abc@gmail.com", 0449000000);

INSERT INTO A2.Booking
VALUES (26/04/2016, 1500, 2, "AAA 000", "abc@gmail.com");

INSERT INTO A2.PaymentMethod
VALUES (1, "abc@gmail.com");

INSERT INTO A2.BankAccount
VALUES (1, "Dick Smith", 000011112222, 9999);

INSERT INTO A2.PayPal
VALUES (1, "abc@gmail.com");

INSERT INTO A2.CreditCard
VALUES (1, "Dick Smith", "VISA", "01/2017", 012345);


