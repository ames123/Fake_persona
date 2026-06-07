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

  // ==========================================
  // DANE LOKALNEGO GRACZA (Zapisywane w Lobby)
  // ==========================================
  String currentUsername = '';
  String currentRoomCode = '';

  // Dynamiczna lista pozostałych graczy w pokoju (pobrana z API / WebSockets)
  List<PlayerInvestigationData> activePlayers = [];

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
  }

  void resetNewGame() {
    currentUsername = '';
    currentRoomCode = '';
    activePlayers.clear();
  }
}
