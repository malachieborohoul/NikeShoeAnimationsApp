import 'package:flutter/material.dart';
import 'package:nike_shoes/nike_shoes_store_app/main_nike_shoes_store_app.dart';
import 'package:nike_shoes/nike_shoes_store_app/nike_shoes.dart';
import 'package:nike_shoes/nike_shoes_store_app/nike_shopping_cart.dart';

class NikeShoesDetails extends StatelessWidget {
  const NikeShoesDetails({super.key, required this.shoesItem});
  final NikeShoes shoesItem;

  @override
  Widget build(BuildContext context) {
    ValueNotifier notifierButtons = ValueNotifier(false);

    final size = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierButtons.value = true;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Image.asset(
          "assets/nike_shoes_store/nike_logo.png",
          height: 50,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height * .5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: Hero(
                        tag: 'background_${shoesItem.model}',
                        child: Container(
                          color: Color(shoesItem.color),
                        ),
                      ),
                    ),
                    ShakeTransition(
                      axis: Axis.vertical,
                      child: Hero(
                        tag: 'model_${shoesItem.model}',
                        child: Material(
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              shoesItem.modelNumber.toString(),
                              style: TextStyle(
                                  fontSize: size.height * .2,
                                  color: Colors.black12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    PageView.builder(
                      itemCount: shoesItem.images.length,
                      itemBuilder: (context, i) {
                        return Container(
                          alignment: Alignment.center,
                          child: ShakeTransition(
                            child: Hero(
                              tag: 'image_${shoesItem.model}',
                              child: Image.asset(
                                shoesItem.images[i],
                                height: size.height * .3,
                                width: size.height * .3,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
          ValueListenableBuilder(
              valueListenable: notifierButtons,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: "tag_1",
                      backgroundColor: Colors.white,
                      onPressed: () {},
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.black,
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: "tag_2",
                      backgroundColor: Colors.black,
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (context, animation, _) {
                                  return NikeShoppingCart(shoesItem: shoesItem,);
                                }));
                      },
                      child: const Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                    duration: const Duration(milliseconds: 600),
                    bottom: notifierButtons.value ? 0 : -kToolbarHeight,
                    left: 0,
                    right: 0,
                    child: child!);
              })
        ],
      ),
    );
  }
}
