import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:time_run/time_run.dart';

class Player extends SpriteAnimationComponent
    with KeyboardHandler, HasGameReference<TimeRunGame> {
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 400;
  int horizontalDirection = 0;

  SpriteSheet? _spriteSheet;
  Map<String, SpriteAnimation> _animations = {};

  Player({required super.position})
      : super(
          size: Vector2.all(64),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await _getSpriteSheet().then((value) => {
          _spriteSheet = value,
          _createAnimations(),
          _setCurrentAnimation(),
        });
  }

  Future<SpriteSheet> _getSpriteSheet() async {
    return await SpriteSheet(
      image: game.images.fromCache('player.png'),
      srcSize: Vector2.all(33),
    );
  }

  void _createAnimations() {
    _animations['idle'] = _spriteSheet!.createAnimation(
      row: 0,
      stepTime: 0.08,
      from: 0,
      to: 4,
      loop: true,
    );

    _animations['running'] = _spriteSheet!.createAnimation(
      row: 1,
      stepTime: 0.08,
      from: 0,
      to: 6,
      loop: true,
    );

    _animations['hit'] = _spriteSheet!.createAnimation(
      row: 4,
      stepTime: 0.24,
      from: 0,
      to: 2,
    );
  }

  void _setCurrentAnimation() {
    if (horizontalDirection != 0) {
      animation = _animations['running'];
    } else {
      animation = _animations['idle'];
    }
  }

  @override
  bool onKeyEvent(KeyEvent keyEvent, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;

    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyA) ||
            keysPressed.contains(LogicalKeyboardKey.arrowLeft))
        ? -1
        : 0;

    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyD) ||
            keysPressed.contains(LogicalKeyboardKey.arrowRight))
        ? 1
        : 0;

    return true;
  }

  @override
  void update(double dt) {
    velocity.x = horizontalDirection * moveSpeed;

    position += velocity * dt;

    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }

    _setCurrentAnimation();

    super.update(dt);
  }
}
