import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nike_shoes/nike_shoes_store_app/nike_shoes.dart';

class MainNikeShoesStore extends StatelessWidget {
  const MainNikeShoesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NikeShoesStoreHome(),
    );
  }
}

class NikeShoesStoreHome extends StatelessWidget {
  const NikeShoesStoreHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "assets/nike_shoes_store/nike_logo.png",
                    height: 40,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: shoes.length,
                          itemBuilder: (context, i) {
                            return NikeShoesItem(shoesItem: shoes[i]);
                          }))
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                height: kToolbarHeight,
                child: Container(
                  color: Colors.white10,
                  child: const Row(
                    children: [
                      Expanded(child: Icon(Icons.home)),
                      Expanded(child: Icon(Icons.search)),
                      Expanded(child: Icon(Icons.favorite)),
                      Expanded(child: Icon(Icons.shopping_bag)),
                      Expanded(
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 13,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}

class NikeShoesItem extends StatelessWidget {
  const NikeShoesItem({super.key, required this.shoesItem});
  final NikeShoes shoesItem;

  @override
  Widget build(BuildContext context) {
    const itemHeight = 280.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        height: itemHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                  color: Color(shoesItem.color),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
            )),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
              height: itemHeight*0.7,
              child: FittedBox(child: Text(shoesItem.modelNumber.toString(),style: TextStyle(color: Colors.black.withOpacity(0.05)),)),
            ),),
            Positioned(
              top: 20,
              left: 100,
                child: Image.asset(
              shoesItem.images[0],
              height: itemHeight * 0.7,
            ),),
            const Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.favorite_border_outlined, color: Colors.grey,),
                  Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                ],
              )),

              Positioned(
                bottom: 25,
                right: 0,
                left: 0,
                child: Column(
                children: [
                  Text(shoesItem.model, style: TextStyle(color: Colors.grey,fontSize: 15 ),)
                ],
              ))

          ],
        ),
      ),
    );
  }
}
