import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() async {

  List _data = await getJson();
  //print(_data);
  //String _body = _data[1]['body'];

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: AppBar(
        title: new Text("JSON Parse"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context , int position){

              if(position.isOdd) return new Divider();
              final index = position ~/ 2 ;
              return new ListTile(

                title: Text("${_data[index]['title']}",
                  style: new TextStyle(fontSize: 13.9)),

                subtitle: Text("${_data[index]['body']}",
                  style: TextStyle(fontSize: 13.9,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic
                  ),),

                leading: new CircleAvatar(
                  backgroundColor: Colors.green,
                  child: new Text("${_data[index]['title'][0].toString().toUpperCase()}",
                    style: TextStyle(fontSize: 19.9,
                      color: Colors.yellow),),
                ),

                onTap: (){_showOnTapMessage(context , "${_data[index]['title']}");},
              );
            })
      ),
    ),
  ));
}

void _showOnTapMessage(BuildContext context , String message){
  var alert = new AlertDialog(
    title: Text('App'),
    content: Text(message),
    actions: <Widget>[
      FlatButton(onPressed: (){Navigator.pop(context);},
          child: Text("OK"))
    ],
  );
  showDialog(context: context , child: alert);
}

Future<List> getJson() async {
  String apiUrl = 'http://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}