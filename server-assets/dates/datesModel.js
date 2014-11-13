var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var dates = new Schema({
	id: {type: String, required: true},
	latitude: {type: Number, required: true},
	longitude: {type: Number, required: true},
	show: {type: Boolean, default: false},
	description: {type: String},
	price: {type: String},
	indoor: {type: Boolean},
	outdoor: {type: Boolean},
	indoorActive: {type: Boolean},
	outdoorActive: {type: Boolean},
	indoorWalk: {type: Boolean},
	outdoorWalk: {type: Boolean}
});

module.exports = mongoose.model('Dates', dates);