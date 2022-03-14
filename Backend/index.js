const http = require('http');
const { MongoClient } = require("mongodb");
const express = require('express');

// mongo db
const uri = "mongodb://nikolastas:aQI5IplodxBX3YF3aRAyhEwhjWaOGBaUzjPHnWRf3QjAh1aadTVT1bV0rKiW34Tf98zqBUO6j6D6y6wP2M4Gcw==@nikolastas.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@nikolastas@";
const client = new MongoClient(uri);

//connect to mongo
async function run() {
    try {
      // Connect the client to the server
      await client.connect();
      // Establish and verify connection
      await client.db("admin").command({ ping: 1 });
      console.log("Connected successfully to server");
    } finally {
      // Ensures that the client will close when you finish/error
      await client.close();
    }
}
run().catch(console.dir);

//express app
const app = express.Router();

//endpoints
app.get('/get-:something', async (req,res)=> {
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

})

//port and ip of backend
const port = 3000;
const ip = 'localhost';
app.listen(port, () => {
    console.log('listening for request on '+ip+":"+port);
})