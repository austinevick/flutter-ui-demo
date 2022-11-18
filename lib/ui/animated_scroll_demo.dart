import 'package:flutter/material.dart';

import '../widget/custom_button.dart';

class AnimatedScrollDemo extends StatefulWidget {
  const AnimatedScrollDemo({super.key});

  @override
  State<AnimatedScrollDemo> createState() => _AnimatedScrollDemoState();
}

class _AnimatedScrollDemoState extends State<AnimatedScrollDemo> {
  final double scrolllimit = 105.0;
  final controller = ScrollController();

  bool hide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return NotificationListener(
              onNotification: (Notification n) {
                if (n is ScrollUpdateNotification) {
                  print(controller.position.pixels);
                  if (controller.position.pixels >= scrolllimit) {
                    setState(() => hide = true);
                  }
                } else if (n is ScrollEndNotification) {
                  if (controller.position.pixels <= scrolllimit) {
                    setState(() => hide = false);
                  }
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        text: 'SUBSCRIBE',
                        onPressed: () {},
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Column(
                      children: List.generate(
                          100,
                          (i) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 65,
                                  color: Colors.red,
                                ),
                              )),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        bottomSheet: AnimatedContainer(
          height: hide ? 80 : 0,
          duration: const Duration(milliseconds: 500),
          child: BottomSheet(
            backgroundColor: Colors.transparent,
            onClosing: () {},
            builder: (ctx) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'SUBSCRIBE',
                onPressed: () {},
                color: Colors.black,
              ),
            ),
          ),
        ));
  }
}
