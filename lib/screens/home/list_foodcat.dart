import 'package:flutter/material.dart';
import 'package:public_foodcat/models/foodcat.dart';
import 'package:public_foodcat/screens/home/foodcat_detail_page.dart';

class FoodcatList extends StatelessWidget {
  static const iconSize = 18.0;

  final Foodcat foodcat;

  const FoodcatList({
    required this.foodcat,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    var hasRating = foodcat.averageRating > 0;
    var numWholeStar = foodcat.averageRating.truncate();
    var fraction = foodcat.averageRating - numWholeStar;
    var showHalfStar = fraction >= 0.5;
    var numBlankStar = 5 - numWholeStar - (showHalfStar ? 1 : 0);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodcatDetailPage(foodcat: foodcat),
            ),
          ).whenComplete(() {
            // คุณสามารถเรียกเมธอดนี้เพื่อทำอะไรก็ตามหลังจากที่ผู้ใช้กลับมาจากหน้ารายละเอียด
            // เช่น การโหลดข้อมูลใหม่หรือปรับปรุงรายการอาหารแมว
            // getFoodcat();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
               Container(
                width: 60.0,
                height: 60.0,
                color: colorScheme.background,
                child: Center(child: Icon(Icons.pets, size: 30.0)), // เปลี่ยนเป็นไอคอนแมว (pets icon)
              ),

              SizedBox(width: 8.0),
              Expanded(child: Text(foodcat.name, style: textTheme.headline6)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  hasRating
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (var i = 0; i < numWholeStar; i++)
                        Icon(Icons.star, size: iconSize),
                      if (showHalfStar) Icon(Icons.star_half, size: iconSize),
                      for (var i = 0; i < numBlankStar; i++)
                        Icon(Icons.star_border, size: iconSize),
                    ],
                  )
                      : Text('ยังไม่มีคะแนน'),
                  Text('${foodcat.price.toStringAsFixed(2)} บาท', style: textTheme.bodyText2)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

