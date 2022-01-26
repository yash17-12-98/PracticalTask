import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practical/Model/Store.dart';
import 'package:practical/UrlConfig.dart';
import 'package:flutter/cupertino.dart';

import 'Model/Menu.dart';


class MenuItem extends StatefulWidget {
  String apiKey;

  MenuItem(this.apiKey);


  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {

  List<Menu> menuList = <Menu>[];


  @override
  void initState() {
    print( "this api key "+widget.apiKey.toString());
    // TODO: implement initState
    fetchMenuDetails();
    super.initState();
  }

  Future<void> fetchMenuDetails() async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'APIKEY' : widget.apiKey
    };

    final response = await http.post(Uri.parse( UrlConfig.MENU_ITEM_URL_ONLINE), headers: headers);

    print("response : "+response.body.toString());
    var decodeResponse = json.decode(response.body);
    print("decodeResponse "+ decodeResponse.toString());

    var responseList = decodeResponse['data'];

    print("response list: " +responseList.toString());

    if (response.statusCode == 200) {

      menuList.clear();

      setState(() {
        for(int i = 0 ; i < responseList.length; i++){
          menuList.add(new Menu.fromJson(responseList[i]));

        }

      });


      print("this length : "+ menuList.length.toString());


    }else {

      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            'Practical Task',
            textScaleFactor: 1,
          ),
        ),
        body : Container(
      child: MyExpansionTileList(menuList),
    ));
  }
}

class MyExpansionTileList extends StatelessWidget {
  final List<Menu> elementList;

  MyExpansionTileList(this.elementList);

  List<Widget> _getChildren() {
    List<Widget> children = [];
    elementList.forEach((element) {
      // children.add(
      //   // new MyExpansionTile(element.GroupId , element.GroupName,),
      // );
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        reverse: false,
        scrollDirection: Axis.vertical,
        itemCount: elementList.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return new MyExpansionTile(
              elementList[index].menuId!,
              elementList[index].menuName!,
              elementList,
              index,);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
              width: MediaQuery.of(context).size.width / 2,
              child: new Divider(
                color:Colors.grey,
              ));
        },
      );
  }
}

class MyExpansionTile extends StatefulWidget {
  final String did;
  final String name;
  final List<Menu> elementList;
  int index;

  MyExpansionTile(this.did, this.name, this.elementList, this.index,);

  @override
  State createState() => new MyExpansionTileState();
}

class MyExpansionTileState extends State<MyExpansionTile> {
  PageStorageKey? _key;

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    print("widget.did " + widget.did.toString());
    _key = new PageStorageKey('${widget.did}');
    print("key of did " + _key.toString());
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: new ExpansionTile(
        maintainState: true,
        initiallyExpanded: widget.index == 0,
        key: _key,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Text(
              widget.name,
              style: new TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 25,),
            ),
          ],
        ),
        children: <Widget>[
          new ListView.separated(
            key: _key,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.elementList[widget.index].cat!.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index1) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: new Text(
                        widget.elementList[widget.index].cat![index1].printer!,
                        style: new TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.width / 22),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: new Divider(
                    color: Colors.grey,
                  ));
            },
          ),
        ],
      ),
    );
  }
}
