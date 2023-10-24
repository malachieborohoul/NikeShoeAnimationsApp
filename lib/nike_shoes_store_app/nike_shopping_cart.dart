import 'package:flutter/material.dart';
import 'package:nike_shoes/nike_shoes_store_app/nike_shoes.dart';

class NikeShoppingCart extends StatefulWidget {
  const NikeShoppingCart({super.key, required this.shoesItem});

  final NikeShoes shoesItem;

  @override
  State<NikeShoppingCart> createState() => _NikeShoppingCartState();
}

const buttonWidth = 170.0;
const buttonHeight = 60.0;
const buttonCircularWidth = 60.0;
const imageResize = 30.0;

class _NikeShoppingCartState extends State<NikeShoppingCart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animationResize;
  late Animation _animationPushIn;
  late Animation _animationPushOut;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));

    _animationResize = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.2,
        ),
      ),
    );

    _animationPushIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.3,
          0.6,
        ),
      ),
    );

    _animationPushOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.65,
          0.8,
        ),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return Stack(
              children: [
                Positioned.fill(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.black26,
                  ),
                )),
                if (_animationPushIn.value != 1)
                  Positioned(
                      top: size.height * .4 +
                          _animationPushIn.value * size.height * .5,
                      left: size.width / 2 -
                          (size.width * _animationResize.value)
                                  .clamp(buttonCircularWidth, size.width) /
                              2,
                      height: (size.height * .6 * _animationResize.value)
                          .clamp(buttonCircularWidth, size.height * .6),
                      width: (size.width * _animationResize.value)
                          .clamp(buttonCircularWidth, size.width),
                      child: TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 600),
                          tween: Tween(begin: 1.0, end: 0.0),
                          child: Container(
                            // width: (size.width * _animationResize.value)
                            //     .clamp(buttonCircularWidth, size.width),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(30),
                                  topRight: const Radius.circular(30),
                                  bottomLeft: _animationResize.value == 1
                                      ? Radius.zero
                                      : const Radius.circular(30),
                                  bottomRight: _animationResize.value == 1
                                      ? Radius.zero
                                      : const Radius.circular(30),
                                ),
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: _animationResize.value == 1
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  widget.shoesItem.images.first,
                                  height: (size.height *
                                          .2 *
                                          _animationResize.value)
                                      .clamp(imageResize, size.height * .2),
                                ),
                                if (_animationResize.value == 1) ...[
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: [Text(widget.shoesItem.model)],
                                  )
                                ]
                              ],
                            ),
                          ),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, value * size.height * .6),
                              child: child,
                            );
                          })),
                Positioned(
                    bottom: 20.0 - _animationPushOut.value * 100,
                    left: size.width / 2 -
                        (buttonWidth * _animationResize.value)
                                .clamp(buttonCircularWidth, buttonWidth) /
                            2,
                    child: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 600),
                        tween: Tween(begin: 1.0, end: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            _controller.forward();
                          },
                          child: Container(
                            width: (buttonWidth * _animationResize.value)
                                .clamp(buttonCircularWidth, buttonWidth),
                            height: buttonHeight,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                if (_animationResize.value == 1) ...[
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "ADD TO CART",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]
                              ],
                            ),
                          ),
                        ),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, value * size.height * .6),
                            child: child,
                          );
                        }))
              ],
            );
          }),
    );
  }
}
