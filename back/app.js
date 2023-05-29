var express = require('express');
var bodyParser = require('body-parser');
var product = require('./routes/products.route'); // Imports routes for the products
var cors = require('cors');

var app = express();

// Set up mongoose connection
var mongoose = require('mongoose');
var dev_db_url = 'mongodb://127.0.0.1/productsDB';
var mongoDB = process.env.MONGODB_URI || dev_db_url;

mongoose.connect(mongoDB, { useNewUrlParser: true });
mongoose.Promise = global.Promise;
var db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));
app.use(cors());

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use('/products', product);

var port = 1234;
app.listen(port, () => {
  console.log('Server is up and running on port number ' + port);
});

