// lib/screens/player_details_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/player_model.dart';
import 'package:intl/intl.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${player.jerseyNumber}  |  ${player.position}  |  ${player.teamPlayed}',
                    style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal
                    )
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Date of Birth: ${DateFormat('MMMM dd, yyyy').format(DateTime.parse(player.dateOfBirth))}',
                style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.normal
                )
              ),
              Text('Height: ${player.height} cm',
                style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.normal
                )
              ),
              Text('Weight: ${player.weight} kg',
                style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.normal
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}