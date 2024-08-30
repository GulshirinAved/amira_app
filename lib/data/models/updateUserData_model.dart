import 'dart:convert';

class UpdateUserDataModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  UpdateUserDataModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory UpdateUserDataModel.fromRawJson(String str) =>
      UpdateUserDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateUserDataModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserDataModel(
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
  final String? id;
  final String? address;
  late final String? birthday;
  final int? coins;
  final DateTime? createdAt;
  final dynamic email;
  final String? gender;
  final String? name;
  final String? phone;
  final String? fcmToken;
  final bool? emailNotifications;
  final bool? fcmNotifications;
  final bool? smsNotifications;
  final List<dynamic>? owneringShops;
  final List<dynamic>? operatingShops;
  final List<dynamic>? viewedProduct;

  Data({
    this.id,
    this.address,
    this.birthday,
    this.coins,
    this.createdAt,
    this.email,
    this.gender,
    this.name,
    this.phone,
    this.fcmToken,
    this.emailNotifications,
    this.fcmNotifications,
    this.smsNotifications,
    this.owneringShops,
    this.operatingShops,
    this.viewedProduct,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        id: json['id'],
        address: json['address'],
        birthday: json['birthday'] == null ? null : json['birthday'],
        coins: json['coins'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        email: json['email'],
        gender: json['gender'],
        name: json['name'],
        phone: json['phone'],
        fcmToken: json['fcmToken'],
        emailNotifications: json['emailNotifications'],
        fcmNotifications: json['fcmNotifications'],
        smsNotifications: json['smsNotifications'],
        owneringShops: json['owneringShops'] == null
            ? []
            : List<dynamic>.from(json['owneringShops']!.map((x) => x)),
        operatingShops: json['operatingShops'] == null
            ? []
            : List<dynamic>.from(json['operatingShops']!.map((x) => x)),
        viewedProduct: json['viewedProduct'] == null
            ? []
            : List<dynamic>.from(json['viewedProduct']!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'birthday': birthday,
        'coins': coins,
        'createdAt': createdAt?.toIso8601String(),
        'email': email,
        'gender': gender,
        'name': name,
        'phone': phone,
        'fcmToken': fcmToken,
        'emailNotifications': emailNotifications,
        'fcmNotifications': fcmNotifications,
        'smsNotifications': smsNotifications,
        'owneringShops': owneringShops == null
            ? []
            : List<dynamic>.from(owneringShops!.map((x) => x)),
        'operatingShops': operatingShops == null
            ? []
            : List<dynamic>.from(operatingShops!.map((x) => x)),
        'viewedProduct': viewedProduct == null
            ? []
            : List<dynamic>.from(viewedProduct!.map((x) => x)),
      };
}
