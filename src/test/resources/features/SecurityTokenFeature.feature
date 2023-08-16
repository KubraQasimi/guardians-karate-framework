@Smoke
Feature: Security Token Test

  Background: 
    * url "https://tek-insurance-api.azurewebsites.net"
    * path "/api/token"

  Scenario: Generate valid token with valid username and password
    #Prepare request
    And request {"username" : "supervisor" , "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response

  Scenario Outline: Validate token with invalid username and password
    And request
      """
      {"username" : "<username>",
      "password":"<password>"
      }
      """
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "<errorMessage>"

    Examples: 
      | username   | password       | errorMessage         |
      | wrong      | tek_supervisor | User not found       |
      | supervisor | wrong          | Password Not Matched |

  Scenario: 
    And request {"username" :"supervisor","password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
    And path "/api/token/verify"
    And param token = response.token
    And param username = "supervisor"
    When method get
    Then status 200
    And print response
    And assert response == "true"
