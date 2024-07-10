import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/home_model.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class HomeProvider {
  Dio dio = Dio();
  final Box langBox = Hive.box('lang');
  final Box homeBox = Hive.box('homeProducts');
  final Box homeDataBox = Hive.box('homeData');
//banner
  Future<List<dynamic>> fetchAllHomebanner() async {
    const String getHomeUrl = '${url}api/home';
    try {
      final Response response = await dio.get(getHomeUrl);
      if (response.statusCode == 200) {
        final List<dynamic> homeTypeData = response.data['data'];
        final List<dynamic> bannerList = homeTypeData
            .where((e) => e['type'] == 'banners')
            .map((bannersJson) {
              final List<dynamic> bannerRows = bannersJson['rows']
                  .map((rowJson) => Row.fromJson(rowJson))
                  .toList();
              return bannerRows;
            })
            .expand((i) => i)
            .toList();
        return bannerList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//type=='products' from this need get count and category name
  Future<List<Datum>> fetchAllHomeData() async {
    const String getHomeUrl = '${url}api/home';
    try {
      if (homeDataBox.isEmpty) {
        final Response response = await dio.get(getHomeUrl);
        if (response.statusCode == 200) {
          final List<dynamic> homeData = response.data['data']
              .where((item) => item['type'] == 'products')
              .toList();
          final List<Datum> homeProducts = homeData
              .map<Datum>(
                (productData) =>
                    Datum.fromJson(productData as Map<String, dynamic>),
              )
              .toList();
          final List<Map<String, dynamic>> serializedHomeProductsList =
              homeProducts.map((e) => e.toJson()).toList();
          await homeDataBox.addAll(serializedHomeProductsList);
          final List<Datum> cachedHomeProductsList = homeDataBox.values
              .map<Datum>(
                (e) => Datum.fromJson(e as Map<String, dynamic>),
              )
              .toList();
          return cachedHomeProductsList;
        } else {
          return [];
        }
      } else {
        final List<Datum> cachedHomeProductsList = homeDataBox.values
            .map<Datum>(
              (e) => Datum.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        return cachedHomeProductsList;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///type=='product' from this need get products
  Future<List<List<Row>>> fetchAllHomeProducts() async {
    const String getHomeUrl = '${url}api/home';
    try {
      if (homeBox.isEmpty) {
        final Response response = await dio.get(getHomeUrl);
        if (response.statusCode == 200) {
          final List<dynamic> homeData = response.data['data']
              .where((item) => item['type'] == 'products')
              .toList();
          final List<List<Row>> listOfProductLists = [];
          for (var productData in homeData) {
            final List<dynamic> rows = productData['rows'];
            final List<Row> productList = rows
                .map<Row>((row) => Row.fromJson(row as Map<String, dynamic>))
                .toList();
            listOfProductLists.add(productList);
          }
          for (var productList in listOfProductLists) {
            final List<Map<String, dynamic>> serializedProductList =
                productList.map((e) => e.toJson()).toList();
            await homeBox.add(serializedProductList);
          }
          return listOfProductLists;
        } else {
          return [];
        }
      } else {
        final List<List<Row>> cachedListOfProductLists = [];
        for (var serializedProductList in homeBox.values) {
          final List<Row> productList = (serializedProductList as List)
              .map<Row>((e) => Row.fromJson(e as Map<String, dynamic>))
              .toList();
          cachedListOfProductLists.add(productList);
        }

        return cachedListOfProductLists;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
