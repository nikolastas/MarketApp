var express = require('express');
var router = express.Router();
const {MongoClient} = require('mongodb')

// const mongoose = require('mongoose');
// const Task = mongoose.model('Task');
const uri = process.env.DATABASE_URL;
const client = new MongoClient(uri);

router.get('/', (req,res)=>{
    res.status(200).send("welcome");
});

router.get('/get-:something', async (req,res)=> {
    var something = req.params.something;
    try{
      await client.connect();
      const database = client.db('MarketApp')
      const MarketItems = database.collection(something);
      // const query = { title: 'Back to the Future' };
      const cursor = await MarketItems.find({}).toArray();
      client.close();
      console.log("[200]: getting ", something);
      res.status(200).send(cursor)
    }
    catch(e){
      console.log(e);
      res.status(400).send({"status":"not ok"});
    }
  
  });
  router.post('/delete' , async (req,res) =>{
    const id = req.body.id;
    const collection_name = req.body.collection_name;
    console.log(id, collection_name);
    try{
      const client = new MongoClient(uri);
      await client.connect();
      const database = client.db('MarketApp')
      const collection = database.collection(collection_name);
      const result = await collection.deleteOne({"_id":id});

      await client.close();
      console.log(result);
      res.status(200).send("deleted from the database!"); 
    }catch(e){
      console.log("error",e);
      res.status(404).send(e.message, e.code);
    }
  });
  router.get('/health', (req,res) =>{
    res.status(200).send({
      "status":"OK"
    });

  });
  router.post("/add", async (req,res)=>{
    console.log(req.body);
    var collection_name = req.body.collection_name;
    try{
      const client = new MongoClient(uri);
      await client.connect();
      const database = client.db('MarketApp')
      const collectionName = database.collection(collection_name);
      var insertedValueString = "{";
      for(var key in req.body){
        if (req.body[key] != req.body.collection_name){
          var v1 = JSON.stringify(key);
          var v2 = JSON.stringify(req.body[key]);
          if(insertedValueString.replace(/[^:]/g, "").length>=1){
            insertedValueString+=","
          }
          insertedValueString+=(v1+":"+v2);
        }
      }
      insertedValueString+="}";
      // console.log(insertedValueString);
      const json_object_I_am_about_to_insert = JSON.parse(insertedValueString);
      const result = await collectionName.insertOne(json_object_I_am_about_to_insert);
      console.log(`A document was inserted with the _id: ${result.insertedId}`);
      await client.close();
      res.status(200).send("added to the database!"); 
    } catch(e){
      console.log("error",e);
      res.status(404).send(e.message, e.code);
    }
    
  });

  router.post('/update', async (req,res)=>{
    const collection_name = req.body.collection_name;
    const id = req.body.id;
    
    var new_json_obj = {};
    let key;
    for (key in req.body){
      if(req.body[key] != collection_name && req.body[key] != id){
        new_json_obj[key]=req.body[key];
      }
    }
    try{
      const client = new MongoClient(uri);
      await client.connect();
      const database = client.db('MarketApp')
      const collectionName = database.collection(collection_name);
      const filter = {"_id":id};
      const updateDoc = {
        $set: new_json_obj,
      };
      const options = {upsert:false};
      const result = await collectionName.updateOne(filter, updateDoc, options )
      await client.close();
      res.status(200).send(new_json_obj);

    } catch(e){
      res.status(400).send(e.message);
    }
  });






  module.exports = router;