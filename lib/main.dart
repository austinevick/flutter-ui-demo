import 'package:flutter/material.dart';
import 'package:listview_tap_index/ui/animated_scroll_demo.dart';
import 'package:listview_tap_index/ui/overlay_example.dart';
import 'package:listview_tap_index/widget/custom_button.dart';
import 'widget/snackbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: navigatorKey,
      home: const CountryFormField(),
    );
  }
}

class CountryFormField extends StatefulWidget {
  const CountryFormField({Key? key}) : super(key: key);

  @override
  _CountryFormFieldState createState() => _CountryFormFieldState();
}

class _CountryFormFieldState extends State<CountryFormField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: TextFormField(
            onTap: () => _createOverlay(),
            readOnly: true,
            onChanged: (value) => setState(() {}),
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintText: 'Enter name', focusedBorder: OutlineInputBorder()),
          ),
        ),
      ),
    );
  }

  void _createOverlay() {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              left: 8,
              right: 8,
              top: 200,
              bottom: 20,
              child: Material(
                elevation: 5.0,
                child: Column(
                  children: const [
                    ListTile(
                      title: Text('India'),
                    ),
                    ListTile(
                      title: Text('Australia'),
                    ),
                  ],
                ),
              ),
            ));
    overlayState!.insert(overlayEntry);
  }
}
