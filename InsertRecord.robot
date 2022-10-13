*** Settings ***
Library     RequestsLibrary
Library     Collections
*** Variables ***
${API_baseURL}       http://localhost:8080/calculator
${API_InsertSingleRecord}   /insert


*** Test Cases ***
TC01_InsertRecord_ValidData
    Create Session      API_Testing     ${API_baseURL}
    ${payload}=     create dictionary  birthday=12041989    gender=M    name=Heroes  natid=Sounex    salary=50050    tax=468
    ${header}=      create dictionary  Content-Type=application/json
    ${response}=    POST REQUEST  API_Testing   ${API_InsertSingleRecord}   data=${payload}   headers=${header}
    log to console      ${response.status_code}
    log to console      ${response.content}
    #Validations
    ${status_code}=     convert to string  ${response.status_code}
    should be equal     ${status_code}      202
    ${response}=   convert to string  ${response.content}
    should be equal     ${response}     Alright

TC02_InsertRecord_InvalidBirthDate
    Create Session      API_Testing     ${API_baseURL}
    ${payload}=     create dictionary  birthday=12040000   gender=M    name=Heroes  natid=Sounex    salary=50050    tax=468
    ${header}=      create dictionary  Content-Type=application/json
    ${response}=    POST REQUEST  API_Testing   ${API_InsertSingleRecord}   data=${payload}   headers=${header}
    log to console      ${response.status_code}
    log to console      ${response.content}
    #Validations
    ${status_code}=     convert to string  ${response.status_code}
    should be equal     ${status_code}      500
    ${response}=   convert to string  ${response.content}
    should contain    ${response}     Internal Server Error

TC03_InsertRecord_NullValueforSalary
    Create Session      API_Testing     ${API_baseURL}
    ${payload}=     create dictionary  birthday=12041985   gender=M    name=Heroes  natid=Sounex    salary=    tax=468
    ${header}=      create dictionary  Content-Type=application/json
    ${response}=    POST REQUEST  API_Testing   ${API_InsertSingleRecord}   data=${payload}   headers=${header}
    log to console      ${response.status_code}
    log to console      ${response.content}
    #Validations
    ${status_code}=     convert to string  ${response.status_code}
    should be equal     ${status_code}      500
    ${response}=   convert to string  ${response.content}
    should contain    ${response}     Internal Server Error

TC04_InsertRecord_NegativeValueforSalary
    Create Session      API_Testing     ${API_baseURL}
    ${payload}=     create dictionary  birthday=12041985   gender=M    name=Heroes  natid=Sounex    salary=-5000    tax=50
    ${header}=      create dictionary  Content-Type=application/json
    ${response}=    POST REQUEST  API_Testing   ${API_InsertSingleRecord}   data=${payload}   headers=${header}
    log to console      ${response.status_code}
    log to console      ${response.content}
    #Validations
    ${status_code}=     convert to string  ${response.status_code}
    should be equal     ${status_code}      202
    ${response}=   convert to string  ${response.content}
    should contain    ${response}     Alright