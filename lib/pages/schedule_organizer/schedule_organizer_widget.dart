import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/time_slot2/time_slot2_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'schedule_organizer_model.dart';
import '/profile_state.dart';
// POPRAWKA: Importujemy GameState, aby pobrać i nasłuchiwać globalny timer
import '/game_state.dart';
export 'schedule_organizer_model.dart';

class ScheduleOrganizerWidget extends StatefulWidget {
  const ScheduleOrganizerWidget({super.key});

  static String routeName = 'ScheduleOrganizer';
  static String routePath = '/scheduleOrganizer';

  @override
  State<ScheduleOrganizerWidget> createState() =>
      _ScheduleOrganizerWidgetState();
}

class _ScheduleOrganizerWidgetState extends State<ScheduleOrganizerWidget> {
  late ScheduleOrganizerModel _model;
  late List<Map<String, dynamic>> _timeSlots;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String currentActivePeriod = 'RANO';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScheduleOrganizerModel());

    // POPRAWKA: Podpinamy system powiadomień timera do odświeżania tego widoku
    GameState().onTimeChanged = () {
      if (mounted) {
        safeSetState(() {});
      }
    };

    final profile = ProfileState();
    final routine = profile.savedUserRoutine;

    _timeSlots = [
      {
        'id': 'ts1',
        'period': 'Rano',
        'task': routine['RANO'] ?? 'Czas wolny',
        'icon': _getIconForTask(routine['RANO'] ?? 'Czas wolny'),
        'active': currentActivePeriod == 'RANO',
      },
      {
        'id': 'ts2',
        'period': 'Południe',
        'task': routine['POŁUDNIE'] ?? 'Sport',
        'icon': _getIconForTask(routine['POŁUDNIE'] ?? 'Sport'),
        'active': currentActivePeriod == 'POŁUDNIE',
      },
      {
        'id': 'ts3',
        'period': 'Popołudnie',
        'task': routine['POPOŁUDNIE'] ?? 'Jedzenie',
        'icon': _getIconForTask(routine['POPOŁUDNIE'] ?? 'Jedzenie'),
        'active': currentActivePeriod == 'POPOŁUDNIE',
      },
      {
        'id': 'ts4',
        'period': 'Wieczór',
        'task': routine['WIECZÓR'] ?? 'Oglądanie',
        'icon': _getIconForTask(routine['WIECZÓR'] ?? 'Oglądanie'),
        'active': currentActivePeriod == 'WIECZÓR',
      },
      {
        'id': 'ts5',
        'period': 'Noc',
        'task': routine['NOC'] ?? 'Czytanie',
        'icon': _getIconForTask(routine['NOC'] ?? 'Czytanie'),
        'active': currentActivePeriod == 'NOC',
      },
    ];
  }

  IconData _getIconForTask(String task) {
    switch (task) {
      case 'Czytanie':
        return Icons.menu_book_rounded;
      case 'Czas wolny':
        return Icons.groups_rounded;
      case 'Pisanie książki':
        return Icons.edit_note_rounded;
      case 'Oglądanie':
        return Icons.visibility_rounded;
      case 'Słuchanie muzyki':
        return Icons.music_note_rounded;
      case 'Mycie':
        return Icons.bathtub_rounded;
      case 'Trening':
        return Icons.fitness_center_rounded;
      case 'Sport':
        return Icons.sports_volleyball_rounded;
      case 'Jedzenie':
        return Icons.restaurant_rounded;
      case 'Gotowanie':
        return Icons.cookie_rounded;
      case 'Szukanie zapasów':
        return Icons.search_rounded;
      case 'Odpoczynek':
        return Icons.bed_rounded;
      case 'Ścieranie kurzu':
        return Icons.cleaning_services_rounded;
      case 'Przebieranie się':
        return Icons.checkroom_rounded;
      case 'Dezynfekcja':
        return Icons.vaccines_rounded;
      case 'Pielęgnacja roślin':
        return Icons.local_florist_rounded;
      case 'Kradzież':
        return Icons.local_mall_rounded;
      case 'Badanie lekarskie':
        return Icons.medical_services_rounded;
      case 'Granie na PC':
        return Icons.computer_rounded;
      case 'Eksperyment':
        return Icons.science_rounded;
      case 'Próba roli':
        return Icons.theater_comedy_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  @override
  void dispose() {
    // POPRAWKA: Bezpiecznie odpinamy timer przy zamykaniu okna
    GameState().onTimeChanged = null;
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentRole = ProfileState().currentRole;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    FlutterFlowTheme.of(context).primaryBackground,
                    FlutterFlowTheme.of(context).surface50
                  ],
                  stops: const [0.0, 1.0],
                  begin: const AlignmentDirectional(0.0, -1.0),
                  end: const AlignmentDirectional(0, 1.0),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kalendarz dnia ($currentRole)',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                  lineHeight: 1.3,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer_rounded,
                                color: FlutterFlowTheme.of(context).error,
                                size: 16.0,
                              ),
                              Text(
                                // POPRAWKA: Pobieramy aktualny czas z centralnego Timera
                                GameState().formattedTime,
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      font: GoogleFonts.spaceGrotesk(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context).error,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                      lineHeight: 1.2,
                                    ),
                              ),
                            ].divide(const SizedBox(width: 4.0)),
                          ),
                        ].divide(const SizedBox(height: 4.0)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Twój plan dnia',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                                lineHeight: 1.3,
                              ),
                        ),
                        const SizedBox(height: 16.0),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _timeSlots.length,
                          itemBuilder: (context, index) {
                            final slot = _timeSlots[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: TimeSlot2Widget(
                                icon: Icon(
                                  slot['icon'] as IconData,
                                  color: slot['active'] as bool
                                      ? FlutterFlowTheme.of(context).onPrimary
                                      : FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  size: 24.0,
                                ),
                                period: slot['period'] as String,
                                task: slot['task'] as String,
                                active: slot['active'] as bool,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () => context.goNamed(
                                    PlayerNotesWidget.routeName,
                                    extra: {
                                      kTransitionInfoKey: const TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 300),
                                      ),
                                    },
                                  ),
                                  child: wrapWithModel(
                                    model: _model.buttonModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ButtonWidget(
                                      content: 'Moje notatki',
                                      icon: Icon(
                                        Icons.description_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 16.0,
                                      ),
                                      iconPresent: true,
                                      iconEndPresent: false,
                                      variant: 'outline',
                                      size: 'medium',
                                      fullWidth: false,
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
                                    PlayerInvestigationWidget.routeName,
                                    extra: {
                                      kTransitionInfoKey: const TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.rightToLeft,
                                        duration: Duration(milliseconds: 300),
                                      ),
                                    },
                                  ),
                                  child: wrapWithModel(
                                    model: _model.buttonModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: ButtonWidget(
                                      content: 'Profile',
                                      icon: Icon(
                                        Icons.groups_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 16.0,
                                      ),
                                      iconPresent: true,
                                      iconEndPresent: false,
                                      variant: 'outline',
                                      size: 'medium',
                                      fullWidth: false,
                                      loading: false,
                                      disabled: false,
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(const SizedBox(width: 16.0)),
                          ),
                        ].divide(const SizedBox(height: 16.0)),
                      ),
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
