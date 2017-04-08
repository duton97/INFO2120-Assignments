#!/usr/bin/env python3

from modules import pg8000
import configparser


# Define some useful variables
ERROR_CODE = 55929

#####################################################
##  Database Connect
#####################################################

def database_connect():
    # Read the config file
    config = configparser.ConfigParser()
    config.read('config.ini')

    # Create a connection to the database
    connection = None
    try:
        connection = pg8000.connect(database=config['DATABASE']['user'],
            user=config['DATABASE']['user'],
            password=config['DATABASE']['password'],
            host=config['DATABASE']['host'])
    except pg8000.OperationalError as e:
        print("""Error, you haven't updated your config.ini or you have a bad
        connection, please try again. (Update your files first, then check
        internet connection)
        """)
        print(e)
    #return the connection to use
    return connection

#####################################################
##  Login
#####################################################

def check_login(email, password):
    # Ask for the database connection, and get the cursor set up
    conn = database_connect()
    if(conn is None):
        return ERROR_CODE
    cur = conn.cursor()
    try:
        # Try executing the SQL and get from the database
        sql = """SELECT nickname, nametitle, namegiven, namefamily, carsharing.member.address, carsharing.carbay.name, since, subscribed, stat_nrofbookings
                 FROM carsharing.member JOIN carsharing.carbay ON(carsharing.member.homebay = carsharing.carbay.bayid)
                 WHERE (email=%s OR nickname = %s) AND password=%s"""
        cur.execute(sql, (email, email, password))
        val = cur.fetchone()
        cur.close()                     # Close the cursor
        conn.close()                    # Close the connection to the db
        return val
    except:
        # If there were any errors, return a NULL row printing an error to the debug
        print("Your password or account is incorrect!")
    cur.close()                     # Close the cursor
    conn.close()                    # Close the connection to the db
    return None


#####################################################
##  Homebay
#####################################################
def update_homebay(email, bayname):
    # Ask for the database connection, and get the cursor set up
    conn = database_connect()
    if(conn is None):
        return ERROR_CODE
    cur = conn.cursor()
    try:
        # Try executing the SQL and get from the database
        sql = """UPDATE member SET homebay = carbay.bayid
                 WHERE (SELECT *
                          FROM carsharing.member JOIN carsharing.carbay ON(carsharing.member.homebay = carsharing.carbay.bayid)
                         WHERE carsharing.member.email = %s AND carsharing.member.name = %s)"""
        cur.execute(sql, (email, bayname))
        val = cur.fetchone()
        cur.close()                     # Close the cursor
        conn.close()                    # Close the connection to the db
        return val
    except:
        # If there were any errors, return a NULL row printing an error to the debug
        print("Error fetching from database")
    cur.close()                     # Close the cursor
    conn.close()                    # Close the connection to the db
    return None

#####################################################
##  Booking (make, get all, get details)
#####################################################

def make_booking(email, car_rego, date, hour, duration):
    # TODO
    # Insert a new booking
    # Make sure to check for:
    #       - If the member already has booked at that time
    #       - If there is another booking that overlaps
    #       - Etc.
    # return False if booking was unsuccessful :)
    # We want to make sure we check this thoroughly
    conn = database_connect()
    if(conn is None):
        return ERROR_CODE
    cur = conn.cursor()
    try:
        # Try executing the SQL and get from the database
        sql = """INSERT INTO carsharing.booking VALUES (%s, (SELECT memberno FROM carsharing.member WHERE email=%s), LOCALTIMESTAMP, %s + %s, %s + (%s + %s)"""
        cur.execute(sql, (car_rego, email, date, hour, date, hour, duration))
        val = cur.fetchone()
        cur.close()                     # Close the cursor
        conn.close()                    # Close the connection to the db
        return val
    except:
        # If there were any errors, return a NULL row printing an error to the debug
        print("Error, booking failed!")
    cur.close()                     # Close the cursor
    conn.close()                    # Close the connection to the db

    return True


def get_all_bookings(email):
    #val = [['66XY99', 'Ice the Cube', '01-05-2016', '10', '4', '29-04-2016'],['66XY99', 'Ice the Cube', '27-04-2016', '16'], ['WR3KD', 'Bob the SmartCar', '01-04-2016', '6']]

    # TODO
    # Get all the bookings made by this member's email
    conn = database_connect()
    if(conn is None):
        return ERROR_CODE
    cur = conn.cursor()
    try:
        # Try executing the SQL and get from the database
        sql = """SELECT regno, name, EXTRACT(date FROM starttime) AS date, EXTRACT(hour FROM starttime) AS hour
                 FROM carsharing.car NATURAL JOIN carsharing.booking NATURAL JOIN carsharing.member
                 WHERE email=%s"""
        cur.execute(sql, (email,))
        val = cur.fetchall()
        cur.close()                     # Close the cursor
        conn.close()                    # Close the connection to the db
        return val
    except:
        # If there were any errors, return a NULL row printing an error to the debug
        print("Error fetching from database")
    cur.close()                     # Close the cursor
    conn.close()                    # Close the connection to the db
    return None

    #return val

def get_booking(b_date, b_hour, car):
    #val = ['Shadow', '66XY99', 'Ice the Cube', '01-05-2016', '10', '4', '29-04-2016', 'SIT']

    # TODO
    # Get the information about a certain booking
    # It has to have the combination of date, hour and car
    conn = database_connect()
    if(conn is None):
        return ERROR_CODE
    cur = conn.cursor()
    try:
        # Try executing the SQL and get from the database
        sql = """SELECT nickname, regno, name, EXTRACT(date FROM starttime) AS date, EXTRACT(hour FROM starttime) AS hour, (EXTRACT(hour FROM endtime) - EXTRACT(hour FROM starttime)) AS duration, whenbooked
                FROM carsharing.car NATURAL JOIN carsharing.booking NATURAL JOIN carsharing.member
                WHERE date=%s AND hour=%s AND regno=%s"""
        cur.execute(sql, (b_date, b_hour, email))
        val = cur.fetchone()
        cur.close()                     # Close the cursor
        conn.close()                    # Close the connection to the db
        return val
    except:
        # If there were any errors, return a NULL row printing an error to the debug
        print("Error fetching from database")
    cur.close()                     # Close the cursor
    conn.close()                    # Close the connection to the db
    return None

    #return val


#####################################################
##  Car (Details and List)
#####################################################

def get_car_details(regno):
    #val = ['66XY99', 'Ice the Cube','Nissan', 'Cube', '2007', 'auto', 'Luxury', '5', 'SIT', '8', 'http://example.com']
    # TODO
    # Get details of the car with this registration number
    # Return the data (NOTE: look at the information, requires more than a simple select. NOTE ALSO: ordering of columns)

    # Ask for the database connection, and get the cursor set up
    conn = database_connect()
    if(conn is None):
        return ERROR_CODE
    cur = conn.cursor()
    try:
        # Try executing the SQL and get from the database
        sql = """SELECT carsharing.car.regno, carsharing.car.name, carsharing.car.make, carsharing.car.model, carsharing.car.year, carsharing.car.transmission, carsharing.carmodel.category, carsharing.carmodel.capacity, carsharing.carbay.name, carsharing.carbay.walkscore, carsharing.carbay.mapurl
                   FROM (carsharing.car JOIN carsharing.carmodel ON(carsharing.car.model = carsharing.carmodel.model AND carsharing.car.make = carsharing.carmodel.make)) JOIN carsharing.carbay
                   ON(carsharing.car.parkedat = carsharing.carbay.bayid)
                   WHERE carsharing.car.regno = %s"""
        cur.execute(sql, (regno,))
        val = cur.fetchall()
        cur.close()                     # Close the cursor
        conn.close()                    # Close the connection to the db
        return val
    except:
        # If there were any errors, return a NULL row printing an error to the debug
        print("Error fetching from database")
    cur.close()                     # Close the cursor
    conn.close()                    # Close the connection to the db
    return None

def get_all_cars():
    #val = [ ['66XY99', 'Ice the Cube', 'Nissan', 'Cube', '2007', 'auto'], ['WR3KD', 'Bob the SmartCar', 'Smart', 'Fortwo', '2015', 'auto']]
    # TODO
    # Get all cars that PeerCar has
    # Return the results

    # Ask for the database connection, and get the cursor set up
    conn = database_connect()
    if(conn is None):
        return ERROR_CODE
    cur = conn.cursor()
    try:
        # Try executing the SQL and get from the database
        sql = """SELECT carsharing.car.regno, carsharing.car.name, carsharing.car.make, carsharing.car.model, carsharing.car.year, carsharing.car.transmission
                   FROM carsharing.car"""
        cur.execute(sql)
        val = cur.fetchone()
        cur.close()                     # Close the cursor
        conn.close()                    # Close the connection to the db
        return val
    except:
        # If there were any errors, return a NULL row printing an error to the debug
        print("Error fetching from database")
    cur.close()                     # Close the cursor
    conn.close()                    # Close the connection to the db
    return None

#####################################################
##  Bay (detail, list, finding cars inside bay)
#####################################################

def get_all_bays():
    # val = [['SIT', '123 Some Street, Boulevard', '2'], ['some_bay', '1 Somewhere Road, Right here', '1']]

    # Get the database connection and set up the cursor
    conn = database_connect()
    if (conn is None):
        return ERROR_CODE
    cur = conn.cursor()
    val = None
    try:
        # Try getting all the information returned from the query
        cur.execute("""SELECT CarBay.name, address, COUNT(regno)
                    FROM CarBay LEFT OUTER JOIN Car ON (bayid = parkedat)
                    GROUP BY CarBay.name, address
                    ORDER BY CarBay.name, address ASC""")
        #SELECT COUNT(regno)
        #FROM Car LEFT OUTER JOIN CarBay ON (bayid = parkedat)
        #WHERE CarBay.name = 'Glebe - Cafe Church'


        val = cur.fetchall()
    except:
        #If there were any errors, we print something nice and return a NULL value
        print("Error fetching from database")

    cur.close()
    conn.close()
    #return val

    # TODO
    # Get all the bays that PeerCar has :)
    # And the number of bays
    # Return the results
    return val

def get_bay(name):
    #val = ['SIT', 'Home to many (happy?) people.', '123 Some Street, Boulevard', '-33.887946', '151.192958']

    conn = database_connect()
    if (conn is None):
        return ERROR_CODE
    cur = conn.cursor()
    val = None
    try:
        cur.execute("""SELECT name, description, address, gps_lat, gps_long
                    FROM CarBay
                    WHERE name=%s""", (name,))
        val = cur.fetchone()
    except:
        print("Error fetching from database")

    cur.close()
    conn.close()


    # TODO
    # Get the information about the bay with this unique name
    # Make sure you're checking ordering ;)

    return val

def search_bays(search_term):
    # val = [['SIT', '123 Some Street, Boulevard', '-33.887946', '151.192958']]

    conn = database_connect()
    cursor = conn.cursor()

    try:
        sql = """SELECT CarBay.name,address, COUNT(regno)
            FROM CarBay LEFT OUTER JOIN Car ON (bayid = parkedat)
            WHERE (LOWER(CarBay.name) LIKE LOWER(%s)) OR (LOWER(address) LIKE LOWER(%s))
            GROUP BY CarBay.name, address
            Order by name,address"""
    # Try getting all the information returned from the query
        cursor.execute(sql,('%'+search_term+'%','%'+search_term+'%') )
        result = cursor.fetchall()

    except:
        print("Error with Database")

    cursor.close()                     # Close the cursor
    conn.close()
    # TODO
    # Select the bays that match (or are similar) to the search term
    # You may like this
    return result

def get_cars_in_bay(bay_name):
    #val = [ ['66XY99', 'Ice the Cube'], ['WR3KD', 'Bob the SmartCar']]

    conn = database_connect()
    if (conn is None):
        return ERROR_CODE
    cur = conn.cursor()
    val = None
    try:
        cur.execute("""SELECT CarSharing.Car.regno, CarSharing.Car.name
                    FROM CarSharing.CarBay LEFT OUTER JOIN CarSharing.Car ON (bayid = parkedat)
                    WHERE CarBay.name =%s""", (bay_name,))
        val = cur.fetchall()
    except:
        print("Error fetching from database")

    cur.close()
    conn.close()

    # TODO
    # Get the cars inside the bay with the bay name
    # Cars who have this bay as their bay :)
    # Return simple details (only regno and name)

    return val
