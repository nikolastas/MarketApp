const { application } = require('express');
const express = require('express');
const router = express.Router();
const jwt = require("jsonwebtoken");
const authController = require('../controllers/authController.js');
const {requireAuth } = require('../middleweare/authmiddlewear');
console.log("used auth routes");
router.post('/login', authController.login_post);
router.post('/logout', requireAuth, authController.logout_post);
router.post('/signup', authController.signup_post);
router.post('/change-password',  authController.change_password_post)

module.exports = router;