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
  slidable_button: ^3.0.0+1
```

### Simple to use

Import this library on your code.

```dart
import 'package:slidable_button/slidable_button.dart';
```

Now you can make your slidable button vertically or horizontally by using one of them widget. For horizontal usage example :

```dart
    HorizontalSlidableButton(
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
          if (position == SlidableButtonPosition.end) {
            result = 'Button is on the right';
          } else {
            result = 'Button is on the left';
          }
        });
      },
    ),
```

Vertical usage example :

```dart
    VerticalSlidableButton(
      height: MediaQuery.of(context).size.height / 3,
      buttonHeight: 60.0,
      color: Theme.of(context).accentColor.withOpacity(0.5),
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
            result = 'Button is on the bottom';
          } else {
            result = 'Button is on the top';
          }
        });
      },
    ),
```

### Migration Guide

If you already use this package before v3.x.x you may need to migrate your code to `HorizontalSlidableButton` or  `VerticalSlidableButton` for specific direction usage because `SlidableButton` class has been removed start from v3.0.0.