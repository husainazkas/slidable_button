import 'package:flutter/material.dart';

import 'enum/slidable_button_position.dart';
import 'slidable_button_clipper.dart';
import 'slidable_button_simulation.dart';

class SlidableButton extends StatefulWidget {
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
  /// Default value is 36.0.
  final double height;

  /// Width of area slide (usually called background).
  ///
  /// Default value is 120.0.
  final double width;

  /// Width of button. If [buttonWidth] is still null and the [label] is not null, this will automatically wrapping [label].
  ///
  /// The minimum size is [height], and the maximum size is three quarters from [width].
  final double? buttonWidth;

  /// It means the effect while and after sliding.
  ///
  /// If `true`, [child] will disappear along with button sliding. Otherwise, it stay visible even the button was slide.
  final bool dismissible;

  /// Initial button position. It can on the left or right.
  final SlidableButtonPosition initialPosition;

  /// Listen to position, is button on the left or right.
  ///
  /// You must set this argument although is null.
  final ValueChanged<SlidableButtonPosition>? onChanged;

  /// Controller for the button while sliding.
  final AnimationController? controller;

  /// Creates a [SlidableButton]
  const SlidableButton({
    Key? key,
    required this.onChanged,
    this.controller,
    this.child,
    this.disabledColor,
    this.buttonColor,
    this.color,
    this.label,
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(60.0)),
    this.initialPosition = SlidableButtonPosition.left,
    this.height = 36.0,
    this.width = 120.0,
    this.buttonWidth,
    this.dismissible = true,
  }) : super(key: key);

  @override
  _SlidableButtonState createState() => _SlidableButtonState();
}

class _SlidableButtonState extends State<SlidableButton>
    with SingleTickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _positionedKey = GlobalKey();

  late final AnimationController _controller;
  late Animation<double> _contentAnimation;
  Offset _start = Offset.zero;

  RenderBox? get _positioned =>
      _positionedKey.currentContext!.findRenderObject() as RenderBox?;

  RenderBox? get _container =>
      _containerKey.currentContext!.findRenderObject() as RenderBox?;

  double get _buttonWidth {
    if ((widget.buttonWidth ?? double.minPositive) > widget.width * 3 / 4) {
      return widget.width * 3 / 4;
    }
    if (widget.buttonWidth != null) return widget.buttonWidth!;
    return double.minPositive;
  }

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? AnimationController.unbounded(vsync: this);
    _contentAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    if (widget.initialPosition == SlidableButtonPosition.right) {
      _controller.value = 1.0;
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
              alignment: Alignment((_controller.value * 2.0) - 1.0, 0.0),
              child: child,
            ),
            child: Container(
              key: _positionedKey,
              constraints: BoxConstraints(
                minWidth: widget.height,
                maxWidth: widget.width * 3 / 4,
              ),
              width: _buttonWidth,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                color: widget.onChanged == null
                    ? widget.disabledColor ?? Colors.grey
                    : widget.buttonColor,
              ),
              child: widget.onChanged == null
                  ? Center(child: widget.label)
                  : GestureDetector(
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
    _start = Offset(pos.dx, 0.0);
    _controller.stop(canceled: true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final pos = _container!.globalToLocal(details.globalPosition) - _start;
    final extent = _container!.size.width - _positioned!.size.width;
    _controller.value = (pos.dx.clamp(0.0, extent) / extent);
  }

  void _onDragEnd(DragEndDetails details) {
    final extent = _container!.size.width - _positioned!.size.width;
    var fractionalVelocity = (details.primaryVelocity! / extent).abs();
    if (fractionalVelocity < 0.5) {
      fractionalVelocity = 0.5;
    }
    SlidableButtonPosition result;
    double acceleration, velocity;
    if (_controller.value >= 0.5) {
      acceleration = 0.5;
      velocity = fractionalVelocity;
      result = SlidableButtonPosition.right;
    } else {
      acceleration = -0.5;
      velocity = -fractionalVelocity;
      result = SlidableButtonPosition.left;
    }
    final simulation = SlidableSimulation(
      acceleration,
      _controller.value,
      1.0,
      velocity,
    );
    _controller.animateWith(simulation).whenComplete(() {
      if (widget.onChanged != null) {
        widget.onChanged!(result);
      }
    });
  }
}
