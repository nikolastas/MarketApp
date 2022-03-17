var express = require('express');
var router = express.Router();
const {MongoClient} = require('mongodb')
const basicController = require('../controllers/basicController')
// const mongoose = require('mongoose');
// const Task = mongoose.model('Task');
const uri = process.env.DATABASE_URL;
// const client = new MongoClient(uri);

router.get('/', (req,res)=>{
    res.status(200).send("welcome");
});
router.get('/health', (req,res) =>{
  res.status(200).send({
    "status":"OK"
  });
});
  router.get('/get-:s', basicController.market_items_get);
  router.post('/delete' , basicController.delete_post);
  router.post("/add", basicController.add_post);
  router.post('/update', basicController.update_post);






  module.exports = router;