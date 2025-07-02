import 'package:flutter/material.dart';

class ReturnDataScreen extends StatefulWidget {
  const ReturnDataScreen({super.key});

  @override
  State<ReturnDataScreen> createState() => _ReturnDataScreenState();
}

class _ReturnDataScreenState extends State<ReturnDataScreen> {
  String _returnedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Return Data from Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataReturnerScreen(),
                  ),
                );
                setState(() {
                  _returnedData = result ?? '';
                });
              },
              child: const Text('Go to Data Returner Screen'),
            ),
            const SizedBox(height: 20),
            Text('Returned: $_returnedData'),
          ],
        ),
      ),
    );
  }
}

class DataReturnerScreen extends StatelessWidget {
  const DataReturnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Return Data')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, 'This is returned data!');
          },
          child: const Text('Return Data'),
        ),
      ),
    );
  }
} 