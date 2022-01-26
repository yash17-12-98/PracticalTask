import 'package:flutter/foundation.dart';
import 'package:practical/Model/Categories.dart';

class Menu {
  String? menuId;
  String? menuName;
  List<Categories>? cat;



  Menu(
      this.menuId,
      this.menuName,
      this.cat);

  Menu.fromJson(Map<String, dynamic> json) {
    menuId = json['idmenu'];
    menuName = json['nombre'];
    if (json['categoria']['printers'] != null) {
      cat = <Categories>[];
      json['categoria']['printers'].forEach((v) {
        cat!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idmenu'] = this.menuId;
    data['nombre'] = this.menuName;

    return data;
  }
}



