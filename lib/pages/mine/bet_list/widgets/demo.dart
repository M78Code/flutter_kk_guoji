import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final GlobalKey _buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OverlayEntry Example'),
      ),
      body: Center(
        child: ElevatedButton(
          key: _buttonKey,
          onPressed: () {
            _buttonKey.currentContext?.showOverlay();
          },
          child: Text('Show Overlay'),
        ),
      ),
    );
  }
}

extension OverlayButtonExtension on BuildContext {
  void showOverlay() {
    final RenderBox renderBox = this.findRenderObject() as RenderBox;
    final buttonSize = renderBox.size;
    final buttonPosition = renderBox.localToGlobal(Offset.zero);

    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                // Remove the overlay when tapped outside the image
                overlayEntry.remove();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            left: buttonPosition.dx,
            top: buttonPosition.dy + buttonSize.height,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: buttonSize.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  "https://example.com/your_image.jpg", // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(this)?.insert(overlayEntry);
  }
}
