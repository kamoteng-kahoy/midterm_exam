// lib/screens/player_details_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/player_model.dart';

class PlayerDetailsScreen extends StatelessWidget {
  final Player player;

  const PlayerDetailsScreen({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${player.firstName} ${player.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              player.playerImage.isNotEmpty
                  ? CircleAvatar(
                      radius: 150,
                      backgroundImage: MemoryImage(base64Decode(player.playerImage)),
                    )
                  : const CircleAvatar(
                      radius: 150,
                      child: Icon(Icons.person, size: 150),
                    ),
              const SizedBox(height: 20),
              Text('${player.firstName} ${player.lastName}', 
                style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold
                  )
              ),
              Text('First Name: ${player.firstName}'),
              Text('Last Name: ${player.lastName}'),
              Text('Date of Birth: ${player.dateOfBirth}'),
              Text('Height: ${player.height}'),
              Text('Weight: ${player.weight}'),
              Text('Position: ${player.position}'),
              Text('Jersey Number: ${player.jerseyNumber}'),
              Text('Team Played: ${player.teamPlayed}'),
              
            ],
          ),
        ),
      ),
    );
  }
}