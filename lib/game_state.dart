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

  GameState._internal() {
    // Ustawiamy początkową wartość notyfikatora czasu zgodnie ze stanem
    try {
      timeNotifier.value = formattedTime;
    } catch (_) {}
  }

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
  int remainingSeconds = 60; // Domyślnie 5 minut
  int roundSeconds = 60;
  Timer? _gameTimer;
  // Rejestr nasłuchiwania dla bezpiecznego odświeżania UI (safeSetState)
  void Function()? onTimeChanged;

  // ValueNotifier z sformatowanym czasem — łatwiejsze nasłuchiwanie w wielu widokach
  final ValueNotifier<String> timeNotifier = ValueNotifier('00:00');
// Referencja do aktualnego BuildContext widocznego ekranu
  BuildContext? _currentContext;

  void updateContext(BuildContext context) {
    _currentContext = context;
  }

  void _notifyTimeChanged() {
    final ft = formattedTime;
    try {
      timeNotifier.value = ft;
    } catch (_) {}
    onTimeChanged?.call();
  }

  // Funkcja uruchamiająca odliczanie
  void startTimer(BuildContext context) {
    if (_gameTimer != null)
      return; // Jeśli timer już działa, nie duplikujemy go

    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        _notifyTimeChanged(); // Powiadomienie widżetu o zmianie sekundy
      } else {
        stopTimer();
        _notifyTimeChanged();
        if (_currentContext != null && _currentContext!.mounted) {
          _currentContext!.goNamed('CurrentTaskView');
        }
      }
    });
  }

  // POPRAWKA: Wymuszony, czysty reset timera przy przejściu z zadań do śledztwa
  void forceResetTimer() {
    stopTimer();
    remainingSeconds = roundSeconds; // Powrót do pełnych 5 minut
    _notifyTimeChanged();
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
  void joinRoom(String username, String roomCode) {
    currentUsername = username;
    currentRoomCode = roomCode;
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
    remainingSeconds = roundSeconds;
  }

  // Metoda do pełnego czyszczenia stanu tury i pokoju
  void resetNewGame() {
    currentUsername = '';
    currentRoomCode = '';
    activePlayers.clear();
    stopTimer();
    remainingSeconds = roundSeconds;
  }

  //wygrany
  String? winnerName;
  String? winnerInitials;

  // Funkcja, którą wywołasz w momencie zakończenia gry
  void setWinner(String name, String initials) {
    winnerName = name;
    winnerInitials = initials;
  }
}
