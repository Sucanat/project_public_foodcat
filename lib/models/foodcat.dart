import 'review.dart';
import 'package:collection/collection.dart';
class Foodcat {
  final int id;
  final String name;
  final double price;
  final double averageRating;
  final List<Review> reviews;

  Foodcat({
    required this.id,
    required this.name,
    required this.price,
    required this.averageRating,
    required this.reviews,
  });

  factory Foodcat.fromJson(Map<String, dynamic> json) {
    List<Review> reviews = (json['reviews'] as List<dynamic>)
        .where((review) => review['foodcatId'] == json['id'])
        .map<Review>((item) => Review.fromJson(item))
        .toList();
    var averageRating = 0.0;
    if (reviews.isNotEmpty) {
      averageRating = reviews.map((review) => review.rating).average ?? 0.0;
    }

    return Foodcat(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      averageRating: averageRating,
      reviews: reviews,
    );
  }
}
