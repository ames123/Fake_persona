import 'dart:async';

import 'package:schedule_sleuth/game_state.dart';

import '../current_task_view/current_task_view_widget.dart'
    show CurrentTaskViewWidget;
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_setup_model.dart';
import '/profile_state.dart';
import 'dart:math' as math;
export 'profile_setup_model.dart';

class ProfileSetupWidget extends StatefulWidget {
  const ProfileSetupWidget({super.key});

  static String routeName = 'ProfileSetup';
  static String routePath = '/profileSetup';

  @override
  State<ProfileSetupWidget> createState() => _ProfileSetupWidgetState();
}

class _ProfileSetupWidgetState extends State<ProfileSetupWidget> {
  late ProfileSetupModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _timeLabels = [
    'Rano',
    'Południe',
    'Popołudnie',
    'Wieczór',
    'Noc',
  ];

  List<SlotData> _slots = [];
  List<String> _cachedAlternativeTasks = [];

  // Rejestr ikon identyczny jak w pozostałych widokach gry
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

  bool submitted = false;

  Timer? timer;

  void initTimer() {
    if (timer != null && timer!.isActive) return;

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      GameState().refreshGamestate();
      setState(() {
        if(GameState().state != 'ORDERING'){
          context.goNamed(
                                CurrentTaskViewWidget.routeName,
                                extra: {
                                  kTransitionInfoKey: const TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 300),
                                  ),
                                },
                              );
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileSetupModel());
    getRole();
    initTimer();
    _prepareAlternativeTasks();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> getRole() async{
    _slots = await ProfileState().getProfileFromApi(GameState().currentRoomCode, GameState().currentUsername);
  }

  // Losowanie 3 unikalnych alternatyw na starcie ekranu
  void _prepareAlternativeTasks() {
    final state = ProfileState();
    final allAvailable = state.staticRoutines.values
        .expand((routine) => routine.values)
        .toSet()
        .toList();

    final currentTasks = _slots.map((s) => s.task).toSet();

    final filteredPool = allAvailable
        .where((task) => !currentTasks.contains(task) && task != 'Czas wolny')
        .toList();

    filteredPool.shuffle();
    _cachedAlternativeTasks = filteredPool.take(3).toList();
  }

  // POPRAWKA: Pobieranie ikony bezpośrednio z bazy ikon gry
  IconData _getIconForTaskName(String taskName) {
    return _activityIcons[taskName] ?? Icons.help_outline_rounded;
  }

  // Ekran wyboru z wcześniej wylosowanymi 3 aktywnościami i właściwymi ikonami
  void _showChoiceDialog(int slotIndex) {
    final theme = FlutterFlowTheme.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: theme.secondaryBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          title: Text(
            'Wybierz nową aktywność',
            textAlign: TextAlign.center,
            style: theme.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _cachedAlternativeTasks.map((taskName) {
              // Pobranie dynamicznej, poprawnej ikony
              final taskIcon = _getIconForTaskName(taskName);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _slots[slotIndex] = SlotData(
                        id: _slots[slotIndex].id,
                        icon: taskIcon,
                        iconColor: Colors.blue,
                        task: taskName,
                      );
                    });
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.alternate),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      children: [
                        Icon(taskIcon,
                            color: const Color(0xFF1E88E5), size: 24.0),
                        const SizedBox(width: 16.0),
                        Text(
                          taskName,
                          style: theme.bodyLarge
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _updateOrder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final SlotData item = _slots.removeAt(oldIndex);
      _slots.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final currentRoleName = ProfileState().currentRole;

    final bool hasFreeTimeLeft =
        _slots.any((slot) => slot.task == 'Czas wolny');

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Nagłówek ---
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Ustawienia profilu',
                            style: theme.headlineLarge.override(
                              font: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w800),
                              color: theme.primaryText,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Ustal swój kalendarz',
                        style: theme.titleMedium.override(
                          font: GoogleFonts.urbanist(),
                          color: theme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),

                  // --- Wizytówka Profilu ---
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20.0,
                          color: theme.secondary25,
                          offset: const Offset(0.0, 10.0),
                        )
                      ],
                      gradient: LinearGradient(
                        colors: [theme.primary, theme.secondary],
                        stops: const [0.0, 1.0],
                        begin: const AlignmentDirectional(1.0, 1.0),
                        end: const AlignmentDirectional(-1.0, -1.0),
                      ),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: theme.secondaryBackground,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                currentRoleName
                                    .substring(
                                        0, math.min(2, currentRoleName.length))
                                    .toUpperCase(),
                                style: theme.labelMedium.override(
                                  font: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.w600),
                                  color: theme.primary,
                                  fontSize: 30.4,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24.0),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wylosowany profil',
                                  style: theme.labelMedium.override(
                                    font: GoogleFonts.spaceGrotesk(),
                                    color: theme.onBackground80,
                                  ),
                                ),
                                Text(
                                  currentRoleName,
                                  style: theme.titleLarge.override(
                                    font: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.w800),
                                    color: theme.onBackground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // --- Sekcja Kalendarza ---
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16.0),
                                Text(
                                  'Twój kalendarz',
                                  style: theme.headlineSmall.override(
                                    font: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  hasFreeTimeLeft
                                      ? '⚠️ Musisz wybrać aktywność z listy dla "Czasu wolnego"'
                                      : 'Zadania przypisane! Możesz teraz zmienić ich kolejność',
                                  style: theme.bodyMedium.override(
                                    font: GoogleFonts.urbanist(),
                                    color: hasFreeTimeLeft
                                        ? theme.error
                                        : theme.success,
                                    fontWeight: hasFreeTimeLeft
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // --- LISTA PRZECIĄGANA ---
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _slots.length,
                        onReorder: _updateOrder,
                        buildDefaultDragHandles: false,
                        itemBuilder: (context, index) {
                          final item = _slots[index];
                          final currentPeriodLabel = _timeLabels[index];
                          final bool isFreeTime = item.task == 'Czas wolny';

                          return Padding(
                            key: ValueKey(item.id),
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              width: double.infinity,
                              height: 90.0,
                              decoration: BoxDecoration(
                                color: theme.secondaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(
                                  color: isFreeTime
                                      ? theme.error.withValues(alpha: 0.5)
                                      : theme.alternate,
                                  width: isFreeTime ? 2.0 : 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      width: 56.0,
                                      height: 56.0,
                                      decoration: BoxDecoration(
                                        color: isFreeTime
                                            ? const Color(0xFFFFEBEE)
                                            : const Color(0xFFE3F2FD),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: Icon(
                                        item.icon,
                                        color: isFreeTime
                                            ? theme.error
                                            : const Color(0xFF1E88E5),
                                        size: 28.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currentPeriodLabel,
                                            style: theme.bodySmall.copyWith(
                                              color: isFreeTime
                                                  ? theme.error
                                                  : const Color(0xFF1E88E5),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                item.task,
                                                style: theme.bodyLarge.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: isFreeTime
                                                      ? theme.error
                                                      : theme.primaryText,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              if (isFreeTime) ...[
                                                const SizedBox(width: 8.0),
                                                GestureDetector(
                                                  onTap: () =>
                                                      _showChoiceDialog(index),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    decoration: BoxDecoration(
                                                      color: theme.error
                                                          .withValues(
                                                              alpha: 0.1),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons
                                                          .edit_location_alt_rounded,
                                                      color: theme.error,
                                                      size: 18.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ReorderableDragStartListener(
                                    index: index,
                                    child: Container(
                                      width: 60.0,
                                      height: double.infinity,
                                      color: Colors.transparent,
                                      child: Icon(
                                        Icons.drag_indicator_rounded,
                                        color: theme.secondaryText
                                            .withValues(alpha: 0.5),
                                        size: 26.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),

                  // --- Przycisk Zatwierdzenia ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: GestureDetector(
                      onTap: hasFreeTimeLeft
                          ? null
                          : () {
                              ProfileState().saveFinalRoutine(_slots);
                              ProfileState().sendRoutineToApi(GameState().currentRoomCode, GameState().currentUsername);
                              submitted = true;
                            },
                      child: wrapWithModel(
                        model: _model.buttonModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ButtonWidget(
                          content: 'Potwierdź kalendarz',
                          icon: Icon(
                            Icons.check_circle_rounded,
                            color: theme.onPrimary,
                            size: 16.0,
                          ),
                          iconPresent: true,
                          iconEndPresent: false,
                          variant: 'primary',
                          size: 'large',
                          fullWidth: true,
                          loading: false,
                          disabled: hasFreeTimeLeft || submitted,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
