import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/player_note_card/player_note_card_widget.dart';
import '/game_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  // POPRAWKA: Lista kontrolowana bezpośrednio przez gracza plusikiem (startuje od Dnia 1)
  final List<String> _days = ['DZIEŃ 1'];
  int _activeDayIndex = 0;

  final GameState _gameState = GameState();

  // Przechowujemy indeks wybranego gracza zamiast sztywnego stringa
  int _activePlayerIndex = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlayerNotesModel());

    // Informujemy globalny stan, że gracz patrzy teraz na ten ekran
    _gameState.updateContext(context);

    // TEST/ZABEZPIECZENIE: Jeśli lista jest pusta, symulujemy start gry dla 3 mobilnych graczy
    if (_gameState.activePlayers.isEmpty) {
      _gameState.startNewGame(['KS', 'JS', 'AZ']);
    }

    // Uruchamiamy timer (funkcja sama sprawdzi, czy już bije, więc niczego nie zepsuje)
    _gameState.startTimer(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gameState.updateContext(context);
    _gameState.onTimeChanged = _updateTimerText;
  }

  void _updateTimerText() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _gameState.onTimeChanged = null;
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    // Pobieramy dane aktualnie przeglądanego gracza
    if (_gameState.activePlayers.isEmpty) return const SizedBox();
    final currentPlayer = _gameState.activePlayers[_activePlayerIndex];

    // Skrót do identyfikatora aktualnego dnia (np. "D1", "D2", "D3") do zapisu w mapie lokacji
    final String dayKey = 'D${_activeDayIndex + 1}';

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
            // Nagłówek (Timer przeniesiony na lewą stronę, pod tytuł sekcji)
            Container(
              decoration: BoxDecoration(color: theme.secondaryBackground),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notatki śledztwa',
                          style: theme.headlineSmall
                              .copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_rounded,
                              color: theme.error,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            ValueListenableBuilder<String>(
                              valueListenable: GameState().timeNotifier,
                              builder: (context, value, child) {
                                return Text(
                                  value,
                                  style: theme.labelLarge.copyWith(
                                    color: theme.error,
                                    fontFamily:
                                        GoogleFonts.spaceGrotesk().fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 12.0),
                            ElevatedButton(
                              onPressed: () {
                                GameState().forceResetTimer();
                                context.goNamed(
                                  CurrentTaskViewWidget.routeName,
                                  extra: {
                                    kTransitionInfoKey: const TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.leftToRight,
                                      duration: Duration(milliseconds: 300),
                                    ),
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 10.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: const Text(
                                'Skip Time',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // MOBILNY SELEKTOR GRACZY: Kółka u góry generują się w 100% dynamicznie
            Container(
              height: 76.0,
              color: theme.secondaryBackground,
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: _gameState.activePlayers
                          .asMap()
                          .entries
                          .map((entry) {
                            final int index = entry.key;
                            final PlayerInvestigationData player = entry.value;
                            final bool isActive = _activePlayerIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _activePlayerIndex = index;
                                });
                              },
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor:
                                    isActive ? theme.primary : theme.alternate,
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
                  Container(height: 1.0, color: theme.alternate),
                ],
              ),
            ),

            // POPRAWKA: SELEKTOR DNI Z DYNAMICZNYM PLUSIKIEM I USUWANIE NA LONG-PRESS
            Container(
              height: 48.0,
              color: theme.secondaryBackground,
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _days.asMap().entries.map((entry) {
                          final int index = entry.key;
                          final String dayName = entry.value;
                          final bool isSelected = _activeDayIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _activeDayIndex = index;
                              });
                            },
                            onLongPress: () {
                              // Zabezpieczenie: usuwamy dzień tylko jeśli jest to ostatni dzień i nie jedyny
                              if (index == _days.length - 1 &&
                                  _days.length > 1) {
                                setState(() {
                                  _days.removeAt(index);
                                  _activeDayIndex = _days.length - 1;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Usunięto ${dayName}')),
                                );
                              }
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: isSelected
                                        ? theme.primary
                                        : Colors.transparent,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                dayName,
                                style: theme.bodyMedium.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? theme.primaryText
                                      : theme.secondaryText,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // DYNAMICZNY PLUSIK (Maksymalnie 5 dni)
                  VerticalDivider(
                      width: 1.0, thickness: 1.0, color: theme.alternate),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline_rounded,
                        color: theme.primary, size: 24.0),
                    onPressed: () {
                      if (_days.length < 5) {
                        setState(() {
                          _days.add('DZIEŃ ${_days.length + 1}');
                          _activeDayIndex = _days.length -
                              1; // Automatyczny skok do nowego dnia
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Osiągnięto limit 5 dni śledztwa!')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(height: 1.0, color: theme.alternate),

            // DYNAMICZNA LISTA KART NOTATEK (Dostosowana do wybranego dnia)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _dayPeriods.length,
                itemBuilder: (context, index) {
                  final period = _dayPeriods[index];
                  final storageKey = '${period}_$dayKey';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: PlayerNoteCardWidget(
                      key: ValueKey('${currentPlayer.initials}_$storageKey'),
                      playerName: period,
                      status:
                          'Gdzie był gracz ${currentPlayer.initials} (${_days[_activeDayIndex]})?',
                      currentLocation: currentPlayer.savedLocations[storageKey],
                      selectedAction: currentPlayer.savedActions[storageKey],
                      color: theme.primary,
                      onLocationChanged: (newLocation) {
                        setState(() {
                          currentPlayer.savedLocations[storageKey] =
                              newLocation;
                          currentPlayer.savedActions[storageKey] = null;
                        });
                      },
                      onActionChanged: (newAction) {
                        setState(() {
                          currentPlayer.savedActions[storageKey] = newAction;
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
                              size: 'medium',
                              fullWidth: true,
                              loading: false,
                              disabled: false,
                            ),
                          ),
                        ),
                      ),
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
                              size: 'medium',
                              fullWidth: true,
                              loading: false,
                              disabled: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
