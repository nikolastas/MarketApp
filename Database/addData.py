
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
supercat =db["SuperItemCategories"]
class Item :
    def __init__(self,item_name, category, quantity) -> None:
        # self.id = id
        self.item_name =item_name
        self.category = category
        self.quantity = quantity
items=[]
# size = 1
items.append (Item("τοματες", "Φρέσκα Φρούτα & Λαχανικά",1))
items.append (Item("δημητρικά cheerios", "Δμητριακά & Ψωμί",1))
items.append (Item("ψωμί", "Δημητριακά & Ψωμί",1))
items.append (Item("φραουλες", "Φρέσκα Φρούτα & Λαχανικά",1))
items.append (Item("λογαδι τυρι τοστ", "Τυριά",1))
items.append (Item("γαλοπουλα", "Αλλαντικά, Κρέας κά",1))
items.append (Item("πατατάκια", "Μπύρες, Ποτά & Νερά",1))
items.append (Item("Βεργίνα βαις", "Μπύρες, Ποτά & Νερά",1))
items.append (Item("Οδοντοκρεμα", "Στοματική Υγιεινή",1))
items.append (Item("Κλινεξ", "Καθαριότητα Σπιτιού",1))
items.append (Item("Δωδώνη Γιαούρτι 2%", "Γιαούρτια & Επιδόρπια",1))

categories = categories = [["Δημητριακά","Φρυγανίες", "Ζαχαρί", "Ρύζια","Αλευρια & Ειδη Ζαχαροπλαστικής","Ψωμί", "Ζυμαρικά" ,"Όσπρια", "Παντοπολείο", "Αλλαντικά", "Κρέας κά", "Προιόντα Ζύμης", "Κατεψυγμένα Λαχανικά", "Φρέσκα Φρούτα & Λαχανικά", "Ψάρια & Θαλάσσινά"], 
["Γάλα", "Γιαούρτια & Επιδόρπια", "Κρέμες γάλακτος & Βούτυρα", "Παγωτά", "Τυριά", "Αλλα είδη Γάλακτος"], 
["Μπύρες", "Κρασιά","Ποτά" , "Νερά", "Φρεσκοι χυμοί" ,"Χυμοί εκτος ψυγείου & Αναψυκτικά","Μπισκότα", "Ξηροί καρποί","Σοκολάτες", "Αλλα Σνακς", "Καφές & Ροφήματα"],
["Γυναικεία Περιποίηση", "Ανδρική περιποίηση", "Καθαριότητα & Προσωπική Υγειίνή", "Απορρυπαντικά","Περιποίηση Μαλλιών", "Στοματική Υγιεινή", "Ένδυση & Υπόδηση","Προιόντα Περιποιήσης"], 
["Κουζίνα & Μπάνιο","Καθαριστικά Σπιτιού", "Ρούχα", "Εξοπλισμός Σπιτιού"], 
["Βρεφική περιποίηση", "Βρεφικές κρέμες", "Πάνες & Μωρομάντηλα", "Βρεφικά Απορρυπαντικά", "Αξεσουάρ για το μωρό"], 
["Προϊόντα για κατοικίδια", "Βιολογικά Προϊόντα","Άλλα προιόντα"]]
c=1
supercategories = ["Τροφιμα", "Γαλακτοκομικά & Τυριά", "Χυμοί, Κάβα & Σνακς","Προσωπική φροντίδα", "Οικιακή φροντίδα", "Βρεφικά Είδη", "Διάφορα"]

# result = (collection_name.find({'_id':1}))
# for res in result:
#     print(res)
try:
    # collection_name.delete_many({})
    cat.delete_many({})
    # supercat.delete_many({})
except:
    print("no collection delete needed")
size = 1
items_dict = {}
for item in items:
    # tmp = collection_name.count_documents({'_id':size})
    # if (tmp>=1):
        # continue
    # else:
    items_dict[f'{size}']={
    # "_id":size,
    "item_name":item.item_name,
    "category":item.category,
    "quantity":item.quantity,
    "lastModified": datetime.today().strftime("%Y-%m-%d %H:%M:%S")
    }
    size+=1
input={}
input["group"]="ABCDEFGHIJ"
input["items"]=items_dict
# collection_name.insert_one(input)
a =1 
b=1
# list_of_supercat = []
list_of_cat = []

 
# print(items_dict)
input2={}
input2["object"]="SuperCategories"
input2["value"]=supercategories
cat.insert_one(input2)

for ca,sc in zip(categories,supercategories):
    # list_of_supercat.append({"_id":a, "name":sc})
    # a+=1
    for t in ca :
        list_of_cat.append({"name":t, "super_category":sc})
        # b+=1   
# cat.insert_many(list_of_cat)
# supercat.insert_many(list_of_supercat)

correct_list = ["Ψωμί","Φρέσκα Φρούτα & Λαχανικά", "Ψάρια & Θαλάσσινά","Δημητριακά","Φρεσκοι χυμοί", "Γάλα", 
"Γιαούρτια & Επιδόρπια", "Κρέμες γάλακτος & Βούτυρα", "Καφές & Ροφήματα", "Μπισκότα", "Σοκολάτες",    
"Ξηροί καρποί", "Κρέας κά", "Τυριά", "Αλλαντικά", "Κρασιά" , "Μπύρες", "Αλλα Σνακς", "Φρυγανίες", "Ζαχαρί" , "Αλλα είδη Γάλακτος", "Αλευρια & Ειδη Ζαχαροπλαστικής"
"Ρύζια", "Όσπρια", "Ζυμαρικά" , "Παντοπολείο","Ποτά" ,"Νερά", "Χυμοί εκτος ψυγείου & Αναψυκτικά","Προιόντα Ζύμης", "Κατεψυγμένα Λαχανικά","Παγωτά",  
"Κουζίνα & Μπάνιο","Καθαριστικά Σπιτιού", "Προϊόντα για κατοικίδια", "Απορρυπαντικά", "Βρεφικά Απορρυπαντικά", "Βιολογικά Προϊόντα", "Ρούχα", "Εξοπλισμός Σπιτιού", 
"Γυναικεία Περιποίηση", "Ανδρική περιποίηση", "Καθαριότητα & Προσωπική Υγειίνή", "Περιποίηση Μαλλιών", "Στοματική Υγιεινή", "Ένδυση & Υπόδηση","Προιόντα Περιποιήσης", 
"Βρεφική περιποίηση", "Βρεφικές κρέμες", "Πάνες & Μωρομάντηλα", "Αξεσουάρ για το μωρό",  "Άλλα προιόντα"]
 
input3={}
# input3["super_market_name"]="ab"
# input3["correct_list"]=correct_list
# input3["address"]="Βουλιαγμένης 43-45, 16561 Γλυφάδα"
input3["object"]="super_markets"
input3["value"]={
    "name":"ab",
    "items_list":correct_list,
    "address":"Βουλιαγμένης 43-45, 16561 Γλυφάδα",

}
cat.insert_one(input3)

cat.insert_one({
    "object":"items_list",
    "value":list_of_cat
})
