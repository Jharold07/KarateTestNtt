Feature: POST, GET by ID, PUT, DELETE

  Background:
    * url 'https://restful-booker.herokuapp.com'
    * configure headers = { Accept: 'application/json', Content-Type: 'application/json' }

  Scenario: Crear, get, actualizar y eliminar un BOkkidn
    # POST: crear
    * def payload =
      """
      {
        "firstname": "James",
        "lastname": "Brown",
        "totalprice": 111,
        "depositpaid": true,
        "bookingdates": { "checkin": "2018-01-01", "checkout": "2019-01-01" },
        "additionalneeds": "Breakfast"
      }
      """
    Given path 'booking'
    And request payload
    When method POST
    Then status 200
    * def bookingId = response.bookingid
    * print 'Booking creado con id:', bookingId

    # GET BY ID
    Given path 'booking', bookingId
    When method GET
    Then status 200
    And match response.firstname == payload.firstname
    And match response.lastname == payload.lastname

    # AUTH put/delete
    Given path 'auth'
    And request { username: 'admin', password: 'password123' }
    When method POST
    Then status 200
    * def token = response.token

    #  actualizar
    * def updated =
      """
      {
        "firstname": "James",
        "lastname": "Brown",
        "totalprice": 222,
        "depositpaid": false,
        "bookingdates": { "checkin": "2018-02-01", "checkout": "2019-02-01" },
        "additionalneeds": "Dinner"
      }
      """
    Given path 'booking', bookingId
    And header Cookie = 'token=' + token
    And request updated
    When method PUT
    Then status 200
    And match response.firstname == updated.firstname
    And match response.totalprice == updated.totalprice
    And match response.depositpaid == updated.depositpaid

    #  DELETE
    Given path 'booking', bookingId
    And header Cookie = 'token=' + token
    When method DELETE
    Then status 201


