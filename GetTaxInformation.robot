*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary
*** Variables ***
${API_baseURL}       http://localhost:8080/calculator
${API_InsertSingleRecord}   /taxRelief


*** Test Cases ***
TC01_GetTaxInformation_ValidateSchema
    Create Session      API_Testing     ${API_baseURL}
    ${response}=    GET On Session  API_Testing   ${API_InsertSingleRecord}
    log to console      ${response.status_code}
    log to console      ${response.content}
    #Validations
    ${status_code}=     convert to string  ${response.status_code}
    should be equal     ${status_code}      200
    ${response}=   convert to string  ${response.content}
    should contain   ${response}     natid  name    relief

