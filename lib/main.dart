import 'package:flutter/material.dart';

void main() => runApp(TemperatureConverterApp());

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String _selectedConversion = 'C to F';
  String _convertedValue = '';
  List<String> _conversionHistory = [];
  final TextEditingController _controller = TextEditingController();

  void _convertTemperature() {
    double inputValue = double.tryParse(_controller.text) ?? 0;
    double result;

    if (_selectedConversion == 'F to C') {
      result = (inputValue - 32) * 5 / 9;
    } else {
      result = inputValue * 9 / 5 + 32;
    }

    setState(() {
      _convertedValue = result.toStringAsFixed(2);
      _conversionHistory.insert(
        0,
        '${_selectedConversion == 'F to C' ? 'F to C' : 'C to F'}: $inputValue is equivalent to $_convertedValue',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Celsius to Fahrenheit'),
                    value: 'C to F',
                    groupValue: _selectedConversion,
                    onChanged: (value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Fahrenheit to Celsius'),
                    value: 'F to C',
                    groupValue: _selectedConversion,
                    onChanged: (value) {
                      setState(() {
                        _selectedConversion = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
            SizedBox(height: 16),
            Text(
              'Converted Value: $_convertedValue',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_conversionHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
