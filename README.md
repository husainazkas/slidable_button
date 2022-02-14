# slidable_button
[![Pub](https://img.shields.io/pub/v/slidable_button.svg?style=flat-square)](https://pub.dartlang.org/packages/slidable_button)
[![support](https://img.shields.io/badge/platform-flutter%7Cflutter%20web-2196f3.svg?style=flat-square)](https://github.com/husainazkas/slidable_button)

A simple flutter plugin for Slidable Button.

<div style="text-align:center"><img src="https://raw.githubusercontent.com/husainazkas/slidable_button/master/screenshot/1.gif" width="300px"/> &nbsp; <img src="https://raw.githubusercontent.com/husainazkas/slidable_button/master/screenshot/2.gif" width="300px"/></div>

<div style="text-align:center"><img src="https://raw.githubusercontent.com/husainazkas/slidable_button/master/screenshot/3.gif" width="300px" /></div>

Note : This plugin is cloned and remade from [swipe_button](https://pub.dev/packages/swipe_button).

## Getting Started

### Add dependency

```yaml
dependencies:
  slidable_button: ^1.2.0
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
