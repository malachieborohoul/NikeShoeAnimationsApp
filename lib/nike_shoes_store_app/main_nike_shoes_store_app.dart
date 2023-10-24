import 'package:flutter/material.dart';
import 'package:nike_shoes/nike_shoes_store_app/nike_shoes.dart';
import 'package:nike_shoes/nike_shoes_store_app/nike_shoes_details.dart';

class MainNikeShoesStore extends StatelessWidget {
  const MainNikeShoesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NikeShoesStore(),
    );
  }
}

ValueNotifier notifierBottomBar = ValueNotifier(false);

class NikeShoesStore extends StatelessWidget {
  const NikeShoesStore({super.key});

  void showDetails(BuildContext context, NikeShoes shoesItem) async {
    notifierBottomBar.value = true;
    await Navigator.push(context,
        PageRouteBuilder(pageBuilder: (context, animation, _) {
      return NikeShoesDetails(shoesItem: shoesItem);
    }));

    notifierBottomBar.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    "assets/nike_shoes_store/nike_logo.png",
                    height: 50,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: shoes.length,
                        itemBuilder: (context, i) {
                          return NikeShoesItem(
                            shoesItem: shoes[i],
                            onTap: () {
                              showDetails(context, shoes[i]);
                            },
                          );
                        }),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: notifierBottomBar,
                child: Container(
                  color: Colors.white.withOpacity(0.2),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Icon(Icons.home),
                      ),
                      Expanded(
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                        child: Icon(Icons.favorite),
                      ),
                      Expanded(
                        child: Icon(Icons.shopping_cart),
                      ),
                      Expanded(
                        child: CircleAvatar(
                          radius: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                builder: (context, value, child) {
                  return AnimatedPositioned(
                      duration: const Duration(milliseconds: 600),
                      bottom: 0,
                      right: 0,
                      left: 0,
                      height: notifierBottomBar.value
                          ? -kToolbarHeight
                          : kToolbarHeight,
                      child: child!);
                })
          ],
        ),
      ),
    );
  }
}

class NikeShoesItem extends StatelessWidget {
  const NikeShoesItem(
      {super.key, required this.shoesItem, required this.onTap});
  final NikeShoes shoesItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const itemHeight = 290.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
            height: itemHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: 'background_${shoesItem.model}',
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(shoesItem.color),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                ),
                Hero(
                  tag: 'model_${shoesItem.model}',
                  child: Material(
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: itemHeight * .6,
                        child: FittedBox(
                          child: Text(
                            shoesItem.modelNumber.toString(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.05)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: 'image_${shoesItem.model}',
                      child: Image.asset(
                        shoesItem.images.first,
                        height: itemHeight * .6,
                        width: itemHeight * .6,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.black26,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black26,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class ShakeTransition extends StatelessWidget {
  const ShakeTransition(
      {super.key,
      required this.child,
      this.duration = const Duration(milliseconds: 1200),
      this.offset = 120.0,
      this.axis = Axis.horizontal});
  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: duration,
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(value * offset, 0)
              : Offset(0, value * offset),
          child: child,
        );
      },
      child: child,
    );
  }
}
