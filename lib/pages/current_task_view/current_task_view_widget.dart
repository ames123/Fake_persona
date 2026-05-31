import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/nav/nav.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

// Importy komponentów i modeli na wzór ProfileSetup
import '/pages/components/time_slot/time_slot_widget.dart';
import '/pages/current_task_view/current_task_view_model.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';

class CurrentTaskViewWidget extends StatefulWidget {
  const CurrentTaskViewWidget({super.key});

  static String routeName = 'CurrentTaskView';
  static String routePath = '/currentTaskView';

  @override
  State<CurrentTaskViewWidget> createState() => _CurrentTaskViewWidgetState();
}

class _CurrentTaskViewWidgetState extends State<CurrentTaskViewWidget>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  double _dragOffset = 0.0;
  bool _isDragging = false;
  late AnimationController _resetController;
  late Animation<double> _resetAnimation;

  late CurrentTaskViewModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CurrentTaskViewModel());

    // Kontroler do płynnego powrotu karty na miejsce po puszczeniu palca
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _resetAnimation =
        Tween<double>(begin: 0.0, end: 0.0).animate(_resetController);
  }

  @override
  void dispose() {
    _resetController.dispose();
    _model.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    // Jeśli animacja powrotu trwa, zatrzymujemy ją, by słuchać palca
    if (_resetController.isAnimating) {
      _resetController.stop();
    }
    setState(() {
      _isDragging = true;
      // Reagujemy na ruch w górę (ujemna delta dy oznacza ruch palca w górę)
      _dragOffset = math.max(0.0, _dragOffset - details.delta.dy);
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    // Gdy użytkownik puści palec, tworzymy animację powrotną od obecnego punktu do 0.0
    _isDragging = false;
    _resetAnimation = Tween<double>(
      begin: _dragOffset,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _resetController,
      curve: Curves.easeOutCubic,
    ))
      ..addListener(() {
        setState(() {
          _dragOffset = _resetAnimation.value;
        });
      });

    // POPRAWKA: Uruchamiamy animację od zera za pomocą forward(from: 0.0)
    _resetController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final screenSize = MediaQuery.of(context).size;

    // Maksymalne przesunięcie w górę (karta odsłoni dół, ale nie ucieknie całkiem z ekranu)
    final maxDragDistance = screenSize.height * 0.6;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: Stack(
          children: [
            // =========================================================================
            // WARSTWA 1 (POD SPODEM): Nieruchomy Kalendarz / Harmonogram
            // =========================================================================
            Positioned(
              left: 24.0,
              right: 24.0,
              bottom: 0.0, // Przypięcie do samej dolnej krawędzi ekranu
              child: SafeArea(
                top:
                    false, // Ignorujemy górny bezpieczny margines dla tej warstwy
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 24.0), // Margines od fizycznego dołu ekranu
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment:
                        MainAxisAlignment.end, // Spychamy zawartość do dołu
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TWÓJ HARMONOGRAM',
                            style: theme.labelLarge.copyWith(
                              fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
                              fontWeight: FontWeight.w800,
                              color: theme.secondaryText,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_double_arrow_up_rounded,
                            color: theme.secondaryText,
                            size: 20.0,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      // Lista slotów czasowych odwzorowana z ProfileSetup
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          wrapWithModel(
                            model: _model.timeSlotModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: TimeSlotWidget(
                              icon: Icon(Icons.water_drop_rounded,
                                  color: theme.primary, size: 24.0),
                              task: 'Basen',
                              timeLabel: 'Rano',
                              editable: true,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.timeSlotModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: TimeSlotWidget(
                              icon: Icon(Icons.groups_rounded,
                                  color: theme.primary, size: 24.0),
                              task: 'Czas wolny',
                              timeLabel: 'Południe',
                              editable: true,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.timeSlotModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: TimeSlotWidget(
                              icon: Icon(Icons.shield_rounded,
                                  color: theme.primary, size: 24.0),
                              task: 'Jedzenie',
                              timeLabel: 'Popołudnie',
                              editable: true,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.timeSlotModel4,
                            updateCallback: () => safeSetState(() {}),
                            child: TimeSlotWidget(
                              icon: Icon(Icons.inventory_2_rounded,
                                  color: theme.primary, size: 24.0),
                              task: 'Sport',
                              timeLabel: 'Wieczór',
                              editable: true,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.timeSlotModel5,
                            updateCallback: () => safeSetState(() {}),
                            child: TimeSlotWidget(
                              icon: Icon(Icons.nightlight_round,
                                  color: theme.primary, size: 24.0),
                              task: 'Gotowanie',
                              timeLabel: 'Noc',
                              editable: true,
                            ),
                          ),
                        ].divide(const SizedBox(height: 8.0)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // =========================================================================
            // WARSTWA 2 (NA GÓRZE): Główna karta na cały ekran reagująca na przeciąganie
            // =========================================================================
            Transform.translate(
              offset: Offset(0, -math.min(_dragOffset, maxDragDistance)),
              child: GestureDetector(
                onVerticalDragUpdate: _onVerticalDragUpdate,
                onVerticalDragEnd: _onVerticalDragEnd,
                behavior: HitTestBehavior
                    .opaque, // POPRAWKA: Zmieniono z blackBox na opaque
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
                    // Dodajemy delikatny cień od spodu, widoczny podczas podnoszenia karty
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 30,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            'Wybiła godzina',
                            style: theme.bodyMedium.copyWith(
                              color: theme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '10.00',
                            style: theme.displayLarge.copyWith(
                              color: Colors.red[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 84.0,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Przesuń się na pole zgodnie ze swoim harmonogramem',
                            textAlign: TextAlign.center,
                            style: theme.bodyLarge.copyWith(
                              color: Colors.red[400],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 48),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context.goNamed(
                                  PlayerInvestigationWidget.routeName,
                                  extra: {
                                    kTransitionInfoKey: const TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 300),
                                    ),
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primary,
                                foregroundColor: theme.info,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Zatwierdź pozycję',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Wskazówka i animowany/wizualny element przeciągania na dole ekranu
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.keyboard_arrow_up_rounded,
                                color:
                                    theme.secondaryText.withValues(alpha: 0.7),
                                size: 28,
                              ),
                              Text(
                                'Przejedź palcem w górę, aby podejrzeć harmonogram',
                                style: theme.bodySmall.copyWith(
                                  color: theme.secondaryText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // =========================================================================
            // WARSTWA 3 (AKCESORIA): Przyciski UI zawsze przypięte do góry ekranu
            // =========================================================================
            // Przyciski są poza elementem przesuwanym, dzięki czemu zawsze są dostępne pod palcem
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlutterFlowIconButton(
                        borderRadius: 9999.0,
                        buttonSize: 48.0,
                        fillColor: theme.accent4,
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: theme.primaryText,
                          size: 32.0,
                        ),
                        onPressed: () async {
                          // Profil
                        },
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 9999.0,
                        buttonSize: 48.0,
                        fillColor: theme.accent4,
                        icon: Icon(
                          Icons.search_rounded,
                          color: theme.primaryText,
                          size: 32.0,
                        ),
                        onPressed: () async {
                          // Szukaj
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
