import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gypsybook/models/world_model.dart';
import 'package:gypsybook/providers/world.dart';
import 'package:gypsybook/screens/continent_description.dart';
import 'package:provider/provider.dart';


class ContinentPage extends StatelessWidget {
  ContinentPage();

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
        Container(
        
          child: const PageViewWidget(),height: 250,),
        //Container(width: 100,height: 250,)
      ],
    );
    // Container(
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   boxShadow: kElevationToShadow[4],
      // ),
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

  double viewportFraction = 0.9;
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
            right: 20,
            left: 20,
            top: 10 ,
            bottom: 10,
          ),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: Stack(
              children: 
                [
                  InkWell(
                    onTap: (){
                     Navigator.of(context).pushNamed(
              ContinentDescription.routeName,
              arguments: products[index].id,
            );

                    },
                    child: Container(
                     decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: kElevationToShadow[4],
                        ),
                  
                    child: Image.network(
                      products[index].imageUrl!,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                                  ),
                  ),
                Positioned(
                  left: 40,
                  top: 120,
                  child: Text(products[index].title!,  style: TextStyle(
                    
                letterSpacing: 1.3,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                height: 1.3),))
              ],
            ),
          ),
        );
      }),
      itemCount: products.length,
    );
  }
}

