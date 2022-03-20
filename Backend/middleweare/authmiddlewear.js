const jwt =require('jsonwebtoken');
const random = require('../models/secret');
const Mongoose = require('mongoose');
const e = require('express');


const User = require("../models/User");

const requireAuth = (req, res, next) =>{
    const token = req.cookies.jwt;
    
    // check if jwt exists and if is verified
    // console.log("cookies: ",req.cookies);
    if(token){
        jwt.verify(token, random.secret, (err, decodedToken)=>{
            if(err){
                res.status(400).send('err occured while verifing cookie')
                console.log(err.message);
            }
            else{
                // console.log(decodedToken);
                next();
            }
        });
    }
    else{
        res.status(400).send('[error] user is not log in');
    }
}
//  check if a user's jwt is valid and user exists
const checkUser = (req,res, next) =>{
    const token =  req.cookies.jwt;
    if(token){
        console.log("token exists");
        jwt.verify(token, random.secret, async (err, decodedToken)=>{
            if(err){
                console.log("token is not valid");
                console.log(err.message);
                req.app.locals.user = null;
                // res.locals.user = null;
                next(); // user not logged in
            }
            else{
                // console.log(decodedToken);
                console.log("token is valid");

                 await User.findOne({
                        "username": decodedToken.id
                }).then(user => {
                    console.log("found user");
                    console.log(user.username);
                    req.app.locals.user = user;
                    res.locals.user = user.username;
                }).catch(err => {
                    console.log(err);
                });
                next();
            }
        });
    }
    else{
        req.app.locals.user = null;
        // res.locals.user = null;
        
        console.log("user toke doesnt exists");
        next();
    }

}
// check if a user is admin
// const isAdmin = (req,res, next) =>{
//     const token =  req.cookies.jwt;
//     if(token){
//         console.log("token exists");
//         jwt.verify(token, random.secret, async (err, decodedToken)=>{
//             if(err){
//                 console.log("token is not valid");
//                 console.log(err.message);
//                 res.status(400).send("err while authenticating cookie ")
                
//             }
//             else{
//                 console.log(decodedToken);
//                 console.log("token is valid");

//                  await User.findOne({
//                     where:{
//                         username: decodedToken.id,
                        
//                     }
//                 }).then(user => {
//                     console.log("found user: checking if is admin ...");
//                     if(user.typeofuser == 'admin'){
//                         console.log("found admin: ",user.username);
//                         next();
//                     }
//                     else{
//                         console.log("user found but he is not admin");
//                         res.status(401).send("error, to request something like that you must be admin")
//                     }
                    
//                 }).catch(err => {
//                     console.log(err);
//                     res.status(400).send("error while searching for admin")
//                 });
                
//             }
//         });
//     }
//     else{
//         req.app.locals.user = null;
//         // res.locals.user = null;
//         res.status(400).send('[error] user is not log in');
        
//         console.log("anonymous tried to request data [access denied] ");
        
//     }

// }
module.exports = { requireAuth, checkUser };