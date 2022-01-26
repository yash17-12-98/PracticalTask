class Store {
  String? apiKey;
  String? token;
  String? name;
  bool? principal;
  String? franqId;


  Store(
      this.apiKey,
        this.token,
        this.name,
        this.principal,
        this.franqId);

  Store.fromJson(Map<String, dynamic> json) {
    apiKey = json['APIKEY'];
    token = json['tokenInvu'];
    name = json['negocio'];
    principal = json['principal'];
    franqId = json['id_franquicia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['APIKEY'] = this.apiKey;
    data['tokenInvu'] = this.token;
    data['negocio'] = this.name;
    data['principal'] = this.principal;
    data['id_franquicia'] = this.franqId;

    return data;
  }
}
