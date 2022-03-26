class ContinenCountries {
  String? name;
  String? code;
  String? phone;
  String? currency;
  String? emoji;

  ContinenCountries({this.name, this.code, this.phone, this.currency});

  ContinenCountries.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    phone = json['phone'];
    currency = json['currency'];
    emoji = json['emoji'];
  }

}
