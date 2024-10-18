// lib/models/player_model.dart
class Player {
  int? playerID;
  String firstName;
  String lastName;
  String dateOfBirth;
  int height;
  int weight;
  String position;
  String jerseyNumber;
  String playerImage;
  String teamPlayed;

  Player({
    this.playerID,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
    required this.position,
    required this.jerseyNumber,
    required this.playerImage,
    required this.teamPlayed,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerID: json['PlayerID'] != null ? int.tryParse(json['PlayerID'].toString()) : null,
      firstName: json['FirstName'],
      lastName: json['LastName'],
      dateOfBirth: json['DateOfBirth'],
      height: json['Height'] != null ? int.tryParse(json['Height'].toString()) ?? 0 : 0,
      weight: json['Weight'] != null ? int.tryParse(json['Weight'].toString()) ?? 0 : 0,
      position: json['Position'],
      jerseyNumber: json['JerseyNumber'],
      playerImage: json['PlayerImage'],
      teamPlayed: json['TeamPlayed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PlayerID': playerID,
      'FirstName': firstName,
      'LastName': lastName,
      'DateOfBirth': dateOfBirth,
      'Height': height,
      'Weight': weight,
      'Position': position,
      'JerseyNumber': jerseyNumber,
      'PlayerImage': playerImage,
      'TeamPlayed': teamPlayed,
    };
  }
}