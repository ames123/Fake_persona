import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import '/pages/components/button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

// POPRAWKA: Importujemy ProfileState z systemu konfiguracji profilu
import '/profile_state.dart';
import '/pages/components/time_slot/time_slot_widget.dart';
import '/pages/current_task_view/current_task_view_model.dart';

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

  // =========================================================================
  // BACKEND: Zmienna globalna kontrolująca aktualną fazę gry (Pora dnia)
  // Możliwe wartości zgodne z kluczami bazy: 'RANO', 'POŁUDNIE', 'POPOŁUDNIE', 'WIECZÓR', 'NOC'
  // =========================================================================
  final String currentActivePeriod = 'RANO';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CurrentTaskViewModel());

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
    if (_resetController.isAnimating) {
      _resetController.stop();
    }
    setState(() {
      _isDragging = true;
      _dragOffset = math.max(0.0, _dragOffset - details.delta.dy);
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
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

    _resetController.forward(from: 0.0);
  }

  // Funkcja pomocnicza dopasowująca ikony do zadań użytkownika
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
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final maxDragDistance = screenSize.height * 0.6;

    // Pobieramy dane zapisanego profilu gracza ze wspólnego stanu
    final profile = ProfileState();
    final currentRole = profile.currentRole;
    final routine = profile.savedUserRoutine;

    // Pobieramy zadanie przypisane bezpośrednio do aktualnej pory dnia, aby wyświetlić je na wielkiej karcie frontowej
    final currentActiveTask = routine[currentActivePeriod] ?? 'Czas wolny';

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
            // WARSTWA 1 (POD SPODEM): Nieruchomy Kalendarz / Harmonogram z podświetleniem
            // =========================================================================
            Positioned(
              left: 24.0,
              right: 24.0,
              bottom: 0.0,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'HARMONOGRAM: $currentRole',
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // SLOT 1: RANO
                          wrapWithModel(
                            model: _model.timeSlotModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: TimeSlotWidget(
                              icon: Icon(
                                _getIconForTask(routine['RANO'] ?? 'Basen'),
                                color: currentActivePeriod == 'RANO'
                                    ? theme.info
                                    : theme.primary,
                                size: 24.0,
                              ),
                              task: routine['RANO'] ?? 'Basen',
                              timeLabel: 'Rano',
                              editable: currentActivePeriod ==
                                  'RANO', // Podświetlenie aktywnego rzędu
                            ),
                          ),
                          // SLOT 2: POŁUDNIE
                          wrapWithModel(
                            model: _model.timeSlotModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: TimeSlotWidget(
                              icon: Icon(
                                _getIconForTask(
                                    routine['POŁUDNIE'] ?? 'Czas wolny'),
                                color: currentActivePeriod == 'POŁUDNIE'
                                    ? theme.info
                                    : theme.primary,
                                size: 24.0,
                              ),
                              task: routine['POŁUDNIE'] ?? 'Czas wolny',
                              timeLabel: 'Południe',
                              editable: currentActivePeriod == 'POŁUDNIE',
                            ),
                          ),
                          // SLOT 3: POPOŁUDNIE
                          wrapWithModel(
                            model: _model.timeSlotModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: TimeSlotWidget(
                              icon: Icon(
                                _getIconForTask(
                                    routine['POPOŁUDNIE'] ?? 'Jedzenie'),
                                color: currentActivePeriod == 'POPOŁUDNIE'
                                    ? theme.info
                                    : theme.primary,
                                size: 24.0,
                              ),
                              task: routine['POPOŁUDNIE'] ?? 'Jedzenie',
                              timeLabel: 'Popołudnie',
                              editable: currentActivePeriod == 'POPOŁUDNIE',
                            ),
                          ),
                          // SLOT 4: WIECZÓR
                          wrapWithModel(
                            model: _model.timeSlotModel4,
                            updateCallback: () => safeSetState(() {}),
                            child: TimeSlotWidget(
                              icon: Icon(
                                _getIconForTask(routine['WIECZÓR'] ?? 'Sport'),
                                color: currentActivePeriod == 'WIECZÓR'
                                    ? theme.info
                                    : theme.primary,
                                size: 24.0,
                              ),
                              task: routine['WIECZÓR'] ?? 'Sport',
                              timeLabel: 'Wieczór',
                              editable: currentActivePeriod == 'WIECZÓR',
                            ),
                          ),
                          // SLOT 5: NOC
                          wrapWithModel(
                            model: _model.timeSlotModel5,
                            updateCallback: () => safeSetState(() {}),
                            child: TimeSlotWidget(
                              icon: Icon(
                                _getIconForTask(routine['NOC'] ?? 'Gotowanie'),
                                color: currentActivePeriod == 'NOC'
                                    ? theme.info
                                    : theme.primary,
                                size: 24.0,
                              ),
                              task: routine['NOC'] ?? 'Gotowanie',
                              timeLabel: 'Noc',
                              editable: currentActivePeriod == 'NOC',
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
            // WARSTWA 2 (NA GÓRZE): Główna karta reagująca na przeciąganie z dynamicznym zadaniem
            // =========================================================================
            Transform.translate(
              offset: Offset(0, -math.min(_dragOffset, maxDragDistance)),
              child: GestureDetector(
                onVerticalDragUpdate: _onVerticalDragUpdate,
                onVerticalDragEnd: _onVerticalDragEnd,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
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
                            'Nastała pora:',
                            style: theme.bodyMedium.copyWith(
                              color: theme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            // Dynamicznie wyświetla aktualną porę dnia zapisaną w systemie
                            currentActivePeriod,
                            style: theme.displayLarge.copyWith(
                              color: const Color.fromARGB(255, 226, 33, 30),
                              fontWeight: FontWeight.bold,
                              fontSize: 84.0,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            // Dynamiczny komunikat mówiący graczowi, co ma fizycznie zrobić na planszy
                            'Przesuń się na pole zgodnie ze swoim harmonogramem',
                            textAlign: TextAlign.center,
                            style: theme.bodyLarge.copyWith(
                              color: const Color.fromARGB(255, 226, 33, 30),
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
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
          ],
        ),
      ),
    );
  }
}
