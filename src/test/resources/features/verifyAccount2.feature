@regression
Feature: verify account

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
		* def result = callonce read('generateToken.feature')
    And print result
    * def validToken = result.response.token
  # scenario 7
  Scenario: Verify an existing account
  	
    Given path "/api/accounts/get-account"
    * def existingId = 5323
    And param primaryPersonId = existingId
    And header Authorization = "Bearer " + validToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == existingId

#scenario 8
   Scenario: Verify get-account with inavalid id
    Given path "/api/accounts/get-account"
    # with def step can create variables and assign values for reusing
    * def notExistingId = 532332123
    And param primaryPersonId = notExistingId
    And header Authorization = "Bearer " + validToken
    When method get
    Then status 404
    And assert response.errorMessage == "Account with id " + notExistingId+" not found" 
    
    