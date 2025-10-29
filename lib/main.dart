import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const ColorChangerApp());
}

class ColorChangerApp extends StatelessWidget {
  const ColorChangerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Changer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ColorChangerScreen(),
    );
  }
}

class ColorChangerScreen extends StatefulWidget {
  const ColorChangerScreen({super.key});

  @override
  State<ColorChangerScreen> createState() => _ColorChangerScreenState();
}

class _ColorChangerScreenState extends State<ColorChangerScreen> {
  // Current color values
  int _red = 255;
  int _green = 255;
  int _blue = 255;
  
  // Gradient direction states
  final List<GradientDirection> _directions = [
    GradientDirection.vertical,
    GradientDirection.horizontal,
    GradientDirection.leftRight,
    GradientDirection.rightLeft,
  ];
  
  int _currentDirectionIndex = 0;
  
  // Random number generator
  final Random _random = Random();

  void _changeColor() {
    setState(() {
      _red = _random.nextInt(256); // 0-255
      _green = _random.nextInt(256);
      _blue = _random.nextInt(256);
    });
  }

  void _changeDirection() {
    setState(() {
      _currentDirectionIndex = (_currentDirectionIndex + 1) % _directions.length;
    });
  }

  Color get _currentColor => Color.fromRGBO(_red, _green, _blue, 1.0);
  
  Color get _complementaryColor {
    // Create a complementary color for the gradient
    return Color.fromRGBO(255 - _red, 255 - _green, 255 - _blue, 1.0);
  }

  List<Color> get _gradientColors => [_currentColor, _complementaryColor];

  AlignmentGeometry get _beginAlignment {
    switch (_directions[_currentDirectionIndex]) {
      case GradientDirection.vertical:
        return Alignment.topCenter;
      case GradientDirection.horizontal:
        return Alignment.centerLeft;
      case GradientDirection.leftRight:
        return Alignment.topLeft;
      case GradientDirection.rightLeft:
        return Alignment.topRight;
    }
  }

  AlignmentGeometry get _endAlignment {
    switch (_directions[_currentDirectionIndex]) {
      case GradientDirection.vertical:
        return Alignment.bottomCenter;
      case GradientDirection.horizontal:
        return Alignment.centerRight;
      case GradientDirection.leftRight:
        return Alignment.bottomRight;
      case GradientDirection.rightLeft:
        return Alignment.bottomLeft;
    }
  }

  String get _currentDirectionText {
    switch (_directions[_currentDirectionIndex]) {
      case GradientDirection.vertical:
        return "Vertical";
      case GradientDirection.horizontal:
        return "Horizontal";
      case GradientDirection.leftRight:
        return "Left-Right";
      case GradientDirection.rightLeft:
        return "Right-Left";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: _beginAlignment,
            end: _endAlignment,
            colors: _gradientColors,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // RGB Values Display
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'RGB Values',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Red: $_red',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red[100],
                      ),
                    ),
                    Text(
                      'Green: $_green',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green[100],
                      ),
                    ),
                    Text(
                      'Blue: $_blue',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue[100],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Current Direction Display
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Direction: $_currentDirectionText',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _changeColor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Change Color',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  
                  ElevatedButton(
                    onPressed: _changeDirection,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Change Direction',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum GradientDirection {
  vertical,
  horizontal,
  leftRight,
  rightLeft,
}