// dependencies
var fs = require('fs');
var https = require('https');

var express = require('express');
var bodyParser = require('body-parser');
var cookieParser = require('cookie-parser');
var expressSession = require('express-session');

// authentication
var passport = require('passport');
var passportLocal = require('passport-local');
var passportHttp = require('passport-http');

// start app
var app = express()

// establish SSL with self-signed cert
var server = https.createServer({
  cert: fs.readFileSync(__dirname + '/my.crt'),
  key: fs.readFileSync(__dirname + '/my.key')
}, app);

// sets view engine
app.set('view engine', 'ejs');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(expressSession( {
  secret: process.env.SESSION_SECRET || 'secret',
  resave: false,
  saveUninitialized: false
}));

app.use(passport.initialize());
app.use(passport.session());

passport.use(new passportLocal.Strategy(verifyCredentials));

passport.use(new passportHttp.BasicStrategy(verifyCredentials));

function verifyCredentials(username, password, done){
  if(username === password){
    done(null, { id: username, name: username })
  } else {
    done(null, null);
  }
}

// Configuring Passport
passport.serializeUser(function(user, done) {
  done(null, user.id);
});

passport.deserializeUser(function(id, done){
  // Query database or cache here
  done(null, {id: id, name: id });
});

function ensureAuthenticated(req, res, next){
  if (req.isAuthenticated()){
    next ();
  } else {
    res.send(403);
  }
};


// Index method
app.get('/', function(req, res){
  res.render('index', {
    title: 'HOA Ticketing System',
    isAuthenticated: req.isAuthenticated(),
    user: req.user
  });
});

// About page
app.get('/about', function(req,res){
  res.render('about', {
    title: 'HOA Ticketing System'
  });
});


// Login methods
app.get('/login', function(req,res){
  res.render('login');
});

app.post('/login', passport.authenticate('local'), function(req,res){
  res.redirect('/');
});

//Log out methods
app.get('/logout', function(req,res){
  req.logout();
  res.redirect('/');
});



// API methods
app.use('/api',passport.authenticate('basic'));

app.get('/api/data', ensureAuthenticated, function(req,res){
  res.json([
    { value: 'foo' },
    { value: 'bar' },
    { value: 'baz' }
  ]);
});

//Server config
var port = process.env.PORT || 1337;

server.listen(port, function() {
  console.log('http://127.0.0.1:' + port + '/');
});
