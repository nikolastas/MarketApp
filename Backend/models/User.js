const bcrypt = require("bcryptjs");
function encryptPasswordIfChanged(user, options) {
  if (user.changed('password')) {
    encryptPassword(user.get('password'));
  }
}
module.exports = (sequelize, Sequelize) => {
    const User = sequelize.define("users", {
      username: {
        type:Sequelize.STRING, 
        validate:{
          not:{
            args: /[_.]/,
            msg: "[username] Must NOT contain '_' or '.'"
          },
          is:{args:/[a-zA-Z0-9._]/, msg:"[username value] should contain at minimum at least 4 letters "},
          len:  {
            args: [4,40],
            msg: "[username length] Must NOT be less than 4 and Must NOT be greater than 40"
          },
        },
        allowNull: false, 
        primaryKey: true
      },
      password: {
        type:Sequelize.STRING,
        validate:{
          len:  {
            args: [8,30],
            msg: "[password length] Must NOT be less than 8 and Must NOT be greater than 30"
          },
          is:{
            args:/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$/,
            msg: "[password value] should contain at minimum at least one letter and one number , length should be over 8 charachters"
        }
      },
        
        allowNull: false
      },
      group:{
        
        type:Sequelize.STRING,
        len:  {
            args: [10],
            msg: "[group's name] Must be 10 characters"
          },
        allowNull: true
      },
      email:{
        type:Sequelize.STRING,
        validate:{
          isEmail:{args:true, msg:"[email] must be a valid email address"},
        },
        allowNull:true
      }
    }, 
      {
        hooks:{
          beforeCreate: async (user) => {
            
            if (user.password) {
              
              const salt = await bcrypt.genSalt();
              user.password = bcrypt.hashSync(user.password, salt);
              console.log(user.password);
              
            }
           },
           beforeUpdate:async (user) => {
            if (user.password) {
              if(user.changed('password')){
                const salt = await bcrypt.genSalt();
                user.password = bcrypt.hashSync(user.password, salt);
              }
            }
           }
          },
          instanceMethods: {
           validPassword: (password) => {
            return bcrypt.compareSync(password, this.password);
           }
         
        },
      timestamps: false
    }
  );
  
    return User;
  };