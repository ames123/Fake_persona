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

  static Future<void> finishOrdering(String roomCode, String username,
  String action1, String action2, String action3, String action4, String action5, ) async{
    
    Map<String, String> actionMap = {
    'Czytanie': 'READ',
    'Czas wolny': 'FREE_TIME',
    'Ścieranie kurzu': 'CLEAN',
    'Oglądanie': 'TV',
    'Gotowanie': 'COOK',
    'Pisanie książki': 'WRITE',
    'Słuchanie muzyki': 'MUSIC',
    'Mycie': 'WASH',
    'Trening': 'TRAINING',
    'Sport': 'SPORT',
    'Jedzenie': 'EAT',
    'Szukanie zapasów': 'STOCK',
    'Odpoczynek': 'SLEEP',
    'Przebieranie się': 'CHANGE',
    'Dezynfekcja': 'DISINFECT',
    'Pielęgnacja roślin': 'GARDEN',
    'Kradzież': 'STEAL',
    'Badanie lekarskie': 'CHECKUP',
    'Granie na PC': 'GAME',
    'Eksperyment': 'EXPERIMENT',
    'Próba roli': 'ACT'
  };

    String action1api = actionMap[action1]!;
    String action2api = actionMap[action2]!;
    String action3api = actionMap[action3]!;
    String action4api = actionMap[action4]!;
    String action5api = actionMap[action5]!;
    final uri = Uri.parse('$baseUrl/rooms/$roomCode/action/tasks?displayName=$username&action1=$action1api&action2=$action2api&action3=$action3api&action4=$action4api&action5=$action5api');
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

  static Future<void> endHour(String roomCode, String username) async{
    final uri = Uri.parse('$baseUrl/rooms/$roomCode/action/endHour?displayName=$username');
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

  static Future<void> position(String roomCode, String username) async{
    final uri = Uri.parse('$baseUrl/rooms/$roomCode/action/position?displayName=$username');
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