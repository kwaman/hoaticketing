var express = require('express');

var router = express.Router();

var todoItems = [
  { id: 1, desc: 'foo' },
  { id: 2, desc: 'bar' },
  { id: 3, desc: 'baz' }
];

router.get('/',function(req,res){
  res.render('index', {
    isAuthenticated: false,
    user: req.user,
    title: 'My App',
    items: todoItems
  });
});

router.get('/login', function(req,res){
  res.render('login');
});

router.post('/add', function(req,res) {
  var newItem = req.body.newItem;

  todoItems.push({
    id: todoItems.length + 1,
    desc: newItem
  });

  res.redirect('/');

});

module.exports = router;
