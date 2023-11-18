class Review {
  final int id;
  final int foodcatId;
  final int userId;
  final String review;
  final int rating;

  Review({
    required this.id,
    required this.foodcatId,
    required this.userId,
    required this.review,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      foodcatId: json['foodcatId'],
      userId: json['userId'],
      review: json['review'],
      rating: json['rating'],
    );
  }
}
