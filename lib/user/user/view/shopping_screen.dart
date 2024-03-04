import 'package:flutter/material.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/user/user/view/shopping_detail_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/view/setting/setting_screen.dart';

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
  Product('assets/img/shopping/3000.png', '현금교환', 3000),
  Product('assets/img/shopping/5000.png', '현금교환', 5000),
  Product('assets/img/shopping/10000.png', '현금교환', 10000),
  Product('assets/img/shopping/20000.png', '현금교환', 20000),
];

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '포인트 교환',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen()),
                );
              },
              icon: Image.asset(
                'assets/img/Setting.png',
                width: 45,
                height: 45,
                color: Colors.white,
              ),
            ),
          ],
        ),
        foregroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 깎기 위함
              ),
              height: 70,
              alignment: Alignment.center, // 텍스트를 컨테이너 중앙에 배치
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "적립한 포인트를 현금으로 교환해 보세요!\n",
                  textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
              ),
            ),
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
          MaterialPageRoute(
              builder: (context) => ShoppingDetailScreen(
                    point: product.point,
                  )),
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
