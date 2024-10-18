// lib/services/player_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/player_model.dart';

class PlayerService {
  final String baseUrl = 'http://jymssit.mooo.com/api/basketball_players'; // Adjust if using emulator or real device

  Future<List<Player>> fetchPlayers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Player> players = body.map((dynamic item) => Player.fromJson(item)).toList();
        return players;
      } else {
        throw Exception('Failed to load players');
      }
    } catch (e) {
      print('Error fetching players: $e');
      rethrow;
    }
  }

  Future<List<Player>> getAllPlayers() async {
    return await fetchPlayers();
  }

  Future<void> addPlayer(String firstName, String lastName, String dateOfBirth, int height, int weight, String position, String jerseyNumber, String playerImage, String teamPlayed) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'FirstName': firstName,
        'LastName': lastName,
        'DateOfBirth': dateOfBirth,
        'Height': height,
        'Weight': weight,
        'Position': position,
        'JerseyNumber': jerseyNumber,
        'PlayerImage': playerImage,
        'TeamPlayed': teamPlayed,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add player');
    }
  }

  Future<void> updatePlayer(int playerId, String firstName, String lastName, String dateOfBirth, int height, int weight, String position, String jerseyNumber, String playerImage, String teamPlayed) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$playerId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'FirstName': firstName,
        'LastName': lastName,
        'DateOfBirth': dateOfBirth,
        'Height': height,
        'Weight': weight,
        'Position': position,
        'JerseyNumber': jerseyNumber,
        'PlayerImage': playerImage,
        'TeamPlayed': teamPlayed,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update player');
    }
  }

  Future<void> deletePlayer(int playerId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$playerId'));

    if (response.statusCode != 200) {
      print('Failed to delete player: ${response.statusCode} ${response.body}');
      throw Exception('Failed to delete player');
    } else {
      print('Player deleted successfully: ${response.body}');
    }
  }
}