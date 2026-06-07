
import 'package:schedule_sleuth/player.dart';

class Room{
  int id;
  String roomCode;
  String gamestate;
  int playercount;
  String? winner;
  int dayProgression;
  int timeProgression;
  List<Player> players;

  Room({
    required this.id,
    required this.roomCode,
    required this.gamestate,
    required this.playercount,
    this.winner,
    required this.dayProgression,
    required this.timeProgression,
    required this.players
  });

  factory Room.fromJson(Map<String, dynamic> json){
    List<Player> players = [];
    for(var p in json['players']){
      players.add(Player.fromJson(p));
    }
    return Room(
      id: json['id'],
      roomCode: json['roomCode'], 
      gamestate: json['gamestate'], 
      playercount: json['playerCount'], 
      winner: json['winner'],
      dayProgression: json['dayProgression'], 
      timeProgression: json['timeProgression'], 
      players: players
      );
  }

  Map<String, dynamic> toJson(){
    List<Map<String, dynamic>> playersTojson = [];
    for(var p in players){
      playersTojson.add(p.toJson());
    }
    return {
      'id': id,
      'roomCode': roomCode,
      'gamestate': gamestate,
      'playercount': playercount,
      'winner': winner,
      'dayProgression': dayProgression,
      'timeProgression': timeProgression,
      'players': playersTojson
    };
  }
}