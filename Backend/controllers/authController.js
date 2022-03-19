
const User = require("../models/User");
const jwt = require('jsonwebtoken');
const cookie = require('cookie-parser')
var bcrypt = require("bcryptjs");
const random = require('../models/secret');

//create token
const createToken = (id) =>{
    return jwt.sign({ id }, random.secret, { 
        // expiresIn: 60*60*7*24 // 7 days
    });
}

//handle errors
const handleErrors = (err) =>{
    var errors = [];
    if(err.original){
        if(err.original.errno==1062){
            console.log("user already exists in db");
            errors.push("User already exists");
        }
    }
    if(err.message){
        console.log(err.message, err.code);
        errors.push(err.message);
    }
    return errors;
    
}

module.exports.signup_post = async (req, res) =>{
    const userName = req.body.username;
    const passWord = req.body.password;
    const group = req.body.group;
    const Email = req.body.email;
    console.log("trying to create user");
    try {
        // object = {username, password, typeOfUser};
        // const errors = validate(object);
        const user = await User.create({
            username: userName,
            group: group,
            email: Email,
            password: passWord
        });
            
        const token = createToken(user.username);    
        console.log("[signup] token created" );
        res.cookie('jwt', token, { });
        res.status(200).send(
            {
                username: user.username,
                email: user.email,
                group: user.group,
                token: token
            }
        );
        console.log("user created + sent token");
        //do something when User is created
          
      }
      catch(err) {
        const errors = handleErrors(err);
        console.log(userName, Email, passWord, group);
        res.status(400).send({"failmsg": String(errors)});
      }
}
module.exports.login_post = async (req, res) =>{
    var userName = req.body.username;
    var pass = req.body.password;
    try{ 
        const user = await User.findOne({
            "username": userName
        });
        // console.log(user.username);
        if(!user){
            res.status(400).send({"failmsg": "Username not found"});
        }
        else{
            console.log("user found");
            const auth = bcrypt.compareSync(pass, user.password);
            console.log(pass, user.password);
            if(auth){
                const token = createToken(user.username );
                console.log("[login] token created" );
                res.cookie('jwt', token, {  });
                res.status(200).send({
                    username: user.username,
                    email: user.email,
                    group: user.group,
                    token: token
                });
                console.log("user loged in + sent token");
            }
            else{
                // const p = bcrypt.
                console.log( user.password);
                res.cookie('jwt', null);
                res.status(401).send({"failmsg": "Wrong Password"});
            }
        }

        
    }catch(err){
        
        console.log(err);
        res.status(500).send("Internal Server Error")
    }
    
    
}
module.exports.logout_post = (req, res) =>{
    res.cookie('jwt', null, { maxAge:1});
    console.log("user logout");
    res.send('logout');
}

module.exports.change_password_post = async (req, res) =>{
    var userName = req.body.username;
    var new_pass = req.body.password;

    try{
        const user_who_want_to_update_pass = await  User.findOne({ 
            where:{
                username: userName 
            } 
        });
        if (user_who_want_to_update_pass == null){
            res.status(400).send({"failmsg": "user with username "+ userName+ " doesnt exists in DB"});
        }
        else{
        console.log("[changing pass] user exist and found ! user:", user_who_want_to_update_pass.username);
        user_who_want_to_update_pass.password = new_pass;
        await user_who_want_to_update_pass.save();
        
        
        
        res.status(200).send("password updated");
        }
    }catch (err){
        console.log(err);
        res.status(400).status({"failmsg":"internal error while updating"})
    }
}