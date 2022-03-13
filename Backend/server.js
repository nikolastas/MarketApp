const http = require('http');
const { MongoClient } = require("mongodb");
const express = require('express');

// mongo db
const uri = "mongodb+srv://nikolastas:nikolastas2019@marketapp.5vzy4.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
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
const app = express();

//endpoints
app.get('/get-items', async (req,res)=> {
  try{
    await client.connect();
    const database = client.db('MarketApp')
    const MarketItems = database.collection('MarketItems');
    // const query = { title: 'Back to the Future' };
    const cursor = await MarketItems.find({}).toArray();
    client.close();
    console.log(cursor);
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
app.listen(port, ip, () => {
    console.log('listening for request on '+ip+":"+port);
})