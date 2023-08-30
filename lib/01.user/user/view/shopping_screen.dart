import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/normal_appbar.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Product {
  final String imagePath;
  final String title;
  final String price;

  Product(this.imagePath, this.title, this.price);
}

final List<Product> products = [
  Product('assets/tabimg/shopping/GuideBook.png', 'PMF를 찾기 위한 효율적인\n고객 인터뷰 가이드북 상품', '70P'),
  Product('assets/tabimg/shopping/GuideBook2.png', '66일 인문학 대화법', '50P'),
  Product('assets/img/money.png', '현금교환권(10000원)', '100P'),
  Product('assets/img/money.png', '현금교환권(5000원)', '50P'),
];

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NormalAppbar(
        title: '쇼핑몰',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'BEST 상품',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) => _buildProductItem(context, products[index]),
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
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0), // 보라색 테두리 추가
          borderRadius: BorderRadius.circular(8.0), // 테두리를 둥글게
        ),
        padding: const EdgeInsets.all(8.0), // 테두리와 내용 사이의 여백
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(product.imagePath),
            ),
            const SizedBox(height: 8),
            Container(
              height: 40,
              child: Text(
                product.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                product.price,
                style: TextStyle(
                    color: PRIMARY_COLOR, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Widget _buildProductItem(BuildContext context, Product product) {
  //   return GestureDetector(
  //     onTap: () {
  //       _launchURL('https://growthhelper.kr/shop/?idx=9');
  //     },
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         AspectRatio(
  //           aspectRatio: 1,
  //           child: Image.asset(product.imagePath),
  //         ),
  //         const SizedBox(height: 8),
  //         Container(
  //           height: 40,
  //           child: Text(
  //             product.title,
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ),
  //         Align(
  //           alignment: Alignment.bottomLeft,
  //           child: Text(
  //             product.price,
  //             style: TextStyle(color: PRIMARY_COLOR, fontSize: 16, fontWeight: FontWeight.w500),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }



  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
