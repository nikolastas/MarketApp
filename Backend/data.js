require('dotenv').config();
const mongoose = require('mongoose');


if (!process.env.DATABASE_URL) {

    console.log("There does not seem to be a value for the database connection string in DATABASE_URL");
    process.env.DATABASE_URL = "mongodb://nikolastas:aQI5IplodxBX3YF3aRAyhEwhjWaOGBaUzjPHnWRf3QjAh1aadTVT1bV0rKiW34Tf98zqBUO6j6D6y6wP2M4Gcw==@nikolastas.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@nikolastas@";
}

// To override the database name, set the DATABASE_NAME environment variable in the .env file
const DATABASE_NAME = process.env.DATABASE_NAME || 'MarketApp';

mongoose.connect(process.env.DATABASE_URL, {
    dbName: DATABASE_NAME,
    useNewUrlParser: true,
    useUnifiedTopology: true
  });
  
mongoose.connection
  .on('open', () => {
    console.log('Mongoose connection open to database');
  })
  .on('error', (err) => {
    console.log(`Connection error: ${err.message}`);
  });