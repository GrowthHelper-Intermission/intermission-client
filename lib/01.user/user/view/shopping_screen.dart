import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermission_project/01.user/user/view/my_page_screen.dart';
import 'package:intermission_project/common/component/normal_appbar.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Product {
  final String imagePath;
  final String title;
  final String price;

  const Product(this.imagePath, this.title, this.price);

  Widget get imageWidget {
    return Image.asset(
      imagePath,
      height: 25.0,
    );
  }
}

// svg
// class Product {
//   final String imagePath;
//   final String title;
//   final String price;
//
//   const Product(this.imagePath, this.title, this.price);
//
//   Widget get imageWidget {
//     return SvgPicture.asset(
//       imagePath,
//       height: 25.0,
//     );
//   }
// }

final List<Product> products = [
  Product('assets/img/plz.png', '현금교환', '2000P'),
  Product('assets/img/cash.png', '현금교환', '3000P'),
  Product('assets/img/cash.png', '현금교환', '5000P'),
  Product('assets/img/cash.png', '현금교환', '10000P'),
];

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NormalAppbar(
        title: '포인트 교환',
        color: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
            child: Text(
              '적립한 포인트를 현금으로\n교환해 보세요!',
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey[700],
              ),
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
        _launchURL('https://growthhelper.kr/shop/?idx=9');
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
                product.price,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
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