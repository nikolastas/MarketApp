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
Requests use the x-www-form-urlencode body form.


### Signup 

### Login

### Logout

<br/>

## Basic Requests

| Request type | Request API Call | Expencted Response |Authentication| Commends |
| --- | --- | --- | --- | ---| 
| GET | / |"welcome"  | NO| see if docker is working |
| GET | /health |{ "status":"ok" } |NO | check the health of the API 
| POST | /login | { "username": {username}, "email": {user_email}, "group":{group}, "token": {token}  } | NO | if login was succesful the system return this json object also sets up a token given from backend in the cookies senction|
| POST | /signup | { "username": {username}, "email": {user_email}, "group":{group}, "token": {token}  } |NO | if signup is successful return this json object also sets up a token given from backend in the cookies senction (automatic login)
| POST | /logout | " user logout" | YES | succedes only if user is loged out
| POST | /change-password | "password updated" | ??(under construction) | ?? (under construction) |
| GET | /checkUser |{"username" : {username} } | YES | returns the usernmae if user is logged in
| POST | /add | "added to database!" | YES | Items are inserted based on the item id , currently items may have duplicate names (not suggested).
| POST | /edit | "object updated successfully in database!" | YES | Items are also updated based their id . Item name , category and quantity can be changed.
| POST | /delete | "deleted from the database" | YES | items are deleted based on the their id
| GET | /market-items |  A list of json items like : { "item_name": "cheerios", "category": {item category}, "quantity": {item quantity}, "lastModified": {item last modified}, "_id": {item_id} }| YES | Authentication here is a must since the authentication is used to get the group of the user.
| GET | /markets | A list of json objects : {"super_market_name": {super_market_name}, "address": {super_market_address}} | YES | Get the markets address and name |
| GET | /super-categories | A list of the large categories that we use to  shot the item categories. | YES | |
| GET | /items-shorted/:market | A lists of lists . The items returned shorted based on the topological order which is on the database. | YES | This is basicly  the heart of my API. 




# Frontend - App
This is an app to give my backend a form . 


<p><Strong><bold> This readme will be updated often. I will try to solve every issue.  <bold/><Strong/> <p/>