class Continent {
  String? name;
  String? code;

  Continent({this.name, this.code});

  Continent.fromJson(Map<String, dynamic> json) {
  name = json['name'];
  code = json['code'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = name;
  data['code'] = code;
  return data;

  }
}
