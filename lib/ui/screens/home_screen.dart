// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Assuming ProductDataModel is defined somewhere in your project
import 'package:project/data_models/product_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  bool isError = false;
  String errorMessage = '';
  static List<ProductDataModel> myList = [];

  Future<void> getProductData() async {
    var response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      try {
        List<dynamic> productsList = jsonDecode(response.body);

        for (Map<String, dynamic> item in productsList) {
          ProductDataModel p = ProductDataModel.fromMapJson(item);
          myList.add(p);
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print('error $e');
        setState(() {
          isLoading = false;
          isError = true;
          errorMessage = e.toString();
        });
      }
    } else {
      print('error ${response.statusCode}');
      print('error ${response.body}');
      setState(() {
        isLoading = false;
        isError = true;
        errorMessage = '${response.statusCode}/n${response.body}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home Screen'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isError
              ? Center(
                  child: Text('Error occurred: $errorMessage'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.network(
                              myList[index].image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${myList[index].name}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              myList[index].description ??
                                  'No Description Available',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$${myList[index].price}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
