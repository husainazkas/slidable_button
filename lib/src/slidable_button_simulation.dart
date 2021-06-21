import 'package:flutter/physics.dart';

class SlidableSimulation extends GravitySimulation {
  SlidableSimulation(
    double acceleration,
    double distance,
    double endDistance,
    double velocity,
  ) : super(acceleration, distance, endDistance, velocity);

  @override
  double x(double time) => super.x(time).clamp(0.0, 1.0);

  @override
  bool isDone(double time) {
    final _x = x(time).abs();
    return _x <= 0.0 || _x >= 1.0;
  }
}
