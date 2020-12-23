import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsListPage extends StatefulWidget {
  var _products = ["במבה", "ביסלי", "בייגלה"];
  var _userObject;
  var _currListObject;
  var _currGroupObject;
  var myAddProductModelTextbox = TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  ProductsListPage(
      this._currListObject, this._userObject, this._currGroupObject);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  void initState() {
    super.initState();
    // var productsFromdb= []
    // productsFromdb = getProducts();
    // setState(() {});
  }

  void getProducts() async {
    var result = await http.get("https://me-kone.herokuapp.com/products/");
    return jsonDecode(result.body);
  }

  Widget _buildRow(BuildContext context, int index) {
    if (index.isEven) {
      return ListTile(
        title: Text(
          widget._products[index ~/ 2].toUpperCase(),
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      );
    } else {
      return Divider();
    }
  }

  Widget _buildOptions() {
    return ListView(
      children: <Widget>[
        new ListTile(
          title: Text(
            widget._currListObject,
            style: TextStyle(
              fontSize: 30,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          subtitle: Text(
            " קבוצה:" + widget._currGroupObject,
            style: TextStyle(
              fontSize: 20,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ),
        new Expanded(
            child: new ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          itemBuilder: _buildRow,
          itemCount: widget._products.length * 2,
        ))
      ],
    );
  }

  void _addProduct(productslist) {
    setState(() {
      widget._products = productslist;
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: widget._scaffoldKey.currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "הוספת מוצר חדש",
            textAlign: TextAlign.right,
          ),
          content: TextField(
            controller: widget.myAddProductModelTextbox,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(hintText: "הכנס את המוצר שאתה רוצה"),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Add"),
              onPressed: () async {
                //add post request to the db and add to the local list
                // widget._products.add(widget.myAddProductModelTextbox.text);
                var products = widget._products;
                products.add(widget.myAddProductModelTextbox.text);
                _addProduct(products);
                await http.post("https://me-kone.herokuapp.com/items/", body: {
                  "name": widget.myAddProductModelTextbox.text,
                  "author": '1',
                  "list": '1'
                });
                print("added to db");
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Meקונה',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildOptions(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              _showDialog();
            },
            child: Icon(Icons.edit),
            backgroundColor: Colors.black,
            tooltip: 'New product',
          ),
        ),
      ),
    );
  }
}
// class ProductsListPage extends StatelessWidget {
//   List _products = ["במבה", "ביסלי", "בייגלה"];
//   var _userObject;
//   var _currListObject;
//   var _currGroupObject;
//   final myAddProductModelTextbox = TextEditingController();
//   var _scaffoldKey = new GlobalKey<ScaffoldState>();

//   ProductsListPage(
//       this._currListObject, this._userObject, this._currGroupObject);

//   Widget _buildRow(BuildContext context, int index) {
//     if (index.isEven) {
//       return ListTile(
//         title: Text(
//           _products[index ~/ 2].toUpperCase(),
//           textDirection: TextDirection.rtl,
//           style: TextStyle(
//             fontSize: 20,
//           ),
//         ),
//       );
//     } else {
//       return Divider();
//     }
//   }

//   Widget _buildOptions() {
//     return ListView(
//       children: <Widget>[
//         new ListTile(
//           title: Text(
//             this._currListObject,
//             style: TextStyle(
//               fontSize: 30,
//             ),
//             textDirection: TextDirection.rtl,
//             textAlign: TextAlign.right,
//           ),
//           subtitle: Text(
//             " קבוצה:" + this._currGroupObject,
//             style: TextStyle(
//               fontSize: 20,
//             ),
//             textDirection: TextDirection.rtl,
//             textAlign: TextAlign.right,
//           ),
//         ),
//         new Expanded(
//             child: new ListView.builder(
//           shrinkWrap: true,
//           padding: EdgeInsets.all(16),
//           itemBuilder: _buildRow,
//           itemCount: _products.length * 2,
//         ))
//       ],
//     );
//   }

//   void _showDialog() {
//     // flutter defined function
//     showDialog(
//       context: _scaffoldKey.currentContext,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//           title: new Text(
//             "הוספת מוצר חדש",
//             textAlign: TextAlign.right,
//           ),
//           content: TextField(
//             controller: myAddProductModelTextbox,
//             textInputAction: TextInputAction.go,
//             decoration: InputDecoration(hintText: "הכנס את המוצר שאתה רוצה"),
//           ),
//           actions: <Widget>[
//             // usually buttons at the bottom of the dialog
//             new FlatButton(
//               child: new Text("Add"),
//               onPressed: () {
//                 //add post request to the db and add to the local list
//                 this._products.add(myAddProductModelTextbox.text);
//                 Navigator.of(context).pop();
//               },
//             ),
//             new FlatButton(
//               child: new Text("Close"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text(
//           'Meקונה',
//           style: TextStyle(
//             fontSize: 40,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: _buildOptions(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//       floatingActionButton: Container(
//         height: 80.0,
//         width: 80.0,
//         child: FittedBox(
//           child: FloatingActionButton(
//             onPressed: () {
//               _showDialog();
//             },
//             child: Icon(Icons.edit),
//             backgroundColor: Colors.black,
//             tooltip: 'New product',
//           ),
//         ),
//       ),
//     );
//   }
// }
