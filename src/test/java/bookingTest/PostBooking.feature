Feature: Crear un booking
  Background:
    * url 'https://restful-booker.herokuapp.com'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
  Scenario: Crear un booking exitosamente
    Given path 'booking'
    And request
      """
      {
        "firstname" : "Jim",
        "lastname" : "Brown",
        "totalprice" : 111,
        "depositpaid" : true,
        "bookingdates" : {
          "checkin" : "2018-01-01",
          "checkout" : "2019-01-01"
        },
        "additionalneeds" : "Breakfast"
      }
      """
    When method post
    Then status 200
    And assert responseTime < 600
    And match response.booking.firstname == "Jim"
    And match response.booking.lastname == "Brown"
    * def bookingId = response.bookingid
    * print 'Booking creado con id:', bookingId

