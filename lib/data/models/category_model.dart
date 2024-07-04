import 'dart:convert';

class CategoryModel {
  int? statusCode;
  bool? success;
  Data? data;

  CategoryModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
  int? count;
  int? pageCount;
  List<Row>? rows;

  Data({
    this.count,
    this.pageCount,
    this.rows,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'],
        pageCount: json['pageCount'],
        rows: json['rows'] == null
            ? []
            : List<Row>.from(json['rows']!.map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'pageCount': pageCount,
        'rows': rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Row {
  String? id;
  Image? image;
  String? parentId;
  DateTime? createdAt;
  List<Row>? subcategories;
  String? name;

  Row({
    this.id,
    this.image,
    this.parentId,
    this.createdAt,
    this.subcategories,
    this.name,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        image: json['image'] == null ? null : Image.fromJson(json['image']),
        parentId: json['parentId'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        subcategories: json['subcategories'] == null
            ? []
            : List<Row>.from(
                json['subcategories']!.map((x) => Row.fromJson(x))),
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image?.toJson(),
        'parentId': parentId,
        'createdAt': createdAt?.toIso8601String(),
        'subcategories': subcategories == null
            ? []
            : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
        'name': name,
      };
}

class Image {
  String? url;
  String? hashblur;

  Image({
    this.url,
    this.hashblur,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json['url'],
        hashblur: json['hashblur'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'hashblur': hashblur,
      };
}
