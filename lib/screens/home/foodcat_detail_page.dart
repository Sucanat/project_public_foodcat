// foodcat_detail_page.dart

import 'package:flutter/material.dart';
import 'package:public_foodcat/models/foodcat.dart';

class FoodcatDetailPage extends StatelessWidget {
  final Foodcat foodcat;

  FoodcatDetailPage({required this.foodcat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foodcat Detail'),
      ),
      body: Container(
        color: Colors.white, // เพิ่มสีพื้นหลังสีขาว
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${foodcat.name}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Price: ${foodcat.price.toStringAsFixed(2)} บาท', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Average Rating: ${foodcat.averageRating.toStringAsFixed(1)}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Text('Reviews:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            // เปลี่ยนเป็น ListView.builder เพื่อให้สามารถเลื่อนลงไปดูรีวิวได้
            Expanded(
              child: ListView.builder(
                itemCount: foodcat.reviews.length,
                itemBuilder: (context, index) {
                  var review = foodcat.reviews[index];
                  return ListTile(
                    title: Text(review.review),
                    subtitle: Text('Rating: ${review.rating}'),
                  );
                },
              ),
            ),
            if (foodcat.reviews.isEmpty)
              Text('No reviews available', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}
