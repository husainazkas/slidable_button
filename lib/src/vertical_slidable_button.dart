import 'package:flutter/material.dart';

import '../slidable_button.dart';
import 'slidable_button_clipper.dart';
import 'slidable_button_simulation.dart';

class VerticalSlidableButton extends StatefulWidget {
  /// Label of the button.
  final Widget? label;

  /// A widget that is behind the button.
  final Widget? child;

  /// Button color if it disabled.
  ///
  /// [disabledColor] is set to `Colors.grey` by default.
  final Color? disabledColor;

  /// The color of button.
  ///
  /// If null, it will be transparent.
  final Color? buttonColor;

  /// The color of background.
  ///
  /// If null, it will be transparent.
  final Color? color;

  /// Border of area slide (usually called background).
  final BoxBorder? border;

  /// Border Radius for the button and it's child.
  ///
  /// Default value is `const BorderRadius.all(const Radius.circular(60.0))`
  final BorderRadius borderRadius;

  /// The height of this widget (button and it's background).
  ///
  /// Default value is 120.0.
  final double height;

  /// Width of area slide (usually called background).
  ///
  /// Default value is 36.0.
  final double width;

  /// Width of button. If [buttonHeight] is still null and the [label] is not null, this will automatically wrapping [label].
  ///
  /// The minimum size is [height], and the maximum size is three quarters from [width].
  final double? buttonHeight;

  /// It means the effect while and after sliding.
  ///
  /// If `true`, [child] will disappear along with button sliding. Otherwise, it stay visible even the button was slide.
  final bool dismissible;

  /// Initial button position. It can on the left or right.
  final SlidableButtonPosition initialPosition;

  /// The % at which the slide gesture should be considered as completed (0 to 1)
  ///
  /// Default value is 0.5.
  final double completeSlideAt;

  /// Listen to position, is button on the left or right.
  ///
  /// You must set this argument although is null.
  final ValueChanged<SlidableButtonPosition>? onChanged;

  /// Controller for the button while sliding.
  final AnimationController? controller;

  /// Restart animation when the position is opposite to initialPosition
  ///
  /// Default value false
  final bool isRestart;

  /// If true the button's position can be left, right, or sliding. Otherwise only left or right.
  ///
  /// Default value false
  final bool tristate;

  /// Button will auto slide to nearest point after drag released if true, otherwise will not slide.
  ///
  /// Default value true
  final bool autoSlide;

  /// Creates a [SlidableButton]
  const VerticalSlidableButton({
    Key? key,
    required this.onChanged,
    this.controller,
    this.child,
    this.autoSlide = true,
    this.disabledColor,
    this.buttonColor,
    this.color,
    this.label,
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(60.0)),
    this.initialPosition = SlidableButtonPosition.start,
    this.completeSlideAt = 0.5,
    this.height = 120.0,
    this.width = 36.0,
    this.buttonHeight,
    this.dismissible = true,
    this.isRestart = false,
    this.tristate = false,
  }) : super(key: key);

  @override
  State<VerticalSlidableButton> createState() => _VerticalSlidableButtonState();
}

class _VerticalSlidableButtonState extends State<VerticalSlidableButton>
    with SingleTickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _positionedKey = GlobalKey();

  late final AnimationController _controller;
  late Animation<double> _contentAnimation;
  Offset _start = Offset.zero;
  bool _isSliding = false;

  RenderBox? get _positioned =>
      _positionedKey.currentContext!.findRenderObject() as RenderBox?;

  RenderBox? get _container =>
      _containerKey.currentContext!.findRenderObject() as RenderBox?;

  double get _buttonHeight {
    final height = widget.buttonHeight ?? double.minPositive;
    final maxHeight = widget.height * 3 / 4;
    if (height > maxHeight) return maxHeight;
    return height;
  }

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? AnimationController.unbounded(vsync: this);
    _contentAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _initialPositionController();
  }

  void _initialPositionController() {
    if (widget.initialPosition == SlidableButtonPosition.end) {
      _controller.value = 1.0;
    } else {
      _controller.value = 0.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: widget.border,
        borderRadius: widget.borderRadius,
      ),
      child: Stack(
        key: _containerKey,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: widget.borderRadius,
            ),
            child: widget.dismissible
                ? ClipRRect(
                    clipper: SlidableButtonClipper(
                      animation: _controller,
                      borderRadius: widget.borderRadius,
                    ),
                    borderRadius: widget.borderRadius,
                    child: SizedBox.expand(
                      child: FadeTransition(
                        opacity: _contentAnimation,
                        child: widget.child,
                      ),
                    ),
                  )
                : SizedBox.expand(child: widget.child),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Align(
              alignment: Alignment(0.0, (_controller.value * 2.0) - 1.0),
              child: child,
            ),
            child: Container(
              key: _positionedKey,
              height: _buttonHeight,
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                color: widget.onChanged == null
                    ? widget.disabledColor ?? Colors.grey
                    : widget.buttonColor,
              ),
              child: widget.onChanged == null
                  ? Center(child: widget.label)
                  : GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onHorizontalDragStart: _onDragStart,
                      onHorizontalDragUpdate: _onDragUpdate,
                      onHorizontalDragEnd: _onDragEnd,
                      child: Center(child: widget.label),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    final pos = _positioned!.globalToLocal(details.globalPosition);
    _start = Offset(0.0, pos.dy);
    _controller.stop(canceled: true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final pos = _container!.globalToLocal(details.globalPosition) - _start;
    final extent = _container!.size.height - _positioned!.size.height;
    _controller.value = (pos.dy.clamp(0.0, extent) / extent);

    if (widget.tristate && !_isSliding) {
      _isSliding = true;
      _onChanged(SlidableButtonPosition.sliding);
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (!widget.autoSlide) return _afterDragEnd();

    final extent = _container!.size.height - _positioned!.size.height;
    double fractionalVelocity = (details.primaryVelocity! / extent).abs();
    if (fractionalVelocity < 0.5) {
      fractionalVelocity = 0.5;
    }

    double acceleration, velocity;
    if (_controller.value >= widget.completeSlideAt) {
      acceleration = 0.5;
      velocity = fractionalVelocity;
    } else {
      acceleration = -0.5;
      velocity = -fractionalVelocity;
    }

    final simulation = SlidableSimulation(
      acceleration,
      _controller.value,
      1.0,
      velocity,
    );

    _controller.animateWith(simulation).whenComplete(_afterDragEnd);
  }

  void _afterDragEnd() {
    SlidableButtonPosition position = _controller.value <= .5
        ? SlidableButtonPosition.start
        : SlidableButtonPosition.end;

    if (widget.isRestart && widget.initialPosition != position) {
      _initialPositionController();
    }

    _isSliding = false;

    _onChanged(position);
  }

  void _onChanged(SlidableButtonPosition position) {
    if (widget.onChanged != null) {
      widget.onChanged!(position);
    }
  }
}
