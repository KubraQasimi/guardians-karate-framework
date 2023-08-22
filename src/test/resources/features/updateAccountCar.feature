@Smoke
Feature: 

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccount.feature')
    * def validToken = createAccountResult.validToken
    * def generateAccountId = createAccountResult.response.id
    And print createAccountResult

  Scenario: Update Existing car info from add account
    Given path "api/accounts/add-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = generateAccountId
    And request
      """
      {
      "make": "Toyota",
      "model": "camry",
      "year": "2023",
      "licensePlate": "abc 123"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.licensePlate == "abc 123"
    * def caId = response.id
    And path "/api/accounts/update-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = generateAccountId
    And request
      """
      {
        "id": "#(carId)",
        "make": "Ford",
        "model": "Mustang",
        "year": "2022",
        "licensePlate": "abd 234"
      }
      """
    When method put
    Then status 202
    And print response
