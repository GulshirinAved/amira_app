import 'dart:convert';

class BrandsModel {
  int? statusCode;
  bool? success;
  Data? data;

  BrandsModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory BrandsModel.fromRawJson(String str) =>
      BrandsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
        statusCode: json['statusCode'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  int? pageCount;
  int? count;
  List<Row>? rows;

  Data({
    this.pageCount,
    this.count,
    this.rows,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageCount: json['pageCount'],
        count: json['count'],
        rows: json['rows'] == null
            ? []
            : List<Row>.from(json['rows']!.map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'pageCount': pageCount,
        'count': count,
        'rows': rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Row {
  String? id;
  String? name;
  Logo? logo;

  Row({
    this.id,
    this.name,
    this.logo,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        name: json['name'],
        logo: json['logo'] == null ? null : Logo.fromJson(json['logo']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo': logo?.toJson(),
      };
}

class Logo {
  String? url;
  String? hashblur;

  Logo({
    this.url,
    this.hashblur,
  });

  factory Logo.fromRawJson(String str) => Logo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        url: json['url'],
        hashblur: json['hashblur'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'hashblur': hashblur,
      };
}
