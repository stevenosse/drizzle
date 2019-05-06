import 'package:flutter/material.dart';

class Modal {
  List<String> cities;
  String seletedItem;

  final parent;

  Modal({this.parent}){
    this._initList();
    this.seletedItem = cities[0].toString();
  }

  _initList(){
    cities = new List();
    cities.add("Yaoundé");
    cities.add("Douala");
  }

  onChangeCity(city){
    return city;
  }

  mainButtonSheet(BuildContext context, callback){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _createListTitle(context, cities[0], callback),
            _createListTitle(context, cities[1], callback),
          ],
        );
      }
    );
  }

  ListTile _createListTitle(BuildContext context, String name, Function callback){
    return ListTile(
      leading: Icon(Icons.location_city),
      title: Text(name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
      onTap: () {
        Navigator.pop(context);
        callback(name);
      },
    );
  }
}