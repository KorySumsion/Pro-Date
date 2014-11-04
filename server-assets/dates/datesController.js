var datesModel = require('./datesModel');

module.exports = {

  getDates: function (req, res) {
    datesModel.find().exec(function(err, dates){
      res.send(dates);
    });
  },
  addDate: function (req, res) {
    var newDate = new datesModel(req.body);
    newDate.save(function (err) {
      if(err){
        res.send(err);
      } else {
        res.status(200).send(req.body.name + ' was successfully added date');
      }
    });
  }
}


