// lib/screens/add_player_screen.dart
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../services/player_service.dart';

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({super.key});

  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  final PlayerService playerService = PlayerService();

  late String firstName;
  late String lastName;
  late String dateOfBirth;
  late int height;
  late int weight;
  late String position;
  late String jerseyNumber;
  late String teamPlayed;
  String? imagePath;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      String? base64Image;
      if (imagePath != null) {
        final bytes = File(imagePath!).readAsBytesSync();
        base64Image = base64Encode(bytes);
      }

      await playerService.addPlayer(
        firstName,
        lastName,
        dateOfBirth,
        height,
        weight,
        position,
        jerseyNumber,
        base64Image ?? '', // Pass the base64 image string
        teamPlayed,
      );
      Navigator.pop(context); // Return to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Player')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) => value!.isEmpty ? 'Enter first name' : null,
                  onChanged: (value) => firstName = value,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (value) => value!.isEmpty ? 'Enter last name' : null,
                  onChanged: (value) => lastName = value,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                  validator: (value) => value!.isEmpty ? 'Enter date of birth' : null,
                  onChanged: (value) => dateOfBirth = value,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Height (in cm)'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter height' : null,
                  onChanged: (value) => height = int.parse(value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Weight (in kg)'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter weight' : null,
                  onChanged: (value) => weight = int.parse(value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Position'),
                  validator: (value) => value!.isEmpty ? 'Enter position' : null,
                  onChanged: (value) => position = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Jersey Number'),
                  validator: (value) => value!.isEmpty ? 'Enter jersey number' : null,
                  onChanged: (value) => jerseyNumber = value,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Team Played'),
                  validator: (value) => value!.isEmpty ? 'Enter team played' : null,
                  onChanged: (value) => teamPlayed = value,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                    );
                    if (result != null) {
                      setState(() {
                        imagePath = result.files.single.path;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      imagePath != null ? imagePath!.split('/').last : 'Select an image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // Add some spacing
                if (imagePath == null)
                  Text(
                    'Please select an image',
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Add Player'),
                  ),
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}