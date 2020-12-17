var express = require('express')
var app = express()
const port = 3000

app.use('/assets', express.static('assets'))

app.get('/',function(req, res) {
    res.redirect('/toip');
});

app.get('/single',function(req, res) {
    res.sendFile(__dirname + '/spec_site/single/index.html');
});

app.get('/multi',function(req, res) {
    res.sendFile(__dirname + '/spec_site/multi/index.html');
});

app.get('/toip',function(req, res) {
    res.sendFile(__dirname + '/spec_site/toip/index.html');
});

app.listen(port, () => {
    console.log(`app listening at http://localhost:${port}`)
})
