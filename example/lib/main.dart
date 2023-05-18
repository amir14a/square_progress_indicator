import 'package:flutter/material.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(primaryColor: Colors.redAccent),
      home: Scaffold(
        appBar: AppBar(title: const Text("SquareProgressIndicator example")),
        body: Column(
          children: [
            SquareProgressIndicator(
              value: _value,
              strokeWidth: 25,
              shadowWidth: 25,
              borderRadius: 12,
              startFrom: StartFrom.bottomRight,
              progressColor: Colors.blue,
            ),
            Theme(
              data: ThemeData(sliderTheme: SliderThemeData(showValueIndicator: ShowValueIndicator.always)),
              child: Slider(
                value: _value,
                onChanged: (v) => setState(() => _value = v),
                label: _value.toStringAsFixed(2),
              ),
            ),
            Divider(),
            CircularProgressIndicator(
              value: _value,
              strokeWidth: 25,
            ),
          ],
        ),
      ),
    );
  }
}
