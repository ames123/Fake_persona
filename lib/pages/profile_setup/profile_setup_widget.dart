import '../current_task_view/current_task_view_widget.dart'
    show CurrentTaskViewWidget;
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_setup_model.dart';
// POPRAWKA: Importujemy nasz nowy, inteligentny ProfileState
import '/profile_state.dart';
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

  // Stałe, niezmienne pory dnia przypisane do pozycji (od góry do dołu)
  final List<String> _timeLabels = [
    'Rano',
    'Południe',
    'Popołudnie',
    'Wieczór',
    'Noc',
  ];

  // POPRAWKA: Lista zadań staje się pusta na start i ładuje się dynamicznie
  List<SlotData> _slots = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileSetupModel());

    // POPRAWKA: Przy wejściu na ekran losujemy profil i wczytujemy jego harmonogram
    _slots = ProfileState().rollNewProfile();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
    // Pobieramy aktualną rolę, aby wyświetlić ją na gradiencie
    final currentRoleName = ProfileState().currentRole;

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

                  // --- Wizytówka Profilu (Gradient) ---
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
                                // Pobieramy pierwsze dwie litery dynamicznej roli jako Avatar
                                currentRoleName
                                    .substring(
                                        0, min(2, currentRoleName.length))
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
                                  // POPRAWKA: Dynamiczny tekst wylosowanej roli (np. Kucharz, Gamer...)
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
                                  'Przeciągaj bloki, aby zmienić kolejność zadań',
                                  style: theme.bodyMedium.override(
                                    font: GoogleFonts.urbanist(),
                                    color: theme.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // --- CAŁKOWICIE NIEZALEŻNA LISTA PRZECIĄGANA ---
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _slots.length,
                        onReorder: _updateOrder,
                        buildDefaultDragHandles: false,
                        itemBuilder: (context, index) {
                          final item = _slots[index];
                          final currentPeriodLabel = _timeLabels[index];

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
                                  color: theme.alternate,
                                  width: 1.0,
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
                                        color: const Color(0xFFE3F2FD),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: Icon(
                                        item.icon,
                                        color: const Color(0xFF1E88E5),
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
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Zmiana na lewo dla lepszego czytania par
                                        children: [
                                          Text(
                                            currentPeriodLabel, // STAŁA PORA DNIA
                                            style: theme.bodySmall.copyWith(
                                              color: const Color(0xFF1E88E5),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            item.task, // DYNAMICZNE ZADANIE Z BAZY PROFILU
                                            style: theme.bodyLarge.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: theme.primaryText,
                                              fontSize: 18.0,
                                            ),
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
                      onTap: () {
                        // POPRAWKA: Zanim zmienimy ekran, trwale zapisujemy ułożony
                        // przez gracza harmonogram czynności do ProfileState
                        ProfileState().saveFinalRoutine(_slots);

                        context.goNamed(
                          CurrentTaskViewWidget.routeName,
                          extra: {
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 300),
                            ),
                          },
                        );
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
                          disabled: false,
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
