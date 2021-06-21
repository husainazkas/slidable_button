import 'package:flutter/material.dart';
import 'package:slidable_button/slidable_button.dart';

void main() {
  runApp(MaterialApp(home: SlidableButtonDemo()));
}

class SlidableButtonDemo extends StatefulWidget {
  const SlidableButtonDemo({Key? key}) : super(key: key);

  @override
  _SlidableButtonDemoState createState() => _SlidableButtonDemoState();
}

class _SlidableButtonDemoState extends State<SlidableButtonDemo> {
  String result = "Let's slide!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slidable Button Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Slide this button to left or right.'),
            SizedBox(height: 16.0),
            SlidableButton(
              width: MediaQuery.of(context).size.width / 3,
              buttonWidth: 60.0,
              color: Theme.of(context).accentColor.withOpacity(0.5),
              buttonColor: Theme.of(context).primaryColor,
              dismissible: false,
              label: Center(child: Text('Slide Me')),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Left'),
                    Text('Right'),
                  ],
                ),
              ),
              onChanged: (position) {
                setState(() {
                  if (position == SlidableButtonPosition.right) {
                    result = 'Button is on the right';
                  } else {
                    result = 'Button is on the left';
                  }
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Result:\n$result', textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
