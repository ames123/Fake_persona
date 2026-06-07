import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/guess_row/guess_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/profile_state.dart';
// POPRAWKA: Importujemy GameState, skąd pobierzemy listę graczy oraz timer
import '/game_state.dart';
import 'final_guess_model.dart';
export 'final_guess_model.dart';

class FinalGuessWidget extends StatefulWidget {
  const FinalGuessWidget({super.key});

  static String routeName = 'FinalGuess';
  static String routePath = '/finalGuess';

  @override
  State<FinalGuessWidget> createState() => _FinalGuessWidgetState();
}

class _FinalGuessWidgetState extends State<FinalGuessWidget> {
  late FinalGuessModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Lista kolorów dla awatarów graczy (wykorzystywana rotacyjnie)
  final List<Color> _playerColors = [
    const Color(0xFF4B39EF), // Primary
    const Color(0xFF39D2C0), // Tertiary
    const Color(0xFF24D160), // Success
    const Color(0xFFF9CF58), // Warning
    const Color(0xFFEE8B60), // Orange
    const Color(0xFF1E88E5), // Blue
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FinalGuessModel());

    // POPRAWKA: Podpinamy system powiadomień timera do odświeżania tego widoku co sekundę
    GameState().onTimeChanged = () {
      if (mounted) {
        safeSetState(() {});
      }
    };
  }

  @override
  void dispose() {
    // POPRAWKA: Bezpiecznie odpinamy timer przy opuszczaniu widoku
    GameState().onTimeChanged = null;
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
            Container(
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20.0,
                    color: theme.secondary,
                    offset: const Offset(0.0, 4.0),
                    spreadRadius: 0.0,
                  )
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32.0),
                  bottomRight: Radius.circular(32.0),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'OSTATECZNE ZGADNIĘCIE',
                      style: theme.headlineMedium.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.w900,
                          fontStyle: theme.headlineMedium.fontStyle,
                        ),
                        color: theme.primaryText,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w900,
                        fontStyle: theme.headlineMedium.fontStyle,
                        lineHeight: 1.2,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.secondary10,
                        borderRadius: BorderRadius.circular(9999.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: theme.secondary,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 16.0, 24.0, 16.0),
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.timer_rounded,
                                color: theme.primaryText,
                                size: 20.0,
                              ),
                              Text(
                                // POPRAWKA: Podmieniono statyczny tekst na dynamiczny czas z GameState
                                GameState().formattedTime,
                                style: theme.bodyMedium.override(
                                  font: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: theme.bodyMedium.fontStyle,
                                  ),
                                  color: theme.primaryText,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: theme.bodyMedium.fontStyle,
                                  lineHeight: 1.5,
                                ),
                              ),
                            ].divide(const SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Dopasuj wszystkich graczy do ich harmonogramów',
                      style: theme.bodySmall.override(
                        font: GoogleFonts.urbanist(
                          fontWeight: theme.bodySmall.fontWeight,
                          fontStyle: theme.bodySmall.fontStyle,
                        ),
                        color: theme.secondaryText,
                        letterSpacing: 0.0,
                        fontWeight: theme.bodySmall.fontWeight,
                        fontStyle: theme.bodySmall.fontStyle,
                        lineHeight: 1.4,
                      ),
                    ),
                  ],
                )),
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
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Zidentyfikuj postacie',
                                  style: theme.titleMedium.override(
                                    font: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: theme.titleMedium.fontStyle,
                                    ),
                                    color: theme.primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: theme.titleMedium.fontStyle,
                                    lineHeight: 1.3,
                                  ),
                                ),
                                // =========================================================================
                                // POPRAWKA: W pełni dynamiczne generowanie wierszy z GameState().activePlayers
                                // =========================================================================
                                Builder(
                                  builder: (context) {
                                    // Pobieramy bazę graczy oraz mapę typowań
                                    final playersList =
                                        GameState().activePlayers;
                                    final guesses =
                                        ProfileState().playerGuesses;

                                    // Liczymy powtórzenia zawodów, ignorując puste pola i nulle
                                    final duplicateSet = guesses.values
                                        .where((v) => v != null && v.isNotEmpty)
                                        .fold<Map<String, int>>({},
                                            (map, value) {
                                          map[value] = (map[value] ?? 0) + 1;
                                          return map;
                                        })
                                        .entries
                                        .where((entry) => entry.value > 1)
                                        .map((entry) => entry.key)
                                        .toSet();

                                    // Renderujemy wiersze dynamicznie
                                    return Column(
                                      children: playersList
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final int index = entry.key;
                                        final player = entry.value;

                                        // Pobieramy aktualny wybór dla tego konkretnego gracza
                                        final playerSelection =
                                            guesses[player.initials];

                                        // POPRAWKA WALIDACJI: Wiersz świeci na czerwono TYLKO jeśli:
                                        // 1. Gracz coś wybrał (wartość nie jest pusta ani nullem)
                                        // 2. Ten wybór znajduje się w zbiorze duplikatów
                                        final isDuplicate =
                                            playerSelection != null &&
                                                playerSelection.isNotEmpty &&
                                                duplicateSet
                                                    .contains(playerSelection);

                                        final avatarColor = _playerColors[
                                            index % _playerColors.length];

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: wrapWithModel(
                                            model: index == 0
                                                ? _model.guessRowModel1
                                                : index == 1
                                                    ? _model.guessRowModel2
                                                    : index == 2
                                                        ? _model.guessRowModel3
                                                        : _model.guessRowModel4,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: GuessRowWidget(
                                              color: avatarColor,
                                              initials: player.initials,
                                              profileName: player.initials,
                                              duplicateProfession:
                                                  isDuplicate, // Bezpieczna, poprawiona flaga
                                              onProfessionChanged: (_) =>
                                                  safeSetState(() {}),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                )
                              ].divide(const SizedBox(height: 24.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
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
                                  transitionType:
                                      PageTransitionType.leftToRight,
                                  duration: Duration(milliseconds: 300),
                                ),
                              },
                            ),
                            child: wrapWithModel(
                              model: _model.buttonModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: ButtonWidget(
                                content: 'Powrót',
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: theme.primary,
                                  size: 16.0,
                                ),
                                iconPresent: true,
                                iconEndPresent: false,
                                variant: 'ghost',
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
                          child: wrapWithModel(
                            model: _model.buttonModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: GestureDetector(
                              onTap: () {
                                final finalAnswers =
                                    ProfileState().playerGuesses;
                                print(
                                    'Wysyłanie ostatecznych typowań z bazy: $finalAnswers');
                              },
                              child: const ButtonWidget(
                                content: 'WYŚLIJ',
                                iconPresent: false,
                                iconEndPresent: false,
                                variant: 'primary',
                                size: 'large',
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
          ],
        ),
      ),
    );
  }
}
