import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/player_note_card/player_note_card_widget.dart';
// Import widoku profilu dla akcji przycisku
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
            // Nagłówek strony
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
                    padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
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
                              'Notatki',
                              style: theme.headlineSmall.copyWith(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              '',
                              style: theme.bodySmall.copyWith(
                                fontFamily: GoogleFonts.urbanist().fontFamily,
                                color: theme.secondaryText,
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
                              mainAxisSize: MainAxisSize.min,
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
                ],
              ),
            ),

            // MODYFIKACJA: Koła z inicjałami graczy zamiast starych checków tekstowych
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Aktywne koło (obecnie wybrany profil/gracz)
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.primary,
                            child: Text(
                              'AR',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.alternate,
                            child: Text(
                              'JS',
                              style: TextStyle(
                                  color: theme.primaryText,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.alternate,
                            child: Text(
                              'CC',
                              style: TextStyle(
                                  color: theme.primaryText,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.alternate,
                            child: Text(
                              'TS',
                              style: TextStyle(
                                  color: theme.primaryText,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.alternate,
                            child: Text(
                              'KP',
                              style: TextStyle(
                                  color: theme.primaryText,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ].divide(const SizedBox(width: 12.0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    color: theme.alternate,
                  ),
                ],
              ),
            ),

            // MODYFIKACJA: Lista chronologiczna pór dnia dla profilu
            Expanded(
              flex: 1,
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 1. RANO (Basen ze zmienionymi czynnościami)
                        wrapWithModel(
                          model: _model.playerNoteCardModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: PlayerNoteCardWidget(
                            action1: 'Pływanie',
                            action2: 'Mycie',
                            color: theme.primary,
                            currentLocation: 'Basen',
                            initials: 'AR',
                            playerName: 'RANO',
                            status: 'Dostępne czynności',
                          ),
                        ),
                        // 2. POŁUDNIE
                        wrapWithModel(
                          model: _model.playerNoteCardModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: PlayerNoteCardWidget(
                            action1: 'Playing Darts',
                            action2: 'Drinking Soda',
                            color: theme.tertiary,
                            currentLocation: 'Game Room',
                            initials: 'AR',
                            playerName: 'POŁUDNIE',
                            status: 'W rucie',
                          ),
                        ),
                        // 3. POPOŁUDNIE
                        wrapWithModel(
                          model: _model.playerNoteCardModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: PlayerNoteCardWidget(
                            action1: 'Reading',
                            action2: 'Researching',
                            color: theme.success,
                            currentLocation: 'Library',
                            initials: 'AR',
                            playerName: 'POPOŁUDNIE',
                            status: 'Stacjonarnie',
                          ),
                        ),
                        // 4. WIECZÓR
                        wrapWithModel(
                          model: _model.playerNoteCardModel4,
                          updateCallback: () => safeSetState(() {}),
                          child: PlayerNoteCardWidget(
                            action1: 'Trening',
                            action2: 'Bieganie',
                            color: theme.secondary,
                            currentLocation: 'Gym',
                            initials: 'AR',
                            playerName: 'WIECZÓR',
                            status: 'Aktywny',
                          ),
                        ),
                        // 5. NOC
                        wrapWithModel(
                          model: _model
                              .playerNoteCardModel4, // Używa instancji modelu dla 5 elementu
                          updateCallback: () => safeSetState(() {}),
                          child: PlayerNoteCardWidget(
                            action1: 'Cooking',
                            action2: 'Eating',
                            color: Colors.purple,
                            currentLocation: 'Kitchen',
                            initials: 'AR',
                            playerName: 'NOC',
                            status: 'Odpoczynek',
                          ),
                        ),
                        Container(
                          height: 80.0,
                        ),
                      ].divide(const SizedBox(height: 16.0)),
                    ),
                  ),
                ),
              ),
            ),

            // Dolny pasek nawigacyjny z podmienionymi nazwami przycisków i nową akcją
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
                      color: theme.alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // PRZYCISK 1: Profile (Przekierowanie z dawnego śledztwa)
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => context.goNamed(
                              PlayerInvestigationWidget
                                  .routeName, // POPRAWKA: Przejście do śledztwa gracza
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
                              model: _model
                                  .buttonModel1, // Korzysta z buttonModel1 z Twojego PlayerNotesModel
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

                        // PRZYCISK 2: Mój kalendarz
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => context.goNamed(
                              ScheduleOrganizerWidget
                                  .routeName, // POPRAWKA: Przejście do kalendarza
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
                              model: _model
                                  .buttonModel2, // POPRAWKA: Bezpieczne użycie buttonModel2 z Twojego PlayerNotesModel
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
