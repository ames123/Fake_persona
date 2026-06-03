import '../current_task_view/current_task_view_widget.dart'
    show CurrentTaskViewWidget;
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/components/button/button_widget.dart';
import '/pages/components/time_slot/time_slot_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_setup_model.dart';
export 'profile_setup_model.dart';

class ProfileSetupWidget extends StatefulWidget {
  const ProfileSetupWidget({super.key});

  static String routeName = 'ProfileSetup';
  static String routePath = '/profileSetup';

  @override
  State<ProfileSetupWidget> createState() => _ProfileSetupWidgetState();
}

// Struktura danych reprezentująca pojedyncze zadanie w kalendarzu
class SlotData {
  final int id;
  final IconData icon;
  final Color? iconColor;
  final String task;
  final String timeLabel;

  SlotData({
    required this.id,
    required this.icon,
    this.iconColor,
    required this.task,
    required this.timeLabel,
  });
}

class _ProfileSetupWidgetState extends State<ProfileSetupWidget> {
  late ProfileSetupModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Definicja początkowej listy zadań do przeciągania
  late List<SlotData> _slots;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileSetupModel());

    // Inicjalizacja danych kafelków
    _slots = [
      SlotData(
          id: 1,
          icon: Icons.water_drop_rounded,
          iconColor: Colors.blue,
          task: 'Basen',
          timeLabel: 'Rano'),
      SlotData(
          id: 2,
          icon: Icons.groups_rounded,
          task: 'Czas wolny',
          timeLabel: 'Południe'),
      SlotData(
          id: 3,
          icon: Icons.shield_rounded,
          task: 'Jedzenie',
          timeLabel: 'Popołudnie'),
      SlotData(
          id: 4,
          icon: Icons.inventory_2_rounded,
          task: 'Sport',
          timeLabel: 'Wieczór'),
      SlotData(
          id: 5,
          icon: Icons.nightlight_round,
          task: 'Gotowanie',
          timeLabel: 'Noc'),
    ];
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  // Funkcja obsługująca logikę zmiany kolejności elementów na liście
  void _updateOrder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final SlotData item = _slots.removeAt(oldIndex);
      _slots.insert(newIndex, item);
    });
  }

  // Pomocnicza metoda wiążąca indeks listy z odpowiednim modelem FlutterFlow
  dynamic _getModelForIndex(int index) {
    switch (index) {
      case 0:
        return _model.timeSlotModel1;
      case 1:
        return _model.timeSlotModel2;
      case 2:
        return _model.timeSlotModel3;
      case 3:
        return _model.timeSlotModel4;
      case 4:
        return _model.timeSlotModel5;
      default:
        return _model.timeSlotModel1;
    }
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
                                'JD',
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
                                  'Sportowiec',
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

                  // --- Sekcja Kalendarza i Informacji ---
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

                      // --- DYNAMICZNA PRZECIĄGANA LISTA (ReorderableListView) ---
                      // --- DYNAMICZNA PRZECIĄGANA LISTA (ReorderableListView) ---
                      ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _slots.length,
                        onReorder: _updateOrder,
                        buildDefaultDragHandles:
                            false, // Wyłączamy domyślny drag na całym kafelku
                        itemBuilder: (context, index) {
                          final item = _slots[index];

                          return Padding(
                            key: ValueKey(item.id),
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                // 1. Twój oryginalny komponent (lewa strona pozwala przewijać stronę)
                                wrapWithModel(
                                  model: _getModelForIndex(index)
                                      as TimeSlotModel, // Poprawiono: usunięto getDefModel
                                  updateCallback: () => safeSetState(() {}),
                                  child: TimeSlotWidget(
                                    icon: Icon(
                                      item.icon,
                                      color:
                                          item.iconColor ?? theme.primaryText,
                                      size: 24.0,
                                    ),
                                    task: item.task,
                                    timeLabel: item.timeLabel,
                                    editable: true,
                                  ),
                                ),

                                // 2. Niewidzialna strefa łapania natychmiastowego dragu nałożona na Twoje kropki
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  width:
                                      60.0, // Szerokość dopasowana pod ikonkę kropek po prawej stronie
                                  child: ReorderableDragStartListener(
                                    index: index,
                                    child: Container(
                                      color: Colors
                                          .transparent, // Przezroczyste tło, nic nie zasłania
                                    ),
                                  ),
                                ),
                              ],
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
                      onTap: () => context.goNamed(
                        CurrentTaskViewWidget.routeName,
                        extra: {
                          kTransitionInfoKey: const TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300),
                          ),
                        },
                      ),
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
