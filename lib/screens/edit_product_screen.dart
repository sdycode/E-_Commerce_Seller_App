// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen({Key? key}) : super(key: key);
  static const String routeName = '/Edit_Screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imgUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editProduct = Product(
      id: '', title: '', description: '', price: 0, imgUrl: '', backImgUrl: '');
  late TextEditingController _imgurlController = TextEditingController();
  var _isInit = true;
  var isLoading = false;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imgUrl': '',
    'backImgUrl': ''
  };
  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImageUrl);
    _imgurlController.text =
        "https://image.shutterstock.com/image-vector/add-image-icon-editable-vector-260nw-1692684598.jpg";
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgurlController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != null) {
        _editProduct = Provider.of<Products>(context, listen: false)
            .findProductById(productId);
        _initValues = {
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imgurlController.text = _editProduct.imgUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    final prodId = ModalRoute.of(context)!.settings.arguments as String;
    var prods = Provider.of<Products>(context, listen: false);
    _form.currentState!.save();
    setState(() {
      isLoading = true;
    });
    if (_editProduct.id != null) {
      try {
       await  prods.updateProduct(prodId, _editProduct);
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Went wrong !!!"),
                  content: Text("Error is : " + error.toString()),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ));
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
    } else {
      try {
        await prods.addProduct(_editProduct);
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Went wrong !!!"),
                  content: Text("Error is : " + error.toString()),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ));
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Product"),
          actions: [
            IconButton(onPressed: _saveForm, icon: const Icon(Icons.save)),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _form,
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        TextFormField(
                          initialValue: _initValues['title'],
                          decoration: const InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please some text ...';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editProduct = Product(
                                id: '',
                                title: value.toString(),
                                description: '',
                                price: 0,
                                imgUrl: '',
                                backImgUrl: '');
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['price'],
                          decoration: const InputDecoration(labelText: 'Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              print("Empty");
                              return 'Please enter some value ...';
                            }
                            // if (isNumber(value.toString())) {
                            //   return 'Please enter numbers only ...';
                            // }
                            if (double.parse(value.toString()) <= 0) {
                              return 'Please enter positive value';
                            }
                            print("Price is  :" + value.toString());
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          focusNode: _priceFocusNode,
                          onSaved: (value) {
                            _editProduct = Product(
                                id: '',
                                title: _editProduct.title,
                                description: '',
                                price: double.parse(value.toString()),
                                imgUrl: '',
                                backImgUrl: '');
                          },
                        ),
                        TextFormField(
                            initialValue: _initValues['description'],
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            focusNode: _descriptionFocusNode,
                            onSaved: (value) {
                              _editProduct = Product(
                                  id: '',
                                  title: _editProduct.title,
                                  description: value.toString(),
                                  price: _editProduct.price,
                                  imgUrl: '',
                                  backImgUrl: '');
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text ...';
                              }
                              return null;
                            }),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                  ),
                                  child: Container(
                                    height: 100,
                                    child: _imgurlController.text.isEmpty
                                        ? const Text("Enter image URL")
                                        : FittedBox(
                                            child: Image.network(
                                            _imgurlController.text,
                                            fit: BoxFit.fitHeight,
                                          )),
                                  )),
                              Expanded(
                                child: TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Image URL',
                                        prefixIcon: Icon(Icons.image_rounded)),
                                    keyboardType: TextInputType.url,
                                    textInputAction: TextInputAction.done,
                                    controller: _imgurlController,
                                    focusNode: _imgUrlFocusNode,
                                    maxLines: 3,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter some value ...';
                                      }
                                      if (!value.startsWith('http') ||
                                          !value.startsWith('https')) {
                                        return "Please enter valid URL";
                                      }
                                      if (!value.endsWith('png') &&
                                          !value.endsWith('jpg') &&
                                          !value.endsWith('jpeg')) {
                                        return "Image format is NOT valid";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _editProduct = Product(
                                          id: '',
                                          title: _editProduct.title,
                                          description: _editProduct.description,
                                          price: _editProduct.price,
                                          imgUrl: value.toString(),
                                          backImgUrl:
                                              "https://image.shutterstock.com/image-vector/add-image-icon-editable-vector-260nw-1692684598.jpg");
                                    },
                                    onFieldSubmitted: (_) {
                                      _saveForm();
                                    }),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
      );
    }

    isNumber(String value) {
      return double.tryParse(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

 
}
/*

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     final productId = ModalRoute.of(context)!.settings.arguments as String;
  //     if (productId != null) {
  //       _editProduct = Provider.of<Products>(context, listen: false)
  //           .findProductById(productId);
  //       _initValues = {
  //         'title': _editProduct.title,
  //         'description': _editProduct.description,
  //         'price': _editProduct.price.toString(),
  //         'imgUrl': '',
  //         'backImgUrl': ''
  //       };
  //       _imgurlController.text = _editProduct.imgUrl;
  //     } else {
  //       _editProduct = Product(
  //           id: "",
  //           title: '',
  //           description: '',
  //           price: 0,
  //           imgUrl: '',
  //           backImgUrl: '');
  //       _initValues = {
  //         'title': _editProduct.title,
  //         'description': _editProduct.description,
  //         'price': _editProduct.price.toString(),
  //         'imgUrl': '',
  //         'backImgUrl': ''
  //       };
  //       print("in dependency method");
  //     }
  //   }

  //   _isInit = false;
  //   super.didChangeDependencies();
  // }
*/