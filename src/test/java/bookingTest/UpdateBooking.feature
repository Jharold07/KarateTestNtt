Feature: Actualizar un booking en Restful-Booker

  Background:
    * url 'https://restful-booker.herokuapp.com'
    * configure headers = { Accept: 'application/json', Content-Type: 'application/json' }

  Scenario: Actualizar un booking existente con token válido
    # 1. Hacer login y guardar token
    Given path 'auth'
    And request { "username": "admin", "password": "password123" }
    When method post
    Then status 200
    * def token = response.token
    * print 'Token obtenido:', token

    # 2. Hacer el PUT usando el token en Cookie
    Given path 'booking', 916
    And header Cookie = 'token=' + token
    And request
      """
      {
        "firstname" : "James",
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
    When method put
    Then status 200
    And match response.firstname == "James"
    And match response.lastname == "Brown"