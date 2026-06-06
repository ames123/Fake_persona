import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerNoteCardWidget extends StatefulWidget {
  const PlayerNoteCardWidget({
    super.key,
    required this.playerName,
    this.status = 'Dostępne czynności',
  });

  final String playerName;
  final String status;

  @override
  State<PlayerNoteCardWidget> createState() => _PlayerNoteCardWidgetState();
}

class _PlayerNoteCardWidgetState extends State<PlayerNoteCardWidget> {
  String? _selectedLocation;
  String? _selectedAction;

  final List<String> _locationsList = [
    'Basen',
    'Kuchnia',
    'Jadalnia',
    'Łazienka',
    'Pokój'
  ];

  // NOWOŚĆ: Każda czynność została połączona w parę z odpowiednią ikoną w bazie danych
  final Map<String, List<Map<String, dynamic>>> _roomActivitiesWithIcons = {
    'Basen': [
      {'name': 'Pływanie', 'icon': Icons.pool_rounded},
      {'name': 'Mycie', 'icon': Icons.clean_hands_rounded},
      {'name': 'Unknown', 'icon': Icons.help_outline_rounded},
    ],
    'Kuchnia': [
      {'name': 'Gotowanie', 'icon': Icons.soup_kitchen_rounded},
      {'name': 'Zmywanie naczyń', 'icon': Icons.local_laundry_service_rounded},
      {'name': 'Parzenie kawy', 'icon': Icons.coffee_rounded},
    ],
    'Jadalnia': [
      {'name': 'Jedzenie obiadu', 'icon': Icons.restaurant_rounded},
      {'name': 'Rozmowa przy stole', 'icon': Icons.forum_rounded},
      {'name': 'Ścieranie kurzy', 'icon': Icons.cleaning_services_rounded},
    ],
    'Łazienka': [
      {'name': 'Kąpiel', 'icon': Icons.bathtub_rounded},
      {'name': 'Pranie', 'icon': Icons.dry_cleaning_rounded},
      {'name': 'Mycie zębów', 'icon': Icons.brush_rounded},
    ],
    'Pokój': [
      {'name': 'Oglądanie TV', 'icon': Icons.tv_rounded},
      {'name': 'Spanie', 'icon': Icons.bed_rounded},
      {'name': 'Czytanie książki', 'icon': Icons.menu_book_rounded},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final cardColor = theme.primary;

    // Pobranie obiektów czynności (nazwa + ikona) dla wybranej lokacji
    final currentActivities = _selectedLocation != null
        ? (_roomActivitiesWithIcons[_selectedLocation] ?? [])
        : [];

    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: theme.alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // GÓRA KARTY
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.playerName,
                        style: theme.titleMedium.override(
                          fontFamily: GoogleFonts.urbanist().fontFamily,
                          color: theme.primaryText,
                          fontWeight: FontWeight.bold,
                          lineHeight: 1.3,
                        ),
                      ),
                      Text(
                        widget.status,
                        style: theme.labelSmall.override(
                          fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
                          color: theme.secondaryText,
                          lineHeight: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                FlutterFlowIconButton(
                  borderRadius: 8.0,
                  buttonSize: 40.0,
                  fillColor: Colors.transparent,
                  icon: Icon(
                    Icons.edit_note_rounded,
                    color: theme.secondaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    context.goNamed(PlayerInvestigationWidget.routeName);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // LOKACJA: Dropdown pokoju
            Container(
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: cardColor,
                    size: 18.0,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedLocation,
                        hint: Text(
                          'Wybierz pokój...',
                          style: theme.bodyMedium.override(
                            fontFamily: GoogleFonts.urbanist().fontFamily,
                            color: theme.secondaryText,
                          ),
                        ),
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down_rounded,
                            color: theme.secondaryText, size: 24.0),
                        style: theme.bodyMedium.override(
                          fontFamily: GoogleFonts.urbanist().fontFamily,
                          color: theme.primaryText,
                          lineHeight: 1.5,
                        ),
                        dropdownColor: theme.secondaryBackground,
                        items: _locationsList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                            _selectedAction = null;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // LISTA 3 CZYNNOŚCI (Z ikonami zależnymi od wybranej akcji)
            if (_selectedLocation != null) ...[
              const SizedBox(height: 16.0),
              Column(
                children: currentActivities.map((activity) {
                  final String actionName = activity['name'];
                  final IconData actionIcon = activity['icon'];
                  final isSelected = _selectedAction == actionName;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedAction = isSelected ? null : actionName;
                        });
                      },
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        height: 44.0,
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: isSelected ? cardColor : theme.alternate,
                            width: isSelected ? 2.0 : 1.0,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Renderowanie ikony zamiast uniwersalnego ptaszka
                            Icon(
                              actionIcon,
                              color:
                                  isSelected ? cardColor : theme.secondaryText,
                              size: 18.0,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              actionName,
                              style: theme.labelMedium.override(
                                fontFamily:
                                    GoogleFonts.spaceGrotesk().fontFamily,
                                color: isSelected
                                    ? cardColor
                                    : theme.secondaryText,
                                fontSize: 14.0,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
