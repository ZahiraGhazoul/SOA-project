const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let ProductSchema = new Schema({
  _id: { type: Schema.Types.ObjectId, auto: true },
  name: { type: String, required: true, max: 100 },
  price: { type: Number, required: true },
});

//module.exports = mongoose.model('Product', ProductSchema); 
//module.exports = mongoose.model('ProductModel', ProductSchema);
module.exports = mongoose.model('Product', ProductSchema, 'products');



