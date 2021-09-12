const http = require('http');
const hostname = require('ip').address();
const port = 3000;


const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.setHeader('Access-Control-Allow-Origin'     , '*');
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Headers'    , 'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale');
  res.setHeader('Access-Control-Allow-Methods'    , 'POST, OPTIONS');

  var url = req.url;
  if (url ==='/getScores') {
    res.write('{"scores" : [' + 
      '{"date" : "2020-01-15",  "score" : 20},' +
      '{"date" : "2020-02-15",  "score" : 14},' +
      '{"date" : "2020-03-01",  "score" : 22},' +
      '{"date" : "2020-06-01",  "score" : 18},' +
      '{"date" : "2020-07-25",  "score" : 19},' +
      '{"date" : "2020-09-01",  "score" : 18},' +
      '{"date" : "2020-10-01",  "score" : 22},' +
      '{"date" : "2020-11-01",  "score" : 23},' +
      '{"date" : "2020-12-01",  "score" : 22} ' +
    ']}');
  }
  res.end('');
});


server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
