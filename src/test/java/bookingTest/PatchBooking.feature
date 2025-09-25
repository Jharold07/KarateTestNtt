Feature: Actualizar parcialmente un booking

  Background:
    * url 'https://restful-booker.herokuapp.com'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  # Primero obtener token y guardarlo
  Scenario: Login y actualizar parcialmente un booking
    Given path 'auth'
    And request
      """
      {
        "username" : "admin",
        "password" : "password123"
      }
      """
    When method post
    Then status 200
    * def token = response.token
    * print 'Token generado:', token

    # Ahora hacemos el PATCH con el token
    Given path 'booking', 1
    And header Cookie = 'token=' + token
    And request
      """
      {
        "firstname" : "James",
        "lastname" : "Brown"
      }
      """
    When method patch
    Then status 200
    And match response.firstname == "James"
    And match response.lastname == "Brown"
    * print 'Booking actualizado parcialmente:', response
