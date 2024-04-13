import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserData {
  final String name;
  final int age;

  UserData({required this.name, required this.age});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      age: json['age'],
    );
  }
}

// Step 2: Data Model
class AppData extends ChangeNotifier {
  UserData data = UserData(name: 'hello', age: 12);

  void updateData(UserData newData) {
    data = newData;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppData()),
        // Add more providers as needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 4: Consume the data
    final appData = Provider.of<AppData>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appData.data.name,
                  style: const TextStyle(fontSize: 24),
                ),
                SizedBox(width: 10),
                Text(
                  appData.data.age.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Update data
                appData.updateData(UserData(name: 'hello2', age: 13));
              },
              child: const Text('Update Data'),
            ),
            const SizedBox(height: 20),
            // Navigate to another screen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AnotherScreen()),
                );
              },
              child: const Text('Go to Another Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Consume the data on another screen
    final appData = Provider.of<AppData>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Screen'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appData.data.name,
              style: const TextStyle(fontSize: 24),
            ),
            SizedBox(width: 10),
            Text(
              appData.data.age.toString(),
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
