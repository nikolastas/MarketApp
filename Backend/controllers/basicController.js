


const {MongoClient} = require('mongodb')
const uri = process.env.DATABASE_URL;
const moment = require('moment');
// connect to my database

// const client = new MongoClient(process.env.DATABASE_URL);

// fucntion to connect to specific Database and collection
async function connect_to_DB_and_collection(client, db, collection_name){
    
    await client.connect();
    const database = client.db(db)
    return database.collection(collection_name);
}

// function to return all the data given by the user!
function get_data_exept(body, list){
    
    var new_json_obj = {};
    let key;
    for (key in body) {
        
        if (!(list.includes(body[key]))) {
          console.log(key, list);
          new_json_obj[key] = isNaN(body[key]) ? body[key] : Number(body[key]);
        }
    }
    new_json_obj["lastModified"] = moment(Date.now()).format('YYYY-MM-DD HH:mm:ss');
    return new_json_obj;
}


// the update method to handle an update post request
module.exports.update_post = async (req, res) => {
    let collection_name = req.body.collection_name;
    let id = Number(req.body.id);
    
    let new_json_obj = get_data_exept(req.body, [req.body.id, req.body.collection_name]);
    try {
        const client = new MongoClient(process.env.DATABASE_URL);
        const collection = await connect_to_DB_and_collection(client, 'MarketApp', collection_name);
        const filter = { "_id": id };
        const updateDoc = {
            $set: new_json_obj,
        };
        const options = { upsert: false };
        const result = await collection.updateOne(filter, updateDoc, options)
        await client.close();
        console.log(result);
        if (result.modifiedCount == 0) {
            res.status(500).send("object didnt chnage maybe it doesnt exist in db!");
        }
        else {
            res.status(200).send("object updated successfully in database!");

        }

    } catch (e) {
        console.log(e);
        res.status(400).send(e.message);
    }
};

module.exports.add_post = async (req,res)=>{
    console.log(req.body);
    let collection_name = req.body.collection_name;
    try{
      const client = new MongoClient(uri);
      const collectionName = await connect_to_DB_and_collection(client, 'MarketApp', collection_name);

      const json_object_I_am_about_to_insert = get_data_exept(req.body, [req.body.collection_name]);
      console.log(json_object_I_am_about_to_insert);
      const result = await collectionName.insertOne(json_object_I_am_about_to_insert);
      console.log(result);
      await client.close();
      if(result.modifiedCount == 0 ){
        res.status(500).send("object didnt added in db!")
      }
      else{
        console.log(`A document was inserted with the _id: ${result.insertedId}`);
      
        res.status(200).send("added to the database!"); 
      }
      
    } catch(e){
      console.log("error",e);
      res.status(400).send(e.message);
    }
    
  };

  module.exports.delete_post = async (req,res) =>{
    const id = Number(req.body.id);
    const collection_name = req.body.collection_name;
    console.log(id, collection_name);
    try{
      const client = new MongoClient(uri);
      
      const collection = await connect_to_DB_and_collection(client, 'MarketApp', collection_name);
      const result = await collection.deleteOne({"_id":id});

      await client.close();
      console.log(result);
      if(result.deletedCount > 0){
      res.status(200).send("deleted from the database!");
      }
      else{
        res.status(500).send("object didnt deleted from db!")
      } 
    }catch(e){
      console.log("error",e);
      res.status(404).send(e.message);
    }
  };

  module.exports.market_items_get = async (req,res)=> {
    let s = req.params.s;
    console.log(s);
    try{
        const client = new MongoClient(uri);
      
        const MarketItems = await connect_to_DB_and_collection(client, 'MarketApp', s)
        // const query = { title: 'Back to the Future' };
        const cursor = await MarketItems.find({}).toArray();
        await client.close();
        console.log(`[200]: getting all ${s}`);
        res.status(200).send(cursor)
    }
    catch(e){
        console.log(e);
        res.status(400).send({"status":"not ok"});
    }
  
  };