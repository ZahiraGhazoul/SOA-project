const Product = require('../models/product.model');

exports.test = function (req, res) {
  res.send('Greetings from the Test controller!');
};

exports.product_create = function (req, res, next) {
  let product = new Product({
    name: req.body.name,
    price: req.body.price
  });

  product.save()
    .then(() => {
      res.send("Product Created successfully");
    })
    .catch((err) => {
      return next(err);
    });
};

exports.product_details = function (req, res, next) {
  Product.findById(req.params.id)
    .then(product => {
      res.send(product);
    })
    .catch((err) => {
      return next(err);
    });
};



exports.product_list = function(req, res, next) {
  Product.find({})
    .then(products => {
      res.send(products);
    })
    .catch(err => {
      return next(err);
    });
};








exports.product_update = function (req, res, next) {
  Product.findByIdAndUpdate(req.params.id, { $set: req.body })
    .then(product => {
      res.send('Product updated.');
    })
    .catch((err) => {
      return next(err);
    });
};

exports.product_delete = function (req, res, next) {
  Product.findByIdAndRemove(req.params.id)
    .then(() => {
      res.send('Deleted successfully!');
    })
    .catch((err) => {
      return next(err);
    });
};

