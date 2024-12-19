import 'package:circular_progress_indicator/circular_progress_gradient.dart';
import 'package:circular_progress_indicator/progress_text.dart';

import 'package:flutter/material.dart';

/// Flutter code sample for [CircularProgressIndicator].

void main() => runApp(const ProgressIndicatorApp());

class ProgressIndicatorApp extends StatelessWidget {
  const ProgressIndicatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const ProgressIndicatorExample(),
    );
  }
}

class ProgressIndicatorExample extends StatefulWidget {
  const ProgressIndicatorExample({super.key});

  @override
  State<ProgressIndicatorExample> createState() =>
      _ProgressIndicatorExampleState();
}

class _ProgressIndicatorExampleState extends State<ProgressIndicatorExample>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
      value: 0.8,
    )..addListener(() {
        setState(() {});
      });
    controller.animateTo(0.8);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Circular progress indicator',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularProgressGradient(progress: 270.0/300, color: Color(0xFF9A6E00),
                  overlayWidget: ProgressText(actual: "270", ideal: "(300)", unit: "mg"),),
                CircularProgressGradient(progress: 750.0/300, color: Color(0xFFBC0C7E),
                  overlayWidget: ProgressText(actual: "750", ideal: "(300)", unit: "mg"),),
                CircularProgressGradient(progress: 400.0/150, color: Color(0xFF8B15FF),
                  overlayWidget: ProgressText(actual: "400", ideal: "(150)", unit: "mg"),),
                CircularProgressGradient(progress: 130.0/100, color: Color(0xFFFE5F5F),
                  overlayWidget: ProgressText(actual: "130", ideal: "(100)", unit: "mg"),),
              ],
            )
          ],
        ),
      ),
    );
  }
}



