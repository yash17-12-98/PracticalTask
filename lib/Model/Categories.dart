class Categories {
  String? printerId;
  String? printer;

  Categories(this.printerId, this.printer);

  Categories.fromJson(Map<String, dynamic> json) {
    printerId = json['id_printer'];
    printer = json['desc_printer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_printer'] = this.printerId;
    data['desc_printer'] = this.printer;
    return data;
  }
}