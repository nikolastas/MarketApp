import pymongo


def get_database():
    CONNECTION_STRING = "mongodb+srv://nikolastas:nikolastas2019@marketapp.5vzy4.mongodb.net/MarketApp?retryWrites=true&w=majority"

    client = pymongo.MongoClient(CONNECTION_STRING)

    return client


client = get_database()
db = client.MarketApp

collection_name = db["users"]

users = [
    {
        "username": "nikolastas",
        "group": "ABCDEFGHIJ",
        "email": "n@google.com",
        "password": "$2a$10$zm1ZeAHK0a1ykBEGBjS/2OcOgKf9R7ADIvoj8kQirz5Ifpz.Sg/0O",
    },
    {
        "username": "natalie",
        "group": "ABCDEFGHIJ",
        "email": "natalygrigoriadi@gmail.com",
        "password": "$2a$10$7KeekJjbpOPt1v9JHxuEyOUpqNHawhcDuAlf4y5bBi3SvzBi5OeWi",
    },
    {
        "username": "argyro",
        "group": "ABCDEFGHIJ",
        "email": "aggeliarg@gmail.com ",
        "password": "$2a$10$JFG7sZQpcz4tV2APS4/F8.vjM2QYx2jKciXnTuG8/26XxtKacl8vK",
    },
    {
        "username": "nikolas",
        "group": "ABCDEFGHID",
        "email": "nikolas@google.com",
        "password": "$2a$10$y0f4pIZ1u2N63UhrXEmcXOHwLfjxE/QZ7v1OSukDaPOyOwGJoMRmS",
    },
]

for user in users:
    collection_name.insert_one(user)
