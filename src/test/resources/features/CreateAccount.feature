@regression
Feature: Create account feature

  Background: setup test and generate token
    * def result = callonce read('generateToken.feature')
    * def validToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create valid account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    #Calling java class in feature file. this utility will create object from java class
    * def generateDataObject = Java.type('api.utility.data.generateData')
    * def autoEmail = generateDataObject.getEmail();
    And request
      """
      {
        "email": "#(autoEmail)",
        "firstName": "jack",
        "lastName": "ma",
        "title": "Ms.",
        "gender": "FEMALE",
        "maritalStatus": "MARRIED",
        "employmentStatus": "Student",
        "dateOfBirth": "2000-08-08T01:08:06.575Z"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
