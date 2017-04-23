var express = require('express');

var app = express();

app.get('/', function(req, res){
  res.send('Hello IMIE');
});

/* istanbul ignore next */
if (!module.parent) {
  app.listen(8080);
  console.log('Express started on port 8080');
}
