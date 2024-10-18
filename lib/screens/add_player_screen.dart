// lib/screens/add_player_screen.dart
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

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      await playerService.addPlayer(
        firstName,
        lastName,
        dateOfBirth,
        height,
        weight,
        position,
        jerseyNumber,
        '', // Add base64 player image if needed
        teamPlayed,
      );
      Navigator.pop(context); // Return to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Player')),
      body: Padding(
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) => value!.isEmpty ? 'Enter last name' : null,
                onChanged: (value) => lastName = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                validator: (value) => value!.isEmpty ? 'Enter date of birth' : null,
                onChanged: (value) => dateOfBirth = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Height (in cm)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter height' : null,
                onChanged: (value) => height = int.parse(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weight (in kg)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter weight' : null,
                onChanged: (value) => weight = int.parse(value),
              ),
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'Team Played'),
                validator: (value) => value!.isEmpty ? 'Enter team played' : null,
                onChanged: (value) => teamPlayed = value,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Add Player'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
