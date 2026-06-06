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
  // POPRAWKA: Jawna inicjalizacja statycznej instancji na starcie aplikacji
  static final GameState _instance = GameState._internal();

  // Konstruktor fabryczny zawsze zwraca tę samą, poprawnie zainicjalizowaną instancję
  factory GameState() {
    return _instance;
  }

  GameState._internal();

  // Dynamiczna lista graczy
  List<PlayerInvestigationData> activePlayers = [];

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
    for (var player in activePlayers) {
      player.savedLocations.updateAll((key, value) => null);
      player.savedActions.updateAll((key, value) => null);
    }
  }
}
