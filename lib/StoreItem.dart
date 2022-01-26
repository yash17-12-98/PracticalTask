
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practical/MenuItem.dart';
import 'package:practical/Model/Store.dart';
import 'package:practical/UrlConfig.dart';

class StoreItem extends StatefulWidget {
  @override
  _StoreItemState createState() => _StoreItemState();
}

class _StoreItemState extends State<StoreItem> {


  List<Store> storeList = <Store>[];

  bool storeLoader = false;


  @override
  void initState() {
    // TODO: implement initState
    fetchStoreDetails();
    super.initState();
  }

  Future<void> fetchStoreDetails() async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'APIKEY' : 'bd_suvlascentralpos'
    };
    storeLoader = true;

    final response = await http.post(Uri.parse( UrlConfig.STORE_URL_ONLINE), headers: headers);

    print("response : "+response.body.toString());
    var decodeResponse = json.decode(response.body);
    print("decodeResponse "+ decodeResponse.toString());

    var responseList = decodeResponse['franquicias'];


    if (response.statusCode == 200) {

      storeList.clear();
      setState(() {
        for(int i = 0 ; i < responseList.length; i++){
          storeList.add(new Store.fromJson(responseList[i]));
        }
        storeLoader =false;
      });

      print("this length : "+storeList.length.toString());


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
        body: Stack(
          children: [
            storeList.length != 0 ? Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                    itemCount: storeList.length,
                    shrinkWrap: true,
                    itemBuilder:  (BuildContext context, int index){
                      return GestureDetector(
                        child: ListTile(
                          title: Text(storeList[index].name!),
                        ),
                        onTap: (){

                          print("api key : "+storeList[index].apiKey.toString());
                          if(storeList[index].apiKey != null){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuItem(storeList[index].apiKey.toString())));
                          }else{
                            print("null");
                          }
                          },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index){
                      return Divider(color: Colors.black);
                    }),
              ),
            ) : Center(child: Text("No Record Found")),
          ],
        )
    );
  }
}
