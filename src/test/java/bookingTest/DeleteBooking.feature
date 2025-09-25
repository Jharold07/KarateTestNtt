Feature: Eliminar un booking

  Background:
    * url 'https://restful-booker.herokuapp.com'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario: Login y eliminar un booking
    # 1. Obtener token
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

    # 2. Eliminar booking con id=1 (ejemplo)
    Given path 'booking', 916
    And header Cookie = 'token=' + token
    When method delete
    Then status 201
    * print 'Booking eliminado exitosamente'
