#	 Account should exist to delete. 200 status code
# make sure account acccount is not existing to get 404 status code
@regression
Feature: Delete account Functionality

  Background: Test Setup and create new account
    * def createAccountRes = callonce read('CreateAccount.feature')
    * def validToken = createAccountRes.validToken
    * def createAccountId = createAccountRes.response.id
    And print createAccountRes
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Delete account
    Given path "/api/accounts/delete-account"    
    And param primaryPersonId = createAccountId     
    And header Authorization = "Bearer " + validToken    
    When method delete    
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
    Given path "/api/accounts/delete-account"
    And param primaryPersonId = createAccountId
    And header Authorization = "Bearer " + validToken
    When method delete
    Then status 404
    And assert response.errorMessage == "Account with id " + createAccountId + " not exist"
