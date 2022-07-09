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
    return const Scaffold();
  }
}