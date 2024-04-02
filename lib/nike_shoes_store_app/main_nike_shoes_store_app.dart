import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "assets/nike_shoes_store/nike_logo.png",
                    height: 40,
                  ),
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
                      Expanded(child: CircleAvatar(backgroundColor: Colors.amber,radius: 13,),),
                    ],
                  ),
                ))
          ],
        ));
  }
}
