import 'package:flutter/material.dart';

void main() {
  runApp(const SlidingPuzzle());
}

class SlidingPuzzle extends StatelessWidget {
  const SlidingPuzzle({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 縦方向で中央寄せ
          children: [
            const Text(
              'スライドパズル',
              style: TextStyle(fontSize: 32),
            ),
            // 縦方向で余白を作る
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => showPuzzlePage(context), child: const Text('スタート')),
          ],
        ),
      ),
    );
  }
}

// パズルページへ遷移
void showPuzzlePage(BuildContext context) {
  Navigator.push(context,
  MaterialPageRoute(builder: (context) => const PuzzlePage()),
  );
}

// パズルページ
class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('スライドパズル'),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.play_arrow)),
          // 保存したタイルの状態を読み込むボタン
          IconButton(onPressed: () => {}, icon: const Icon(Icons.save)),
          // 現在のタイルの状態を保存するボタン
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: TilesView(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => {},
                icon: const Icon(Icons.shuffle),
                label: const Text('シャッフル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// タイル面
class TilesView extends StatelessWidget {
  const TilesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: [
        TileView(number: 1, color: Colors.blue, onPressed: () => {}),
        TileView(number: 2, color: Colors.blue, onPressed: () => {}),
        TileView(number: 3, color: Colors.blue, onPressed: () => {}),
        TileView(number: 4, color: Colors.blue, onPressed: () => {}),
        TileView(number: 5, color: Colors.blue, onPressed: () => {}),
        TileView(number: 6, color: Colors.blue, onPressed: () => {}),
        TileView(number: 7, color: Colors.blue, onPressed: () => {}),
        TileView(number: 8, color: Colors.blue, onPressed: () => {}),
        Container(),
      ],
    );
  }
}

// タイル
class TileView extends StatelessWidget {
  final int number;
  final Color color;
  final void Function() onPressed;

  const TileView({
    Key? key,
    required this.number,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        textStyle: const TextStyle(fontSize: 32),
      ),
      child: Center(
        child: Text(number.toString()),
      ),
    );
  }
}