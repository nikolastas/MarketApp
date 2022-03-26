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
| GET | / |  |
| GET | /health |
| POST | /login |
| POST | /signup |
| POST | /logout |
| POST | /change-password |
| GET | /checkUser |
| POST | /add |
| POST | /edit |
| POST | /delete |
| GET | /market-items |
| GET | /markets |
| 