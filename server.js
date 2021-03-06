var express = require('express');
var app = express();
var path = require('path');

var PORT = 3002;

app.use(express.static(__dirname));
app.use('/scripts', express.static(__dirname + '/node_modules/webcomponents.js/'));
app.use('/scripts', express.static(__dirname + '/node_modules/angular/'));
app.use('/scripts', express.static(__dirname + '/node_modules/react/dist'));
app.use('/scripts', express.static(__dirname + '/node_modules/react-dom/dist'));

app.get('/', function(req, res) {
 res.sendFile(path.join(__dirname + '/index.html'));
});

app.listen(PORT, function() {
  console.log('Started server...\nListening on port ' + PORT + '...');
});
