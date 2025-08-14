import 'package:flutter/material.dart';
import '../services/platform_channel_service.dart';

class ArithmeticOperationsCard extends StatefulWidget {
  const ArithmeticOperationsCard({super.key});

  @override
  State<ArithmeticOperationsCard> createState() => _ArithmeticOperationsCardState();
}

class _ArithmeticOperationsCardState extends State<ArithmeticOperationsCard> {
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  String _selectedOperation = 'add';
  Map<String, dynamic>? _result;
  bool _isCalculating = false;

  final List<Map<String, String>> _operations = [
    {'value': 'add', 'symbol': '+', 'name': 'Addition'},
    {'value': 'subtract', 'symbol': '-', 'name': 'Subtraction'},
    {'value': 'multiply', 'symbol': '×', 'name': 'Multiplication'},
    {'value': 'divide', 'symbol': '÷', 'name': 'Division'},
  ];

  @override
  void dispose() {
    _firstNumberController.dispose();
    _secondNumberController.dispose();
    super.dispose();
  }

  Future<void> _performCalculation() async {
    final firstNumber = double.tryParse(_firstNumberController.text);
    final secondNumber = double.tryParse(_secondNumberController.text);

    if (firstNumber == null || secondNumber == null) {
      setState(() {
        _result = {
          'error': 'Please enter valid numbers',
          'result': null,
        };
      });
      return;
    }

    setState(() => _isCalculating = true);

    try {
      final result = await PlatformChannelService.performArithmeticOperation(
        firstNumber,
        secondNumber,
        _selectedOperation,
      );

      setState(() {
        _result = result;
        _isCalculating = false;
      });
    } catch (e) {
      setState(() {
        _result = {
          'error': 'Calculation failed: $e',
          'result': null,
        };
        _isCalculating = false;
      });
    }
  }

  void _clearResult() {
    setState(() {
      _result = null;
      _firstNumberController.clear();
      _secondNumberController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo[50]!,
              Colors.indigo[100]!,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.indigo[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.calculate,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Native Arithmetic Operations',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[800],
                        ),
                      ),
                      Text(
                        'Calculations performed at native level',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.indigo[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Input Fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'First Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Operation Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.indigo[300]!),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedOperation,
                    underline: const SizedBox(),
                    items: _operations.map((op) {
                      return DropdownMenuItem<String>(
                        value: op['value'],
                        child: Text(
                          '${op['symbol']} ${op['name']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedOperation = value!);
                    },
                  ),
                ),
                
                const SizedBox(width: 16),
                
                Expanded(
                  child: TextField(
                    controller: _secondNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Second Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Calculate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isCalculating ? null : _performCalculation,
                icon: _isCalculating 
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.calculate),
                label: Text(_isCalculating ? 'Calculating...' : 'Calculate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Result Display
            if (_result != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.indigo[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Result:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo[700],
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: _clearResult,
                          icon: Icon(
                            Icons.clear,
                            color: Colors.indigo[400],
                            size: 20,
                          ),
                          tooltip: 'Clear',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    if (_result!['error'] != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red[600],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _result!['error'],
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      // Success Result
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_result!['expression'] != null) ...[
                                  Text(
                                    _result!['expression'],
                                    style: TextStyle(
                                      color: Colors.indigo[800],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                                Text(
                                  'Platform: ${_result!['platform'] ?? 'Native'}',
                                  style: TextStyle(
                                    color: Colors.indigo[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _result!['result'].toString(),
                              style: TextStyle(
                                color: Colors.green[800],
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: Colors.indigo[700],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Arithmetic operations are performed using MethodChannel, demonstrating how Flutter can delegate computational tasks to native code for better performance',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.indigo[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
