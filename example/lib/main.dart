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
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Slide this button to left or right.'),
                      SizedBox(height: 16.0),
                      HorizontalSlidableButton(
                        initialPosition: SlidableButtonPosition.start,
                        width: MediaQuery.of(context).size.width / 3,
                        buttonWidth: 60.0,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
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
                            if (position == SlidableButtonPosition.end) {
                              result = 'Button is at the right';
                            } else {
                              result = 'Button is on the left';
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Slide this button to top or bottom.'),
                      SizedBox(height: 16.0),
                      VerticalSlidableButton(
                        initialPosition: SlidableButtonPosition.start,
                        height: MediaQuery.of(context).size.height / 3,
                        buttonHeight: 60.0,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                        buttonColor: Theme.of(context).primaryColor,
                        dismissible: false,
                        label: Center(child: Text('Slide Me')),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Top'),
                              Text('Bottom'),
                            ],
                          ),
                        ),
                        onChanged: (position) {
                          setState(() {
                            if (position == SlidableButtonPosition.end) {
                              result = 'Button is at the bottom';
                            } else {
                              result = 'Button is on the top';
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Result:\n$result', textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
