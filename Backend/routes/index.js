var express = require('express');
var router = express.Router();
const {MongoClient} = require('mongodb')
const basicController = require('../controllers/basicController');
const {requireAuth, checkUser } = require('../middleweare/authmiddlewear');
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
  router.get('/market-items', checkUser, basicController.market_items_get);
  router.get('/items-categories', requireAuth, basicController.items_categories_get);
  router.get('/super-items-categories', requireAuth, basicController.super_items_categories_get);
  router.post('/delete' ,checkUser,basicController.delete_post);
  router.post("/add", checkUser,basicController.add_post);
  router.post('/update', checkUser,basicController.update_post);
  router.get('/markets', requireAuth,basicController.markets_get);
  router.get('/items-shorted/:super_market', checkUser, basicController.shorted_items_get);





  module.exports = router;