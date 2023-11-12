import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermission_project/01.user/user/view/my_page_screen.dart';
import 'package:intermission_project/01.user/user/view/shopping_detail_screen.dart';
import 'package:intermission_project/common/component/normal_appbar.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Product {
  final String imagePath;
  final String title;
  final int point;

  const Product(this.imagePath, this.title, this.point);

  Widget get imageWidget {
    return Image.asset(
      imagePath,
      height: 25.0,
    );
  }
}

final List<Product> products = [
  Product('assets/img/2000.png', '현금교환', 2000),
  Product('assets/img/3000.png', '현금교환', 3000),
  Product('assets/img/5000.png', '현금교환', 5000),
  Product('assets/img/10000.png', '현금교환', 10000),
];

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NormalAppbar(
        title: '포인트 교환',
        color: PRIMARY_COLOR,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              '적립한 포인트를 현금으로\n교환해 보세요!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black),
              maxLines: 3,
            ),
          ),
          Divider(
            color: Colors.grey[200],
            height: 1,
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(6),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  _buildProductItem(context, products[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ShoppingDetailScreen(point: product.point,)),
        );
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: product.imageWidget, // SVG 이미지 위젯을 가져옵니다.
            ),
            const SizedBox(height: 6),
            Text(
              product.title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '${product.point}P',
                style: TextStyle(
                  color: GREEN_COLOR,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
