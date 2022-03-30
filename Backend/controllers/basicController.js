


const { MongoClient } = require('mongodb')
const uri = process.env.DATABASE_URL;
const moment = require('moment');
const { json } = require('express');
// connect to my database

// const client = new MongoClient(process.env.DATABASE_URL);

// fucntion to connect to specific Database and collection
async function connect_to_DB_and_collection(client, db, collection_name) {

  await client.connect();
  const database = client.db(db)
  return database.collection(collection_name);
}

// function to return all the data given by the user!
function get_data_exept(body, list) {

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

function check(list, object) {
  index = 0;
  for (item of list) {
    console.log(item)
    if (item["_id"] == object["_id"]) {
      return index;
    }
    index++;
  }
  return;
}
// the update method to handle an update post request
module.exports.update_post = async (req, res) => {

  let name = (req.body.item_name);
  let id = req.body.id;
  const group = req.app.locals.user.group;

  let new_json_obj = get_data_exept(req.body, [req.body.item_index]);
  try {
    const client = new MongoClient(process.env.DATABASE_URL);
    const collection = await connect_to_DB_and_collection(client, 'MarketApp', 'MarketItems');
    var cursor = await collection.findOne({ "group": group });
    var items = cursor.items;
    const check_index = check(items, new_json_obj);
    if (check_index != null) {

      for (key in new_json_obj) {
        items[check_index][key] = new_json_obj[key];
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
    } else {
      res.status(500).send("item index is invalid to update");
    }
  } catch (e) {
    console.log(e);
    res.status(400).send(e.message);
  }
};

module.exports.add_post = async (req, res) => {
  // console.log(req.body);

  const group = req.app.locals.user.group;
  console.log(group);
  try {
    const client = new MongoClient(uri);
    const collectionName = await connect_to_DB_and_collection(client, 'MarketApp', 'MarketItems');

    const json_object_I_am_about_to_insert = get_data_exept(req.body, []);

    if (!(json_object_I_am_about_to_insert["quantity"]) || !(json_object_I_am_about_to_insert["item_name"]) || !(json_object_I_am_about_to_insert["category"])) {
      throw new Error("NOT VALID ITEM ");
    }
    // console.log(json_object_I_am_about_to_insert);
    var cursor = await collectionName.findOne({ "group": group });
    console.log(cursor);
    var items = []
    if (cursor != null) {
      items = cursor.items;
      for (item of items) {
        if (item["item_name"] == json_object_I_am_about_to_insert["item_name"]) {
          throw new Error("DUPLICATE ENTRY , DENNIED");
        }
      }

      const items_length = items.length + 1;
      // items ={};
      json_object_I_am_about_to_insert["_id"] = items_length;
      items.push(json_object_I_am_about_to_insert);
    }
    else {
      items.push(json_object_I_am_about_to_insert);
    }

    // console.log(items);

    const filter = { "group": group };
    // this option instructs the method to create a document if no documents match the filter
    const options = { upsert: true };
    // create a document that sets the plot of the movie
    const updateDoc = {
      $set: {
        "items": items
      },
    };
    const result = await collectionName.updateOne(filter, updateDoc, options);
    await client.close();
    console.log(result);
    if (result.modifiedCount == 0 && result.upsertedCount == 0) {
      res.status(500).send(" object didnt added in db!")
    }
    else if (result.upsertedCount >= 1) {
      res.status(200).send("added to the database!");
    }
    else {
      // console.log(`A document was inserted with the _id: ${result.insertedId}`);

      res.status(200).send("updated items to the database!");
    }

  } catch (e) {
    console.log("error", e);
    res.status(400).send(e.message);
  }

};

module.exports.delete_post = async (req, res) => {
  const name = (req.body.item_name);
  const group = req.app.locals.user.group;
  // console.log(id, group);
  try {
    const client = new MongoClient(uri);

    const collection = await connect_to_DB_and_collection(client, 'MarketApp', 'MarketItems');
    var cursor = await collection.findOne({ "group": group });
    var items = cursor.items;
    var check_index = check(items, req.body)
    if (check_index != null) {

      for (var i = 0; i < items.length; i++) {

        if (i == check_index) {

          items.splice(i, 1);
        }

      }
      // console.log(tmp, check_index);
      console.log(items);
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
      if (result.modifiedCount > 0) {
        res.status(200).send("deleted from the database!");
      }
      else {
        res.status(500).send("object didnt deleted from db!")
      }
    }
    else {
      res.status(500).send("object didnt exist to delete");
    }
  } catch (e) {
    console.log("error", e);
    res.status(404).send(e.message);
  }
};

module.exports.market_items_get = async (req, res) => {


  const group = req.app.locals.user.group;
  console.log(group);
  // console.log(s);
  try {
    const client = new MongoClient(uri);

    const MarketItems = await connect_to_DB_and_collection(client, 'MarketApp', 'MarketItems')
    const options = {
      sort: { "_id": 1 }
    }
    // const query = { title: 'Back to the Future' };
    const cursor = await MarketItems.findOne({ "group": group }, options);
    await client.close();
    console.log(`[200]: getting all Market Items for group: ${group}`);

    res.status(200).send(cursor.items)
  }
  catch (e) {
    console.log(e);
    res.status(400).send({ "status": "not ok" });
  }

};

module.exports.items_categories_get = async (req, res) => {



  // console.log(s);
  try {
    const client = new MongoClient(uri);

    const ItemCategories = await connect_to_DB_and_collection(client, 'MarketApp', 'ItemCategories')
    const options = {

    }
    // const query = { title: 'Back to the Future' };
    const cursor = await ItemCategories.findOne({ "object": "items_list" }, options);
    await client.close();
    console.log(`[200]: getting all categories`);
    // console.log(cursor);
    res.status(200).send(cursor.value)
  }
  catch (e) {
    console.log(e);
    res.status(400).send({ "status": "not ok" });
  }

};


module.exports.super_items_categories_get = async (req, res) => {



  // console.log(s);
  try {
    const client = new MongoClient(uri);

    const SuperItemCategories = await connect_to_DB_and_collection(client, 'MarketApp', 'ItemCategories')
    const options = {

    }
    // const query = { title: 'Back to the Future' };
    const cursor = await SuperItemCategories.findOne({ "object": "SuperCategories" }, options);
    await client.close();
    console.log(`[200]: getting all super-categories`);
    // console.log(cursor);
    res.status(200).send(cursor.value)
  }
  catch (e) {
    console.log(e);
    res.status(400).send({ "status": "not ok" });
  }

};

module.exports.markets_get = async (req, res) => {



  // console.log(s);
  try {
    const client = new MongoClient(uri);

    const ItemCategories = await connect_to_DB_and_collection(client, 'MarketApp', 'ItemCategories')
    const options = {

      projection: { _id: 0, "super_market_name": 1, "address": 1 },
    }
    // const query = { title: 'Back to the Future' };
    const cursor = await ItemCategories.find({ "object": "super_markets" }, options).toArray();

    await client.close();


    res.status(200).send(cursor);
  }
  catch (e) {
    console.log(e);
    res.status(400).send({ "status": "not ok" });
  }

};
module.exports.shorted_items_get = async (req, res) => {

  const super_market = req.params.super_market;
  const group = req.app.locals.user.group;

  try {
    const client = new MongoClient(uri);

    const ItemCategories = await connect_to_DB_and_collection(client, 'MarketApp', 'ItemCategories');
    const MarketItems = await connect_to_DB_and_collection(client, 'MarketApp', 'MarketItems');
    const options = {

      projection: { "_id": 0, "shorted_items_list": 1 },
    }
    // const query = { title: 'Back to the Future' };
    const cursor = await ItemCategories.findOne({ "object": "super_markets", "super_market_name": super_market }, options);
    const shorted_categori_list = cursor["shorted_items_list"];
    const pre_items = await MarketItems.findOne({ "group": group });
    const items = pre_items["items"];
    correct_list = (cursor["shorted_items_list"])
    output = []
    // organize base on category
    category_list = {}
    for (item of items) {
      // console.log(item)
      if (category_list.hasOwnProperty(item["category"])) {
        category_list[item["category"]].push(item);
      }
      else {

        category_list[item["category"]] = [item];
      }
    }
    // output based on shorted categories
    output = []
    for (correct_category of correct_list) {
      if (category_list[correct_category]) {
        output.push(category_list[correct_category])
      }
    }
    res.status(200).send(output);
  }
  catch (e) {
    console.log(e);
    res.status(400).send({ "status": "not ok" });
  }

};
