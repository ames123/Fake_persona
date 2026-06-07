import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/player_note_card/player_note_card_widget.dart';
import '/index.dart';
import '/game_state.dart';
import 'package:flutter/material.dart';
import 'player_notes_model.dart';
export 'player_notes_model.dart';

class PlayerNotesWidget extends StatefulWidget {
  const PlayerNotesWidget({super.key});

  static String routeName = 'PlayerNotes';
  static String routePath = '/playerNotes';

  @override
  State<PlayerNotesWidget> createState() => _PlayerNotesWidgetState();
}

class _PlayerNotesWidgetState extends State<PlayerNotesWidget> {
  late PlayerNotesModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _dayPeriods = [
    'RANO',
    'POŁUDNIE',
    'POPOŁUDNIE',
    'WIECZÓR',
    'NOC'
  ];
  final GameState _gameState = GameState();

  // Przechowujemy indeks wybranego gracza zamiast sztywnego stringa
  int _activePlayerIndex = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlayerNotesModel());

    // TEST/ZABEZPIECZENIE: Jeśli lista jest pusta, symulujemy start gry dla 3 mobilnych graczy
    if (_gameState.activePlayers.isEmpty) {
      _gameState.startNewGame(['KS', 'JS', 'AZ']);
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    // Pobieramy dane aktualnie przeglądanego gracza
    if (_gameState.activePlayers.isEmpty) return const SizedBox();
    final currentPlayer = _gameState.activePlayers[_activePlayerIndex];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nagłówek (Bez zmian)
            Container(
              decoration: BoxDecoration(color: theme.secondaryBackground),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Notatki śledztwa',
                        style: theme.headlineSmall
                            .copyWith(fontWeight: FontWeight.w800)),
                    Container(
                      decoration: BoxDecoration(
                          color: theme.error15,
                          borderRadius: BorderRadius.circular(9999.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.timer_rounded,
                                color: theme.onError, size: 16.0),
                            const SizedBox(width: 4.0),
                            Text('04:22',
                                style: theme.labelLarge.copyWith(
                                    color: theme.onError,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // MOBILNY SELEKTOR: Kółka u góry generują się w 100% dynamicznie
            Container(
              height: 76.0,
              color: theme.secondaryBackground,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: _gameState.activePlayers
                            .asMap()
                            .entries
                            .map((entry) {
                              final int index = entry.key;
                              final PlayerInvestigationData player =
                                  entry.value;
                              final bool isActive = _activePlayerIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _activePlayerIndex =
                                        index; // Zmiana podglądanego gracza
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: isActive
                                      ? theme.primary
                                      : theme.alternate,
                                  child: Text(
                                    player.initials,
                                    style: TextStyle(
                                      color: isActive
                                          ? Colors.white
                                          : theme.primaryText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            })
                            .toList()
                            .divide(const SizedBox(width: 12.0)),
                      ),
                    ),
                  ),
                  Container(height: 1.0, color: theme.alternate),
                ],
              ),
            ),

            // DYNAMICZNA LISTA KART NOTATEK
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _dayPeriods.length,
                itemBuilder: (context, index) {
                  final period = _dayPeriods[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: PlayerNoteCardWidget(
                      key: ValueKey('${currentPlayer.initials}_$period'),
                      playerName: period,
                      status: 'Gdzie był gracz ${currentPlayer.initials}?',
                      currentLocation: currentPlayer.savedLocations[period],
                      selectedAction: currentPlayer.savedActions[period],
                      color: theme.primary,
                      onLocationChanged: (newLocation) {
                        setState(() {
                          currentPlayer.savedLocations[period] = newLocation;
                          currentPlayer.savedActions[period] = null;
                        });
                      },
                      onActionChanged: (newAction) {
                        setState(() {
                          currentPlayer.savedActions[period] = newAction;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            // Dolna nawigacja
            Container(
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // PRZYCISK 1: Profile
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => context.goNamed(
                          PlayerInvestigationWidget.routeName,
                          extra: {
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 300),
                            ),
                          },
                        ),
                        child: wrapWithModel(
                          model: _model.buttonModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: ButtonWidget(
                            content: 'Profile',
                            icon: Icon(
                              Icons.person_rounded,
                              color: theme.primaryText,
                              size: 16.0,
                            ),
                            iconPresent: true,
                            iconEndPresent: false,
                            variant: 'outline',
                            size:
                                'medium', // Przywrócenie średniego rozmiaru zapobiega "pogrubieniu"
                            fullWidth: true,
                            loading: false,
                            disabled: false,
                          ),
                        ),
                      ),
                    ),

                    // PRZYCISK 2: Mój kalendarz
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => context.goNamed(
                          ScheduleOrganizerWidget.routeName,
                          extra: {
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 300),
                            ),
                          },
                        ),
                        child: wrapWithModel(
                          model: _model.buttonModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: ButtonWidget(
                            content: 'Mój kalendarz',
                            icon: Icon(
                              Icons.event_note_rounded,
                              color: theme.onPrimary,
                              size: 16.0,
                            ),
                            iconPresent: true,
                            iconEndPresent: false,
                            variant: 'primary',
                            size:
                                'medium', // Przywrócenie średniego rozmiaru zapobiega "pogrubieniu"
                            fullWidth: true,
                            loading: false,
                            disabled: false,
                          ),
                        ),
                      ),
                    ),
                  ].divide(const SizedBox(width: 16.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
