import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        setState(() {});
      });
    }
    setState(() {});
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
      }
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  String _formatTime() {
    final duration =
        _stopwatch.elapsed; //+ const Duration(minutes: 59, seconds: 1);

    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    String milliseconds = (duration.inMilliseconds % 1000 ~/ 10)
        .toString()
        .padLeft(2, '0');

    if (duration.inHours > 0) {
      return "$hours:$minutes:$seconds:$milliseconds";
    } else {
      return "$minutes:$seconds:$milliseconds";
    }
  }

  @override
  void dispose() {
    if (_stopwatch.isRunning) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Stopwatch")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(),
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier',
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startStopwatch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _stopwatch.isRunning
                        ? Colors.red
                        : AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    _stopwatch.isRunning ? "Stop" : "Mulai",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: _resetStopwatch,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
