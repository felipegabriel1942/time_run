import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:time_run/actors/player.dart';

class TimeRunGame extends FlameGame {
  late Player _player;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'player.png',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;

    initializeGame();
  }

  void initializeGame() {
    _player = Player(position: Vector2(128, canvasSize.y - 128));

    add(_player);
  }
}
