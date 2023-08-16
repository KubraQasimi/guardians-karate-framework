@Smoke
Feature: Token Verify

  Background: 
    * url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username" :"supervisor","password":"tek_supervisor"}
    When method post
    Then status 200
    And print response
#scenario 4
  Scenario: Verify a valid token
    Then path "/api/token/verify"
    And param username = "supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    Then assert response == "true"
#scenario 5
  Scenario: verify valid token invalid username
    Then path "/api/token/verify"
    And param username = "supervisorr"
    And param token = response.token
    When method get
    Then status 400
    And print response
    Then assert response.errorMessage == "Wrong Username send along with Token"

#scenario6#
  Scenario: Wrong token valid username
    Then path "/api/token/verify"
    And param token = "invalid"
    And param username = "supervisor"
    When method get
    Then status 400
    And print response
    Then assert response.errorMessage == "Token Expired or Invalid Token"

  #Scenario: get account
    #And path "/api/accounts/get-account"
    #And header Authorization = "Bearer " + response.token
    #And param primaryPersonId = "101"
    #When method get
    #Then status 200
    #And print response
  
