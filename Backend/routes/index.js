var express = require('express');
var router = express.Router();
const {MongoClient} = require('mongodb')

const mongoose = require('mongoose');
const Task = mongoose.model('Task');
const uri = "process.env.DATABASE_URL";
const client = new MongoClient(uri);

router.get('/', (req,res)=>{
    res.status(200).send("working fine");
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
  module.exports = router;