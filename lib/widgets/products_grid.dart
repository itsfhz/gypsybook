import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gypsybook/models/world_model.dart';
import 'package:gypsybook/providers/world.dart';
import 'package:gypsybook/vacation_bean.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  ProductsGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Find your \nnext vacation",
            style: TextStyle(
                letterSpacing: 1.3,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                height: 1.3),
          ),
        ),
        Expanded(child: PageViewWidget())
      ],
    );
    // Container(
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     boxShadow: kElevationToShadow[4],
    //   ),
    //   child:

    //   GridView.builder(
    //     scrollDirection: Axis.horizontal,
    //     padding: const EdgeInsets.all(15.0),
    //     itemCount: products.length,
    // itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
    //   value: products[i],
    //       child: ProductItem(
    //           ),
    //     ),
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 4,
    //       childAspectRatio: 1 / 1,
    //       crossAxisSpacing: 10,
    //       mainAxisSpacing: 10,
    //     ),
    //   ),
    // );
  }
}

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  //List<VacationBean> _list = List<VacationBean>.generate();

  PageController? pageController;

  double viewportFraction = 0.8;
  double? pageOffset = 0;

  @override
  void initState() {
    pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController!.page;
            });
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Worlds>(context);
    final products = productsData.items;
    World ourWorld = World();
    return PageView.builder(
      controller: pageController,
      itemBuilder: ((context, index) {
        double scale = max(viewportFraction,
            (1 - (pageOffset! - index).abs()) + viewportFraction);

        double angle = (pageOffset! - index).abs();

        if (angle > 0.5) {
          angle = 1 - angle;
        }

        return Container(
          padding: EdgeInsets.only(
            right: 10,
            left: 20,
            top: 100 - scale * 25,
            bottom: 400,
          ),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: Material(
              elevation: 2,
              child: Stack(
                children: [
                  Image.network(
                    products[index].imageUrl!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  AnimatedOpacity(
                    opacity: angle == 0 ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Positioned(
                        bottom: 60,
                        left: 20,
                        child: Text(products[index].title!)),
                  )
                ],
              ),
            ),
          ),
        );
      }),
      itemCount: products.length,
    );
  }
}
