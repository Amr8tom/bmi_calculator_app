import 'package:flutter/material.dart';
import 'dart:math';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({Key? key}) : super(key: key);

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double _height = 0.0;
  double _weight = 0.0;
  String _bmiResult = "";
  String _bmiCategory = "";

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  void _calculateBMI() {
    setState(() {
      if (_height > 0 && _weight > 0) {
        double heightInMeters = _height / 100;
        double bmi = _weight / pow(heightInMeters, 2);
        _bmiResult = bmi.toStringAsFixed(2);
        _bmiCategory = _getBMICategory(bmi);
      }
    });
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return "Normal";
    } else if (bmi >= 25 && bmi <= 29.9) {
      return "Overweight";
    } else {
      return "Obesity";
    }
  }

  void _resetFields() {
    setState(() {
      _heightController.clear();
      _weightController.clear();
      _bmiResult = "";
      _bmiCategory = "";
      _height = 0;
      _weight = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[800],
        title: Text(
          'BMI Calculator',
          style: TextStyle(
            color: Colors.white,
            fontSize: isSmallScreen ? 20 : 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Height Input
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Height (cm)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.height),
              ),
              onChanged: (value) {
                setState(() {
                  _height = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),

            // Weight Input
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.line_weight),
              ),
              onChanged: (value) {
                setState(() {
                  _weight = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 30),

            // Calculate Button
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.teal[700],
                padding: EdgeInsets.symmetric(
                  vertical: isSmallScreen ? 12 : 16,
                  horizontal: isSmallScreen ? 24 : 32,
                ),
                elevation: 5,
              ),
              child: Text(
                "Calculate BMI",
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 22,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Result Display
            if (_bmiResult.isNotEmpty)
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 20 : 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Your BMI: $_bmiResult",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 24 : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Category: $_bmiCategory",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 24,
                        fontWeight: FontWeight.w600,
                        color: _getCategoryColor(_bmiCategory),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 20),

            // Reset Button
            ElevatedButton(
              onPressed: _resetFields,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.red[700],
                padding: EdgeInsets.symmetric(
                  vertical: isSmallScreen ? 12 : 16,
                  horizontal: isSmallScreen ? 24 : 32,
                ),
                elevation: 5,
              ),
              child: Text(
                "Reset",
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 22,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Underweight":
        return Colors.blue;
      case "Normal":
        return Colors.green;
      case "Overweight":
        return Colors.orange;
      case "Obesity":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
