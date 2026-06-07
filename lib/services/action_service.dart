import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schedule_sleuth/game_state.dart';
import 'package:schedule_sleuth/room.dart';
import 'package:schedule_sleuth/player.dart';

class ActionService {
  static String baseUrl = 'http://localhost:2137';

  static Future<void> startGame(String roomCode) async{
    final uri = Uri.parse('$baseUrl/rooms/$roomCode/action/start');
    final resp = await http.post(uri);
    Room room = Room(id: 9999, roomCode: "Err", gamestate: "Err", playercount: 9999, dayProgression: 9999, timeProgression: 9999, players: []);
    if(resp.statusCode == 200){
      try {
        final data = jsonDecode(resp.body) as Map<String, dynamic>;
        room = Room.fromJson(data);
        GameState().setState(room.gamestate);
      } catch (e) {
        print(e);
      }
    }
  }
}