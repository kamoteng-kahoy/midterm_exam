// lib/screens/home_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:midterm_exam/screens/add_player_screen.dart';
import 'package:midterm_exam/screens/player_details_screen.dart';
import '../services/player_service.dart';
import '../models/player_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PlayerService playerService;
  late Future<List<Player>> players;

  @override
  void initState() {
    super.initState();
    playerService = PlayerService();
    players = playerService.getAllPlayers();
  }

  Future<void> fetchPlayers() async {
    setState(() {
      players = playerService.getAllPlayers();
    });
  }

  Future<void> deletePlayer(int playerID) async {
    try {
      await playerService.deletePlayer(playerID);
      await fetchPlayers();
    } catch (e) {
      print('Failed to delete player: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NBA Players'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPlayerScreen()),
              ).then((_) => fetchPlayers()); // Refresh list after adding a new player
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Player>>(
        future: players,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No players found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final player = snapshot.data![index];
                return ListTile(
                  leading: player.playerImage.isNotEmpty
                      ? Image.memory(base64Decode(player.playerImage), errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error);
                        })
                      : Icon(Icons.person),
                  title: Text('${player.firstName} ${player.lastName}'),
                  subtitle: Text('Position: ${player.position}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deletePlayer(player.playerID!),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerDetailsScreen(player: player),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}