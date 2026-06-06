import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/player_note_card/player_note_card_widget.dart';
import '/index.dart';
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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlayerNotesModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

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
            // Nagłówek strony (Niezmieniony)
            Container(
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notatki',
                          style: theme.headlineSmall.copyWith(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.error15,
                        borderRadius: BorderRadius.circular(9999.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.timer_rounded,
                                color: theme.onError, size: 16.0),
                            const SizedBox(width: 4.0),
                            Text(
                              '04:22',
                              style: theme.labelLarge.copyWith(
                                fontFamily:
                                    GoogleFonts.spaceGrotesk().fontFamily,
                                fontWeight: FontWeight.bold,
                                color: theme.onError,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Inicjały graczy u góry (Niezmienione)
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
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.primary,
                            child: const Text('AR',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.alternate,
                            child: Text('JS',
                                style: TextStyle(
                                    color: theme.primaryText,
                                    fontWeight: FontWeight.bold)),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.alternate,
                            child: Text('CC',
                                style: TextStyle(
                                    color: theme.primaryText,
                                    fontWeight: FontWeight.bold)),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.alternate,
                            child: Text('TS',
                                style: TextStyle(
                                    color: theme.primaryText,
                                    fontWeight: FontWeight.bold)),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.alternate,
                            child: Text('KP',
                                style: TextStyle(
                                    color: theme.primaryText,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ].divide(const SizedBox(width: 12.0)),
                      ),
                    ),
                  ),
                  Container(height: 1.0, color: theme.alternate),
                ],
              ),
            ),

            // Lista dedykowanych kart (Czyste przekazanie bez migania ekranu)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _dayPeriods.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: PlayerNoteCardWidget(
                      playerName: _dayPeriods[index],
                    ),
                  );
                },
              ),
            ),

            // Dolna nawigacja (Oryginalna i sprawna)
            Container(
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Row(
                  children: [
                    Expanded(
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
                            icon: Icon(Icons.person_rounded,
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
                            icon: Icon(Icons.event_note_rounded,
                                color: theme.onPrimary, size: 16.0),
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
