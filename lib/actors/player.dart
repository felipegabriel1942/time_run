import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:time_run/time_run.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<TimeRunGame> {
  SpriteSheet? _spriteSheet;
  Map<String, SpriteAnimation> _animations = {};

  Player({required super.position})
      : super(
          size: Vector2.all(64),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    _spriteSheet = await SpriteSheet(
      image: game.images.fromCache('player.png'),
      srcSize: Vector2.all(32),
    );

    _animations['idle'] = _spriteSheet!.createAnimation(
      row: 0,
      stepTime: 0.24,
      from: 0,
      to: 3,
    );

    _animations['running'] = _spriteSheet!.createAnimation(
      row: 1,
      stepTime: 0.12,
      from: 0,
      to: 6,
    );

    _animations['hit'] = _spriteSheet!.createAnimation(
      row: 4,
      stepTime: 0.24,
      from: 0,
      to: 2,
    );

    animation = _animations['idle'];
  }
}
