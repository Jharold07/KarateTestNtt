Feature: Obtener booking por Id

    Background:
    * url 'https://restful-booker.herokuapp.com'
    * header Accept = 'application/json'

  Scenario: Obtener booking con id
    Given path 'booking', 916
    When method get
    Then status 200
    And match response.firstname == "Bryam"
    And match response.lastname == "Meza"
    * print 'Booking obtenido:', response
