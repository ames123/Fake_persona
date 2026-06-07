import 'package:schedule_sleuth/room.dart';
import 'package:schedule_sleuth/services/room_service.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlayerInvestigationData {
  final String initials;
  final Map<String, String?> savedLocations;
  final Map<String, String?> savedActions;

  PlayerInvestigationData({
    required this.initials,
    required Map<String, String?> locations,
    required Map<String, String?> actions,
  })  : savedLocations = locations,
        savedActions = actions;
}

class GameState {
  // Singleton - gwarantuje, że w całej aplikacji istnieje tylko jedna instancja tej klasy
  static final GameState _instance = GameState._internal();

  factory GameState() {
    return _instance;
  }

  GameState._internal();

  String state = '';

  // ==========================================
  // DANE LOKALNEGO GRACZA (Zapisywane w Lobby)
  // ==========================================
  String currentUsername = '';
  String currentRoomCode = '';

  // Dynamiczna lista pozostałych graczy w pokoju (pobrana z API / WebSockets)
  List<PlayerInvestigationData> activePlayers = [];

  // ==========================================
  // SYSTEM GLOBALNEGO TIMERA
  // ==========================================
  int remainingSeconds = 300; // Domyślnie 5 minut
  Timer? _gameTimer;

  // Rejestr nasłuchiwania dla bezpiecznego odświeżania UI (safeSetState)
  void Function()? onTimeChanged;

  // Funkcja uruchamiająca odliczanie
  void startTimer(BuildContext context) {
    if (_gameTimer != null)
      return; // Jeśli timer już działa, nie duplikujemy go

    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        onTimeChanged?.call(); // Powiadomienie widżetu o zmianie sekundy
      } else {
        stopTimer();
        // POPRAWKA: Zegar osiąga 0 -> Automatyczne przerzucenie na ekran zadań
        if (context.mounted) {
          context.goNamed('CurrentTaskView');
        }
      }
    });
  }

  // POPRAWKA: Wymuszony, czysty reset timera przy przejściu z zadań do śledztwa
  void forceResetTimer() {
    stopTimer();
    remainingSeconds = 300; // Powrót do pełnych 5 minut
    onTimeChanged?.call();
  }

  // Funkcja zatrzymująca odliczanie
  void stopTimer() {
    _gameTimer?.cancel();
    _gameTimer = null;
  }

  // Formatowanie sekund do formatu MM:SS (np. "05:00")
  String get formattedTime {
    final int minutes = remainingSeconds ~/ 60;
    final int seconds = remainingSeconds % 60;
    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  // ==========================================
  // METODY LOGICZNE TOKU GRY
  // ==========================================

  // Metoda do ustawiania danych z ekranu Lobby
  void joinRoom(String username, String roomCode){
    currentUsername = username;
    joinAndFetchRoomFromApi(roomCode,username);
  }

  void createRoom(String username) {
    currentUsername = username;
    createAndFetchRoomFromApi(username);
  }

  void refreshRoom(){
    refreshDataFromApi(currentRoomCode);
  }

  // Metoda do resetu i startu nowej rozgrywki
  void startNewGame(List<String> dynamicInitials) {
    final dayPeriods = ['RANO', 'POŁUDNIE', 'POPOŁUDNIE', 'WIECZÓR', 'NOC'];
    activePlayers.clear();

    for (var initials in dynamicInitials) {
      activePlayers.add(
        PlayerInvestigationData(
          initials: initials,
          locations: {for (var p in dayPeriods) p: null},
          actions: {for (var p in dayPeriods) p: null},
        ),
      );
    }
    stopTimer();
    remainingSeconds = 300;
  }

  // Metoda do pełnego czyszczenia stanu tury i pokoju
  void resetNewGame() {
    currentUsername = '';
    currentRoomCode = '';
    activePlayers.clear();
    stopTimer();
    remainingSeconds = 300;
  }

  Future<void> refreshDataFromApi(String roomCodeAdd) async {
    Room room = await RoomService.fetchRoom(roomCodeAdd);
    activePlayers.clear();
    for(var p in room.players){
      activePlayers.add(p.toPlayerData());
    }
    currentRoomCode = room.roomCode;
    state = room.gamestate;
  }

  Future<void> joinAndFetchRoomFromApi(String roomCodeAdd, String name) async {
    Room room = await RoomService.joinRoom(roomCodeAdd, name);
    for(var p in room.players){
      activePlayers.add(p.toPlayerData());
    }
    currentRoomCode = room.roomCode;
    state = room.gamestate;
  }

  Future<void> createAndFetchRoomFromApi(String name) async {
    Room room = await RoomService.createRoom(name);
    for(var p in room.players){
      activePlayers.add(p.toPlayerData());
    }
    currentRoomCode = room.roomCode;
    state = room.gamestate;
  }

  Future<void> updatePlayers() async {
    Room room = await RoomService.fetchRoom(currentRoomCode);
    for(var p in room.players){
      activePlayers.add(p.toPlayerData());
    }
    state = room.gamestate;
  }

  void setState(String gamestate) {
    state = gamestate;
  }
}
