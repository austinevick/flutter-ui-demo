import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../widget/custom_button.dart';

class OverlayExample extends StatefulWidget {
  const OverlayExample({super.key});

  @override
  State<OverlayExample> createState() => _OverlayExampleState();
}

class _OverlayExampleState extends State<OverlayExample>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  Animation<Offset>? slide;

  @override
  void initState() {
    checkInternetConnectivity();
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);
  }

  void checkInternetConnectivity() {
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        _showOverlay(context, text: 'You are offline');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  onPressed: () async {
                    _showOverlay(context, text: 'Hello');
                  },
                  color: Colors.black,
                  text: 'TAP'),
            ],
          ),
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context, {required String text}) async {
    OverlayState? overlayState = Overlay.of(context);

    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 8,
        right: 8,
        bottom: 10,
        top: MediaQuery.of(context).size.height * 0.80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            child: FadeTransition(
              opacity: animation!,
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 60,
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      );
    });
    animationController!.addListener(() {
      overlayState!.setState(() {});
    });
    // inserting overlay entry
    overlayState!.insert(overlayEntry);
    animationController!.forward();
    await Future.delayed(const Duration(seconds: 8))
        .whenComplete(() => animationController!.reverse())
        // removing overlay entry after stipulated time.
        .whenComplete(() => overlayEntry.remove());
  }
}
