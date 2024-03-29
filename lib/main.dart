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
  List<int> tileNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 0]; // 現在の状態

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
             Expanded(
              child: Center(
                child: TilesView(numbers: tileNumbers, isCorrect: calcCorrect(tileNumbers), onPressed: (number) => swapTile(number),),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => shuffleTiles(),
                icon: const Icon(Icons.shuffle),
                label: const Text('シャッフル'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 盤面が正解か判定
  bool calcCorrect(List<int> numbers) {
    final correctNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 0]; // 正解の状態
    for (int i = 0; i < correctNumbers.length; i++) {
      if (numbers[i] != correctNumbers[i]) {return false;}
    }
    return true;
  }

  // タップしたタイルを空白と交換
  void swapTile(int number) {
    if (canSwapTile(number)) {
      setState(() {
        final indexOfTile = tileNumbers.indexOf(number);
        final indexOfEmpty = tileNumbers.indexOf(0);
        tileNumbers[indexOfTile] = 0;
        tileNumbers[indexOfEmpty] = number;
      });
    }
  }

  bool canSwapTile(int number) {
    final indexOfTile = tileNumbers.indexOf(number);
    final indexOfEmpty = tileNumbers.indexOf(0);

    // 盤面のindex
    // 0 1 2
    // 3 4 5
    // 6 7 8
    switch (indexOfEmpty) {
      case 0: return [1, 3      ].contains(indexOfTile);
      case 1: return [0, 2, 4   ].contains(indexOfTile);
      case 2: return [1, 5      ].contains(indexOfTile);
      case 3: return [0, 4, 6   ].contains(indexOfTile);
      case 4: return [1, 3, 5, 7].contains(indexOfTile);
      case 5: return [2, 4, 8   ].contains(indexOfTile);
      case 6: return [3, 7      ].contains(indexOfTile);
      case 7: return [4, 6, 8   ].contains(indexOfTile);
      case 8: return [5, 7      ].contains(indexOfTile);
      default: return false;
    }
  }

  void shuffleTiles() {
    setState(() {tileNumbers.shuffle();});
  }
}

// タイル面
class TilesView extends StatelessWidget {
  final List<int> numbers;
  final bool isCorrect;
  final Function(int number) onPressed;

  const TilesView({
    Key? key,
    required this.numbers,
    required this.isCorrect,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: numbers.map((number) {
        if (number == 0) {return Container();}
        return TileView(number: number, color: isCorrect ? Colors.green : Colors.blue, onPressed: () => onPressed(number));
      }).toList(),
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