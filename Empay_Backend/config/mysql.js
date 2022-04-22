const mysql =require('mysql');
const personalDetails = require('../secret/details');
let db = mysql.createConnection({
    host: personalDetails.hostname,
    user: personalDetails.user,
    password : personalDetails.password,
    database : personalDetails.database,

});

db.connect(function(err){
    if(err){ 
        return console.log('Error while connection',err);
    } 
    else{
        console.log('Connection Stabilized');
    }
});

module.exports = db;

