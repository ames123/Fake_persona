import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schedule_sleuth/room.dart';
import 'package:schedule_sleuth/player.dart';

class RoomService {
  static String baseUrl = 'https://adams-parts-subscribe-italia.trycloudflare.com';

  
  static Future<Room> fetchRoom(String roomCode) async {
    final uri = Uri.parse('$baseUrl/rooms/$roomCode');
    final resp = await http.get(uri);
    Room room = Room(id: 0, roomCode: "E1", gamestate: "E", playercount: 0, dayProgression: 0, timeProgression: 0, players: []);
    if(resp.statusCode == 200){
      try {
        final data = jsonDecode(resp.body) as Map<String, dynamic>;
        room = Room.fromJson(data);
        return room;
      } catch (e) {
        print(e);
        return room;
      }
    }
    return room;
  }

  static Future<Room> joinRoom(String roomCode, String name) async {
    final uri = Uri.parse('$baseUrl/rooms/$roomCode?displayName=$name');
    final resp = await http.post(uri);
    Room room = Room(id: 0, roomCode: "E2", gamestate: "E", playercount: 0, dayProgression: 0, timeProgression: 0, players: []);
    if(resp.statusCode == 200){
      try {
        final data = jsonDecode(resp.body) as Map<String, dynamic>;
        room = Room.fromJson(data);
        return room;
      } catch (e) {
        print(e);
        return room;
      }
    }
    return room;
  }

  static Future<Room> createRoom(String name) async {
    final uri = Uri.parse('$baseUrl/rooms?displayName=$name');
    final resp = await http.post(uri);
    Room room = Room(id: 0, roomCode: "E3", gamestate: "E", playercount: 0, dayProgression: 0, timeProgression: 0, players: []);
    if(resp.statusCode == 200){
      try {
        final data = jsonDecode(resp.body) as Map<String, dynamic>;
        room = Room.fromJson(data);
        return room;
      } catch (e) {
        print(e);
        return room;
      }
    }
    return room;
  }

  static Future<String> fetchGamestate(String roomCode) async{
    final uri = Uri.parse('$baseUrl/rooms/$roomCode/gamestate');
    final resp = await http.get(uri);
    if(resp.statusCode == 200){
      try {
        final data = jsonDecode(resp.body) as String;
        return data;
      } catch (e) {
        print(e);
        return "Err";
      }
    }
    return "Err";
  }
}