import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;

  Future<String> getData() async {
    var response =
        await http.get(Uri.encodeFull("http://localhost:3000/products"),
            headers: {"Accept": "application/json"});

    this.setState(() {
//      data = JSON.decode(response.body);  // depricated
      data = json.decode(response.body);
    });
    print(data[1]["id"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("vyc02"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print("Index - " + index.toString());

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    id: data[index]["id"],
                    name: data[index]["name"],
                    color: data[index]["color"],
                    description: data[index]["description"],
                  ),
                ),
              );

            },


            child: new Card(
//            child: new Text(data[index]["name"]),

              child: Row(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: new BoxDecoration(color: Colors.red),

                      child: new Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: new Icon(Icons.attach_money),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        //Text("VY Challenge"),
                        Text(data[index]["id"].toString()),
                        Text(data[index]["name"]),
                        Text(data[index]["color"]),
                        Text(data[index]["description"]),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


//========================================================
class DetailScreen extends StatelessWidget {

  final int id;
  final String name;
  final String color;
  final String description;


  DetailScreen({Key key, @required this.id, this.name, this.color, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text("---   detail screen ---" ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(

          children: <Widget>[

            Spacer(
              flex: 10,
            ),

            Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(38.0),
                  child: Column(
                    children: <Widget>[
                      Text("----   the detail page Card ---"),
                      Text(id.toString()),
                      Text(name),
                      Text(color),
                      Text(description),
                    ],
                  ),
                )
              ),
            ),

            //==============================================================
            //==============================================================
            //==============================================================
            Spacer(
              flex: 10,
            ),

            Container(
              width: 200.0,
              height: 200.0,
              child: new PictureWidget(),
              )

          ])
        )
      );
  }
}


// during the interview there were some questions about plugins and custom widgets.
//  I think what the questions really meant was how to you create custom widgets.
//  So, I thought I would demonstrate a custom image widget that pulls data as a stream.
//  Observe how easy it is to do in flutter...   nothing to decode.
//  just pass a image.network widget...  and everything is taken care of.

class PictureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Image.network(
            'https://www.catster.com/wp-content/uploads/2017/08/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg',
          );
  }
}
