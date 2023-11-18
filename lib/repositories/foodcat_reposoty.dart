import 'dart:convert';

import 'package:public_foodcat/models/foodcat.dart';
import '../screens/services/api.caller.dart';



class FoodcatRepository {
  Future<List<Foodcat>> getFoodcat() async {
    try {
      var result = await ApiCaller().get('foodcat?_embed=reviews');
      List list = jsonDecode(result);
      List<Foodcat> foodcatList =
      list.map<Foodcat>((item) => Foodcat.fromJson(item)).toList();
      return foodcatList;
    } catch (e) {
      // TODO:
      rethrow;
    }
  }

  Future<void> AddFoodcat({required String name, required double price}) async {
    try {
      var result = await ApiCaller().post('foodcat', params: {'name': name, 'price': price});
      // เปลี่ยน 'peice' เป็น 'price' ที่ถูกต้อง
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}
