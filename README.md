# slidable_button

A simple flutter plugin project for Slidable Button.

Note : This plugin is cloned and remade from [swipe_button](https://pub.dev/packages/swipe_button).

## Getting Started

### Add dependency

```yaml
dependencies:
  slidable_button:
    git:
      url: git://github.com/husainazkas/slidable_button.git
```

### Simple to use

```dart
import 'package:slidable_button/slidable_button.dart';
```

```dart
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
```
