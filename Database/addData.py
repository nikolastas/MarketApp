
# from msilib.schema import Error
# from unittest import skip
import pymongo
def get_database():
    CONNECTION_STRING = "mongodb+srv://nikolastas:nikolastas2019@marketapp.5vzy4.mongodb.net/myFirstDatabase?retryWrites=true&w=majority"

    client = pymongo.MongoClient(CONNECTION_STRING)

    return(client)
client = get_database()
db = client.MarketApp

collection_name = db["MarketItems"]

class Item :
    def __init__(self, id, item_name, category, quantity) -> None:
        self.id = id
        self.item_name =item_name
        self.category = category
        self.quantity = quantity
items=[]
items.append (Item(0,"tomatoes", "fruits",1))
items.append (Item(1,"banannas", "fruits",2))
items.append (Item(2,"oranges", "fruits",3))
items.append (Item(3,"strawberries", "fruits",4))
items.append (Item(4,"chicken", "meat",5))
items.append (Item(5,"pork", "meat",6))
items.append (Item(6,"cleaning thing", "other",7))

# result = (collection_name.find({'_id':1}))
# for res in result:
#     print(res)
for item in items:
    tmp = collection_name.count_documents({'_id':item.id})
    if (tmp>=1):
        continue
    else:
        collection_name.insert_one({
        "_id":item.id,
        "item_name":item.item_name,
        "category":item.category,
        "quantity":item.quantity
        })
    
    