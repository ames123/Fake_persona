import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/profile_tab/profile_tab_widget.dart';
import '/pages/components/schedule_item/schedule_item_widget.dart';
import '/pages/components/guess_row/guess_row_widget.dart';
import '/profile_state.dart';
// POPRAWKA: Importujemy stan gry z listą aktywnych graczy i timerem
import '/game_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'player_investigation_model.dart';
export 'player_investigation_model.dart';

class PlayerInvestigationWidget extends StatefulWidget {
  const PlayerInvestigationWidget({super.key});

  static String routeName = 'PlayerInvestigation';
  static String routePath = '/playerInvestigation';

  @override
  State<PlayerInvestigationWidget> createState() =>
      _PlayerInvestigationWidgetState();
}

class _PlayerInvestigationWidgetState extends State<PlayerInvestigationWidget> {
  late PlayerInvestigationModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final ProfileState _profileState = ProfileState();

  final GameState _gameState = GameState();

  String _activeRoleName = 'Pisarz';

  final Map<String, String> _profileGenitives = {
    'Pisarz': 'pisarza',
    'Sportowiec': 'sportowca',
    'Kucharz': 'kucharza',
    'Sprzątacz': 'sprzątacza',
    'Ogrodnik': 'ogrodnika',
    'Złodziej': 'złodzieja',
    'Lekarz': 'lekarza',
    'Gamer': 'gamera',
    'Naukowiec': 'naukowca',
    'Aktor': 'aktora',
  };

  final Map<String, IconData> _activityIcons = {
    'Gotowanie': Icons.soup_kitchen_rounded,
    'Szukanie zapasów': Icons.search_rounded,
    'Jedzenie': Icons.restaurant_rounded,
    'Granie na PC': Icons.computer_rounded,
    'Próba roli': Icons.theater_comedy_rounded,
    'Oglądanie': Icons.tv_rounded,
    'Pisanie książki': Icons.menu_book_rounded,
    'Eksperyment': Icons.science_rounded,
    'Czytanie': Icons.auto_stories_rounded,
    'Pielęgnacja roślin': Icons.yard_rounded,
    'Trening': Icons.fitness_center_rounded,
    'Sport': Icons.sports_volleyball_rounded,
    'Badanie lekarskie': Icons.medical_services_rounded,
    'Słuchanie muzyki': Icons.headphones_rounded,
    'Przebieranie się': Icons.checkroom_rounded,
    'Kradzież': Icons.gavel_rounded,
    'Mycie': Icons.clean_hands_rounded,
    'Ścieranie kurzu': Icons.cleaning_services_rounded,
    'Dezynfekcja': Icons.vaccines_rounded,
    'Odpoczynek': Icons.hotel_rounded,
    'Czas wolny': Icons.accessibility_new_rounded,
  };

  final List<Color> _playerColors = [
    const Color(0xFF4B39EF),
    const Color(0xFF39D2C0),
    const Color(0xFF24D160),
    const Color(0xFFF9CF58),
    const Color(0xFFEE8B60),
    const Color(0xFF1E88E5),
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlayerInvestigationModel());

    // POPRAWKA: Przekazujemy context, aby system wiedział gdzie wykonać automatyczne przekierowanie
    _gameState.updateContext(context);

//Uruchamiamy timer (funkcja sama sprawdzi, czy już bije, więc niczego nie zepsuje)
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
    // POPRAWKA: Odpinamy callback, aby nie rzucać setState na martwym widżecie
    _gameState.onTimeChanged = null;
    _model.dispose();
    super.dispose();
  }

  IconData _getIconForActivity(String? activity, IconData defaultIcon) {
    if (activity == null || !_activityIcons.containsKey(activity)) {
      return defaultIcon;
    }
    return _activityIcons[activity]!;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    final Map<String, String> currentRoutine =
        _profileState.staticRoutines[_activeRoleName] ?? {};
    final String genitiveName =
        _profileGenitives[_activeRoleName] ?? _activeRoleName.toLowerCase();

    final List<String> availableRoles =
        _profileState.staticRoutines.keys.toList();

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
            // NAGŁÓWEK
            Container(
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 24.0, 16.0, 24.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Śledztwo',
                              style: theme.headlineMedium.override(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.timer_rounded,
                                    color: theme.error, size: 16.0),
                                ValueListenableBuilder<String>(
                                  valueListenable: GameState().timeNotifier,
                                  builder: (context, value, child) {
                                    return Text(
                                      value,
                                      style: theme.labelLarge.override(
                                        fontFamily: GoogleFonts.spaceGrotesk()
                                            .fontFamily,
                                        color: theme.error,
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
                                        kTransitionInfoKey:
                                            const TransitionInfo(
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
                          ].divide(const SizedBox(height: 4.0)),
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.goNamed(FinalGuessWidget.routeName),
                          child: ButtonWidget(
                            content: 'Ostateczne Zgadnięcie',
                            icon: Icon(Icons.psychology_rounded,
                                color: theme.onPrimary, size: 16.0),
                            iconPresent: true,
                            iconEndPresent: false,
                            variant: 'primary',
                            size: 'small',
                            fullWidth: false,
                            loading: false,
                            disabled: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 1.0, color: theme.alternate),
                ],
              ),
            ),

            // SEKCJA GŁÓWNA
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                primary: false,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profile',
                            style: theme.labelSmall.override(
                              fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
                              color: theme.secondaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: availableRoles
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    final int index = entry.key;
                                    final String role = entry.value;
                                    final bool isActive =
                                        _activeRoleName == role;

                                    final String initials = role.length >= 2
                                        ? role.substring(0, 2)
                                        : role.toUpperCase();

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _activeRoleName = role;
                                        });
                                      },
                                      child: wrapWithModel(
                                        model: index == 0
                                            ? _model.profileTabModel1
                                            : index == 1
                                                ? _model.profileTabModel2
                                                : index == 2
                                                    ? _model.profileTabModel3
                                                    : _model.profileTabModel4,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ProfileTabWidget(
                                          initials: initials,
                                          name: role,
                                          active: isActive,
                                          onTap: '',
                                        ),
                                      ),
                                    );
                                  })
                                  .toList()
                                  .divide(const SizedBox(width: 8.0)),
                            ),
                          ),
                        ].divide(const SizedBox(height: 16.0)),
                      ),

                      // KAFELEK HARMONOGRAMU
                      Container(
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20.0,
                              color: theme.primary13,
                              offset: const Offset(0.0, 8.0),
                            )
                          ],
                          borderRadius: BorderRadius.circular(32.0),
                          border:
                              Border.all(color: theme.primary30, width: 1.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kalendarz $genitiveName',
                                        style: theme.titleMedium.override(
                                          fontFamily:
                                              GoogleFonts.urbanist().fontFamily,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Główny harmonogram dnia',
                                        style: theme.bodySmall.override(
                                          fontFamily:
                                              GoogleFonts.urbanist().fontFamily,
                                          color: theme.secondaryText,
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 4.0)),
                                  ),
                                  Icon(Icons.calendar_today_rounded,
                                      color: theme.primary, size: 24.0),
                                ],
                              ),
                              Divider(
                                  height: 16.0,
                                  thickness: 1.0,
                                  color: theme.alternate),

                              // Lista kafelków czasu
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ScheduleItemWidget(
                                    leadingIcon: _getIconForActivity(
                                        currentRoutine['RANO'],
                                        Icons.wb_sunny_rounded),
                                    period: 'Rano',
                                    activity:
                                        currentRoutine['RANO'] ?? 'Brak danych',
                                    color: theme.secondary,
                                    time: '',
                                  ),
                                  ScheduleItemWidget(
                                    leadingIcon: _getIconForActivity(
                                        currentRoutine['POŁUDNIE'],
                                        Icons.restaurant_rounded),
                                    period: 'Południe',
                                    activity: currentRoutine['POŁUDNIE'] ??
                                        'Brak danych',
                                    color: theme.tertiary,
                                    time: '',
                                  ),
                                  ScheduleItemWidget(
                                    leadingIcon: _getIconForActivity(
                                        currentRoutine['POPOŁUDNIE'],
                                        Icons.park_rounded),
                                    period: 'Popołudnie',
                                    activity: currentRoutine['POPOŁUDNIE'] ??
                                        'Brak danych',
                                    color: theme.primary,
                                    time: '',
                                  ),
                                  ScheduleItemWidget(
                                    leadingIcon: _getIconForActivity(
                                        currentRoutine['WIECZÓR'],
                                        Icons.dark_mode_rounded),
                                    period: 'Wieczór',
                                    activity: currentRoutine['WIECZÓR'] ??
                                        'Brak danych',
                                    color: theme.secondaryText,
                                    time: '',
                                  ),
                                  ScheduleItemWidget(
                                    leadingIcon: _getIconForActivity(
                                        currentRoutine['NOC'],
                                        Icons.bedtime_rounded),
                                    period: 'Noc',
                                    activity:
                                        currentRoutine['NOC'] ?? 'Brak danych',
                                    color: theme.primaryText,
                                    time: '',
                                  ),
                                ].divide(const SizedBox(height: 8.0)),
                              ),
                            ].divide(const SizedBox(height: 16.0)),
                          ),
                        ),
                      ),

                      // SEKCJA IDENTYFIKACJI POSTACI
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Zidentyfikuj postacie',
                            style: theme.titleMedium.override(
                              fontFamily: GoogleFonts.urbanist().fontFamily,
                              color: theme.primaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              final playersList = GameState().activePlayers;
                              final guesses = ProfileState().playerGuesses;

                              final duplicateSet = guesses.values
                                  .where((v) => v != null && v.isNotEmpty)
                                  .fold<Map<String, int>>({}, (map, value) {
                                    map[value] = (map[value] ?? 0) + 1;
                                    return map;
                                  })
                                  .entries
                                  .where((entry) => entry.value > 1)
                                  .map((entry) => entry.key)
                                  .toSet();

                              return Column(
                                children:
                                    playersList.asMap().entries.map((entry) {
                                  final int index = entry.key;
                                  final player = entry.value;

                                  final playerSelection =
                                      guesses[player.initials];

                                  final isDuplicate = playerSelection != null &&
                                      playerSelection.isNotEmpty &&
                                      duplicateSet.contains(playerSelection);

                                  final avatarColor = _playerColors[
                                      index % _playerColors.length];

                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: wrapWithModel(
                                      model: index == 0
                                          ? _model.guessRowModel1
                                          : index == 1
                                              ? _model.guessRowModel2
                                              : index == 2
                                                  ? _model.guessRowModel3
                                                  : _model.guessRowModel4,
                                      updateCallback: () => safeSetState(() {}),
                                      child: GuessRowWidget(
                                        color: avatarColor,
                                        initials: player.initials,
                                        profileName: player.initials,
                                        duplicateProfession: isDuplicate,
                                        onProfessionChanged: (_) =>
                                            safeSetState(() {}),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ].divide(const SizedBox(height: 24.0)),
                      ),
                    ].divide(const SizedBox(height: 24.0)),
                  ),
                ),
              ),
            ),

            // DOLNY PASEK NAWIGACJI
            Container(
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                        color: theme.alternate, shape: BoxShape.rectangle),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        24.0, 16.0, 24.0, 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () =>
                                context.goNamed(PlayerNotesWidget.routeName),
                            child: wrapWithModel(
                              model: _model.buttonModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: ButtonWidget(
                                content: 'Moje notatki',
                                icon: Icon(Icons.description_rounded,
                                    color: theme.primaryText, size: 16.0),
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
                            onTap: () => context
                                .goNamed(ScheduleOrganizerWidget.routeName),
                            child: wrapWithModel(
                              model: _model.buttonModel3,
                              updateCallback: () => safeSetState(() {}),
                              child: ButtonWidget(
                                content: 'Mój kalendarz',
                                icon: Icon(Icons.event_note_rounded,
                                    color: theme.onSecondary, size: 16.0),
                                iconPresent: true,
                                iconEndPresent: false,
                                variant: 'secondary',
                                size: 'medium',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
