// lib/screens/update_player_screen.dart
import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../services/player_service.dart';

class UpdatePlayerScreen extends StatefulWidget {
  final Player player;

  const UpdatePlayerScreen({super.key, required this.player}); // Using named parameters

  @override
  _UpdatePlayerScreenState createState() => _UpdatePlayerScreenState();
}

class _UpdatePlayerScreenState extends State<UpdatePlayerScreen> {
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

  @override
  void initState() {
    super.initState();
    // Initialize fields with current player data
    firstName = widget.player.firstName;
    lastName = widget.player.lastName;
    dateOfBirth = widget.player.dateOfBirth;
    height = widget.player.height;
    weight = widget.player.weight;
    position = widget.player.position;
    jerseyNumber = widget.player.jerseyNumber;
    teamPlayed = widget.player.teamPlayed;
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      // Call the player service to update player
      await playerService.updatePlayer(
        widget.player.playerID!, // Ensure playerID is not null
        firstName,
        lastName,
        dateOfBirth,
        height,
        weight,
        position,
        jerseyNumber,
        '', // Provide a new player image if needed
        teamPlayed,
      );

      Navigator.pop(context); // Return to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'First Name'),
                initialValue: firstName,
                validator: (value) => value!.isEmpty ? 'Enter first name' : null,
                onChanged: (value) => firstName = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                initialValue: lastName,
                validator: (value) => value!.isEmpty ? 'Enter last name' : null,
                onChanged: (value) => lastName = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                initialValue: dateOfBirth,
                validator: (value) => value!.isEmpty ? 'Enter date of birth' : null,
                onChanged: (value) => dateOfBirth = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Height (in cm)'),
                keyboardType: TextInputType.number,
                initialValue: height.toString(),
                validator: (value) => value!.isEmpty ? 'Enter height' : null,
                onChanged: (value) => height = int.parse(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weight (in kg)'),
                keyboardType: TextInputType.number,
                initialValue: weight.toString(),
                validator: (value) => value!.isEmpty ? 'Enter weight' : null,
                onChanged: (value) => weight = int.parse(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Position'),
                initialValue: position,
                validator: (value) => value!.isEmpty ? 'Enter position' : null,
                onChanged: (value) => position = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Jersey Number'),
                initialValue: jerseyNumber,
                validator: (value) => value!.isEmpty ? 'Enter jersey number' : null,
                onChanged: (value) => jerseyNumber = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Team Played'),
                initialValue: teamPlayed,
                validator: (value) => value!.isEmpty ? 'Enter team played' : null,
                onChanged: (value) => teamPlayed = value,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Update Player'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
