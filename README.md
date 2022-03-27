# MarketApp
This is basicly an app to organize your shopping list for your grocesery items. <br/>

Basic app fetures:
- Every group or household has its own list. 
- Short lists based on the topological order of every store.
- Items can be edited, deleted or added by users.
- Supported store locations can be viewed in maps.
<br/>

# Backend
A node js API . 
<br/> 

## Authentication.
Basicly the response sents a cookie that the reciptent should save it localy. Every request after login or signup should have a cookie or a headers parameter as the request sent. 

<br/>

## Basic Requests

| Request type | Request API Call | Responde type |Authentication| Commends |
| --- | --- | --- | --- | ---| 
| GET | / |"welcome"  | NO| see if docker is working |
| GET | /health |{ "status":"ok" } |NO | check the health of the API 
| POST | /login | { "username": {username}, "email": {user_email}, "group":{group}, "token": {token}  } | NO | if login was succesful the system return this json object|
| POST | /signup | { "username": {username}, "email": {user_email}, "group":{group}, "token": {token}  } |NO | if signup is successful return this json object
| POST | /logout | " " | YES | succedes only if user is loged out
| POST | /change-password |
| GET | /checkUser |{"username" : {username} } | YES | returns the usernmae if user is logged in
| POST | /add | 
| POST | /edit |
| POST | /delete |
| GET | /market-items |
| GET | /markets |
| GET | /super-categories |
| GET | /shorted-list/:market |

