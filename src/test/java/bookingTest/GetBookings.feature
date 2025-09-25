Feature: Obetener todas las reservas

  Scenario: Obtener todas las reservas activas
    Given url 'https://restful-booker.herokuapp.com/booking'
    When method get
    Then status 200