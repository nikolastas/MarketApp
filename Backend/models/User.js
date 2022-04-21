const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: [true, 'Please enter a username'],
    minlength: [5, 'Enter a username with minimum length of 6 charachters'],
    unique: true,
  },
  group: {
    type: String,
    unique: false,
    minlength: [1, 'Enter a group with minimum length of 1 charachters'],
    maxlength: [10, 'Enter a group with maximum length of 10 charachters'],
  },
  email: {
    type: String,
    required: false,
    unique: true,
    lowercase: true,

  },
  password: {
    type: String,
    required: [true, 'Please enter a password'],
    minlength: [6, 'Minimum password length is 6 characters'],
  }
});


// fire a function before doc saved to db
userSchema.pre('save', async function (next) {
  const salt = await bcrypt.genSalt();
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

// static method to login user
userSchema.statics.login = async function (email, password) {
  const user = await this.findOne({ email });
  if (user) {
    const auth = await bcrypt.compare(password, user.password);
    if (auth) {
      return user;
    }
    throw Error('incorrect password');
  }
  throw Error('incorrect email');
};
const conn = mongoose.createConnection(process.env.USERS_DATABASE_URL, {
  serverSelectionTimeoutMS: 5000
});
const User = conn.model('user', userSchema);

module.exports = User;