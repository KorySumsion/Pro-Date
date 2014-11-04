var express = require('express');
var bodyParser = require('body-parser');
var cors = require('cors');
var app = express();
var port = 1111;

var Dates = require('./server-assets/dates/datesController')

var mongoose = require('mongoose');
// var Home = require('./public/home/homeController');

var databaseReference = 'mongodb://localhost/Pro-Date';

var connection = mongoose.connection;

app.use(bodyParser.json());
app.use(cors());

app.use(express.static(__dirname + '/public'));




app.post('/server', Dates.addDate);
app.get('/server', Dates.getDates);


mongoose.connect(databaseReference);
connection.once('open', function(){
	app.listen(port, function(){
		console.log('you are listening on port ' + port);
	});
});