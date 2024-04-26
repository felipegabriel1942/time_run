import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_run/time_run.dart';

void main() {
  runApp(
    const GameWidget<TimeRunGame>.controlled(
      gameFactory: TimeRunGame.new,
    ),
  );
}
