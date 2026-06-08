import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/result_card/result_card_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'game_results_model.dart';
export 'game_results_model.dart';
import '/game_state.dart';
import '/pages/lobby_entry/lobby_entry_widget.dart';

class GameResultsWidget extends StatefulWidget {
  const GameResultsWidget({super.key});

  static String routeName = 'GameResults';
  static String routePath = '/gameResults';

  @override
  State<GameResultsWidget> createState() => _GameResultsWidgetState();
}

class _GameResultsWidgetState extends State<GameResultsWidget> {
  late GameResultsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final winnerName = GameState().winnerName ?? 'Nieznany Gracz';
  final winnerInitials = GameState().winnerInitials ?? '??';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameResultsModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        bottomNavigationBar: SafeArea(
          top: false,
          bottom: true,
          left: false,
          right: false,
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              shape: BoxShape.rectangle,
              border: Border(
                top: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              // POPRAWKA: Zmiana z Row na Column, żeby przyciski miały pełną szerokość i teksty nigdy nie overflowowały
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Ważne: bierze tylko tyle miejsca, ile potrzebują przyciski
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // Rozciąga przyciski na pełną szerokość
                children: [
                  wrapWithModel(
                    model: _model.buttonModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: GestureDetector(
                      onTap: () {
                        GameState().resetNewGame();
                        context.goNamed(
                          LobbyEntryWidget.routeName,
                          extra: {
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 300),
                            ),
                          },
                        );
                      },
                      child: ButtonWidget(
                        content: 'Zagraj ponownie',
                        icon: Icon(
                          Icons.replay_rounded,
                          color: FlutterFlowTheme.of(context).onPrimary,
                          size: 16.0,
                        ),
                        iconPresent: true,
                        iconEndPresent: false,
                        variant: 'primary',
                        size: 'large',
                        fullWidth: true,
                        loading: false,
                        disabled: false,
                      ),
                    ),
                  ),
                ].divide(const SizedBox(
                    height: 12.0)), // Odstęp pionowy między przyciskami
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).primary20,
                          Colors.transparent
                        ],
                        stops: const [0.0, 1.0],
                        begin: const AlignmentDirectional(0.0, -1.0),
                        end: const AlignmentDirectional(0, 1.0),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    child: Stack(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-0.5, -0.5),
                          child: ClipRect(
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 80.0,
                                sigmaY: 80.0,
                              ),
                              child: Container(
                                width: 200.0,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).accent30,
                                  borderRadius: BorderRadius.circular(9999.0),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 32.0, horizontal: 24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.network(
                                  'https://dimg.dreamflow.cloud/v1/lottie/confetti+celebration',
                                  width: 160.0,
                                  height: 160.0,
                                  fit: BoxFit.contain,
                                  animate: true,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'MISJA ZAKOŃCZONA',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: GoogleFonts.spaceGrotesk(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .onBackground,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            lineHeight: 1.2,
                                          ),
                                    ),
                                    Text(
                                      '$winnerName wygrał grę!',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w900,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w900,
                                            lineHeight: 1.2,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 8.0)),
                                ),
                              ].divide(const SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Zwycięzca',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.urbanist(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              lineHeight: 1.3,
                            ),
                      ),
                      wrapWithModel(
                        model: _model.resultCardModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: ResultCardWidget(
                          initials: winnerInitials,
                          name: winnerName,
                          points: '',
                          role: '',
                          isWinner: true,
                        ),
                      ),
                    ].divide(const SizedBox(height: 16.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
