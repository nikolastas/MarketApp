


const {MongoClient} = require('mongodb')

// connect to my database

const client = new MongoClient(process.env.DATABASE_URL);
function get_data_exept(body, list){
    
}


// the update method to handle an update post request
module.exports.update_post = async (req, res) => {
    const collection_name = req.body.collection_name;
    const id = req.body.id;
    var new_json_obj = {};
    let key;
    for (key in req.body) {
        if (req.body[key] != collection_name && req.body[key] != id) {
            new_json_obj[key] = isNaN(req.body[key]) ? req.body[key] : Number(req.body[key]);
        }
    }
    try {
        const client = new MongoClient(uri);
        await client.connect();
        const database = client.db('MarketApp')
        const collectionName = database.collection(collection_name);
        const filter = { "_id": id };
        const updateDoc = {
            $set: new_json_obj,
        };
        const options = { upsert: false };
        const result = await collectionName.updateOne(filter, updateDoc, options)
        await client.close();
        console.log(result);
        if (result.modifiedCount == 0) {
            res.status(500).send("object didnt exist to update!")
        }
        else {
            res.status(200).send("object updated successfully in database!");

        }

    } catch (e) {
        res.status(400).send(e.message);
    }
};