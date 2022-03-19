


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
          // console.log(key, list);
          new_json_obj[key] = isNaN(body[key]) ? body[key] : Number(body[key]);
        }
    }
    new_json_obj["lastModified"] = moment(Date.now()).format('YYYY-MM-DD HH:mm:ss');
    return new_json_obj;
}


// the update method to handle an update post request
module.exports.update_post = async (req, res) => {
   
    let id = (req.body.item_index);
    const group =req.app.locals.user.group ;

    let new_json_obj = get_data_exept(req.body, [req.body.item_index]);
    try {
        const client = new MongoClient(process.env.DATABASE_URL);
        const collection = await connect_to_DB_and_collection(client, 'MarketApp', 'MarketItems');
        var cursor = await collection.findOne({"group":group});
        var items = cursor.items;
        if(items[id]){
          for (key in new_json_obj){
            items[id][key]=new_json_obj[key];
          }

          const filter = { "group": group };
          const updateDoc = {
            $set: {
              "items": items
            },
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
        } else{
          res.status(500).send("item index is invalid to update");
        }
    } catch (e) {
        console.log(e);
        res.status(400).send(e.message);
    }
};

module.exports.add_post = async (req,res)=>{
    // console.log(req.body);

    const group =req.app.locals.user.group ;
    try{
      const client = new MongoClient(uri);
      const collectionName = await connect_to_DB_and_collection(client, 'MarketApp', 'MarketItems');

      const json_object_I_am_about_to_insert = get_data_exept(req.body, []);
      // console.log(json_object_I_am_about_to_insert);
      var cursor = await collectionName.findOne({"group":group});
      var items = cursor.items;
      
      const items_length = Object.keys(items).length +1;
      // items ={};
      items[`${items_length}`]=json_object_I_am_about_to_insert;
      
      // console.log(items);

      const filter = { "group": group };
      // this option instructs the method to create a document if no documents match the filter
      const options = { upsert: false };
      // create a document that sets the plot of the movie
      const updateDoc = {
        $set: {
          "items": items
        },
      };
      const result = await collectionName.updateOne(filter, updateDoc, options);
      await client.close();

      if(result.modifiedCount == 0 ){
        res.status(500).send("object didnt added in db!")
      }
      else{
        // console.log(`A document was inserted with the _id: ${result.insertedId}`);
      
        res.status(200).send("added to the database!"); 
      }
      
    } catch(e){
      console.log("error",e);
      res.status(400).send(e.message);
    }
    
  };

  module.exports.delete_post = async (req,res) =>{
    const id = (req.body.item_index);
    const group =req.app.locals.user.group ;
    // console.log(id, group);
    try{
      const client = new MongoClient(uri);
      
      const collection = await connect_to_DB_and_collection(client, 'MarketApp', 'MarketItems');
      var cursor = await collection.findOne({"group":group});
      var items = cursor.items;
      if(items[id]){
        const tmp = delete items[id];
        console.log(tmp);

        const filter = { "group": group };
        // this option instructs the method to create a document if no documents match the filter
        const options = { upsert: false };
        // create a document that sets the plot of the movie
        const updateDoc = {
          $set: {
            "items": items
          },
        };
        const result = await collection.updateOne(filter, updateDoc, options);
        

        await client.close();
        // console.log(result);
        if(result.modifiedCount > 0){
        res.status(200).send("deleted from the database!");
        }
        else{
          res.status(500).send("object didnt deleted from db!")
        }
      }
      else{
        res.status(500).send("object didnt exist to delete");
      } 
    }catch(e){
      console.log("error",e);
      res.status(404).send(e.message);
    }
  };

  module.exports.market_items_get = async (req,res)=> {
    
    
    const group =req.app.locals.user.group ;
    console.log(group);
    // console.log(s);
    try{
        const client = new MongoClient(uri);
      
        const MarketItems = await connect_to_DB_and_collection(client, 'MarketApp', 'MarketItems')
        const options = {
          sort:{"_id": 1}
        }
        // const query = { title: 'Back to the Future' };
        const cursor = await MarketItems.findOne({"group":group}, options);
        await client.close();
        console.log(`[200]: getting all Market Items for group: ${group}`);
        
        res.status(200).send(cursor.items)
    }
    catch(e){
        console.log(e);
        res.status(400).send({"status":"not ok"});
    }
  
  };

  module.exports.items_categories_get = async (req,res)=> {
    
    
    
    // console.log(s);
    try{
        const client = new MongoClient(uri);
      
        const ItemCategories = await connect_to_DB_and_collection(client, 'MarketApp', 'ItemCategories')
        const options = {
          
        }
        // const query = { title: 'Back to the Future' };
        const cursor = await ItemCategories.findOne({"object":"items_list"}, options);
        await client.close();
        console.log(`[200]: getting all categories`);
        // console.log(cursor);
        res.status(200).send(cursor.value)
    }
    catch(e){
        console.log(e);
        res.status(400).send({"status":"not ok"});
    }
  
  };


  module.exports.super_items_categories_get = async (req,res)=> {
    
    
    
    // console.log(s);
    try{
        const client = new MongoClient(uri);
      
        const SuperItemCategories = await connect_to_DB_and_collection(client, 'MarketApp', 'ItemCategories')
        const options = {
          
        }
        // const query = { title: 'Back to the Future' };
        const cursor = await SuperItemCategories.findOne({"object":"SuperCategories"}, options);
        await client.close();
        console.log(`[200]: getting all super-categories`);
        // console.log(cursor);
        res.status(200).send(cursor.value)
    }
    catch(e){
        console.log(e);
        res.status(400).send({"status":"not ok"});
    }
  
  };