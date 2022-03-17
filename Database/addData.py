
# from msilib.schema import Error
# from unittest import skip
from datetime import datetime, date
import pymongo
def get_database():
    CONNECTION_STRING = "mongodb://nikolastas:aQI5IplodxBX3YF3aRAyhEwhjWaOGBaUzjPHnWRf3QjAh1aadTVT1bV0rKiW34Tf98zqBUO6j6D6y6wP2M4Gcw==@nikolastas.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@nikolastas@"

    client = pymongo.MongoClient(CONNECTION_STRING)

    return(client)
client = get_database()
db = client.MarketApp

collection_name = db["MarketItems"]
cat = db ["ItemCategories"]
class Item :
    def __init__(self,item_name, category, quantity) -> None:
        # self.id = id
        self.item_name =item_name
        self.category = category
        self.quantity = quantity
items=[]
# size = 1
items.append (Item("τοματες", "λαχανικά",1))
items.append (Item("δημητρικά cheerios", "δημητριακα",1))
items.append (Item("ψωμί", "φριγανίες",1))
items.append (Item("φραουλες", "φρουτα",1))
items.append (Item("λογαδι τυρι τοστ", "τυριά",1))
items.append (Item("γαλοπουλα", "αλαντικά",1))
items.append (Item("πατατάκια", "Σνακς",1))
items.append (Item("Βεργίνα βαις", "μπυρες",1))
items.append (Item("Οδοντοκρεμα", "Στοματική Υγιεινή",1))
items.append (Item("Κλινεξ", "Καθαριότητα Σπιτιού",1))
items.append (Item("Δωδώνη Γιαούρτι 2%", "Γιαούρτια",1))

categories = []
c=1
for item in items :
    if item.category not in categories:
        
        categories.append({"_id":c,"name":item.category})
        c+=1
# result = (collection_name.find({'_id':1}))
# for res in result:
#     print(res)
try:
    collection_name.delete_many({})
    cat.delete_many({})
except:
    print("no collection delete needed")
size = 1
for item in items:
    tmp = collection_name.count_documents({'_id':size})
    if (tmp>=1):
        continue
    else:
        collection_name.insert_one({
        "_id":size,
        "item_name":item.item_name,
        "category":item.category,
        "quantity":item.quantity,
        "lastModified": date.today().strftime("%d/%m/%Y %H:%M:%S")
        })
        size+=1
    
cat.insert_many(categories)