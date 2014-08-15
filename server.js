var fs = require('fs');
var http = require('http');
var https = require('https');
var logger = require('morgan');

var privateKey = fs.readFileSync('certs/server.key.pem');
var certificate = fs.readFileSync('certs/server.crt.pem');

var credentials = {
	key: privateKey,
	cert: certificate
};

var host = process.argv[2];

var express = require('express');
var app = express();
app.use(logger('dev'));
app.set('view engine', 'ejs');

app.get('/', function(req, res) {
	res.render('index.ejs', {
		host: host
	});
});
app.use(express.static(__dirname + '/'));

var httpServer = http.createServer(app);
var httpsServer = https.createServer(credentials, app);

httpServer.listen(8080);
httpsServer.listen(8043);

console.log('using hostname: ' + host);
console.log('http server listening on port 8080');
console.log('https server listening on port 8043');