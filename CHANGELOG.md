## 3.0.0
* Legacy SlidableButton has been removed, use specified direction instead
* Can update initial button position using setState
* Button can be stopped at center position
* Initial button position can set to center even center point is false

## 2.0.0+1
* Update docs on VerticalSlidableButton.

## 2.0.0
* `SlidableButton` is now deprecate. Please use `Horizontal` or `VerticalSlidableButton` for specific direction usage.
* Added `autoSlide` as new optional param that can control the button to auto slide after release or not.

## 1.3.1
* Prevention multiple trigger `onChanged` when `tristate` is true.

## 1.3.0
* New state `SlidableButtonPosition.sliding` when `tristate` is set to true.

## 1.2.0
* Added new option when the animation slide start after released [PR #4](https://github.com/husainazkas/slidable_button/pull/4).

## 1.1.0
* Added new option to restart button position [PR #2](https://github.com/husainazkas/slidable_button/pull/2).

## 1.0.2
* Added `HitTestBehavior.translucent`.
* Prevention maintenance from deprecated API.

## 1.0.1+2
* Fix `label` not showing when onChanged is null.
* Add example supports for Android, iOS, Web, macOS, and Windows.

## 1.0.1+1
* Update README.

## 1.0.1
* Fix border behind the button.

## 1.0.0+1
* Update README.

## 1.0.0
* Initial release.
* Support null safety.