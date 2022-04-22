const express = require('express');

const db = require('./config/mysql');

const app = express();

const port = process.env.PORT || 8000;

app.use(express.json());
app.use(express.urlencoded());

app.use('/',require('./router/index'));

app.listen(port , function(err){
    if(err){
        console.log('Error while listening');
    }
    console.log('Running!!');
})