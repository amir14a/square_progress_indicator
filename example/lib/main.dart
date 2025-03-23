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

  Widget _infoLeftText(String s) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text("🤩 $s", style: const TextStyle(color: Color(0xff445b79))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("SquareProgressIndicator")),
        body: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Slider(
                    value: _value,
                    onChanged: (v) => setState(() => _value = v),
                    label: _value.toStringAsFixed(2),
                  ),
                ),
                SizedBox(
                  width: 32,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("${(_value * 100).toStringAsFixed(0)}%"),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _infoLeftText("Simple usage with infinity loading:"),
                    const SquareProgressIndicator(),
                    const Divider(),
                    _infoLeftText("Simple usage with value:"),
                    SquareProgressIndicator(value: _value),
                    const Divider(),
                    _infoLeftText("Customize colors:"),
                    SquareProgressIndicator(
                      value: _value,
                      color: Colors.pink,
                      emptyStrokeColor: Colors.grey,
                    ),
                    const Divider(),
                    _infoLeftText("Also customize colors with theme:"),
                    Theme(
                      data: ThemeData(
                        progressIndicatorTheme: ProgressIndicatorThemeData(
                          color: Colors.deepOrange,
                          circularTrackColor: Colors.deepOrange.shade200,
                        ),
                      ),
                      child: SquareProgressIndicator(value: _value),
                    ),
                    const Divider(),
                    _infoLeftText("Customize sizes and border radius:"),
                    SquareProgressIndicator(
                      value: _value,
                      width: 64,
                      height: 64,
                      borderRadius: 18,
                      strokeWidth: 10,
                      emptyStrokeWidth: 4,
                      emptyStrokeColor: Colors.grey,
                    ),
                    const Divider(),
                    _infoLeftText(
                        "Customize start position and turning direction:"),
                    SquareProgressIndicator(
                      value: _value,
                      clockwise: false,
                      startPosition: StartPosition.topRight,
                    ),
                    const Divider(),
                    _infoLeftText("Customize stroke align:"),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SquareProgressIndicator(
                            value: 1,
                            strokeAlign: SquareStrokeAlign.inside,
                            child: Text(
                              'inside',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.blue),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SquareProgressIndicator(
                            value: 1,
                            strokeAlign: SquareStrokeAlign.center,
                            child: Text(
                              'center',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.blue),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SquareProgressIndicator(
                            value: 1,
                            strokeAlign: SquareStrokeAlign.outside,
                            child: Text(
                              'outside',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    _infoLeftText("And more:"),
                    SquareProgressIndicator(
                      value: _value,
                      width: 100,
                      height: 100,
                      borderRadius: 0,
                      startPosition: StartPosition.leftCenter,
                      strokeCap: StrokeCap.square,
                      clockwise: true,
                      color: Colors.purple,
                      emptyStrokeColor: Colors.purple.withAlpha(120),
                      strokeWidth: 16,
                      emptyStrokeWidth: 16,
                      strokeAlign: SquareStrokeAlign.center,
                      child: Text("${(_value * 100).toStringAsFixed(0)}%"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
