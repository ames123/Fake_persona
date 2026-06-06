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
    this.color,
    this.status = 'Dostępne czynności',
  });

  final String playerName;
  final Color? color;
  final String status;

  @override
  State<PlayerNoteCardWidget> createState() => _PlayerNoteCardWidgetState();
}

class _PlayerNoteCardWidgetState extends State<PlayerNoteCardWidget> {
  String? _selectedLocation;
  String? _selectedAction;

  // 1. Zaktualizowana pełna lista pokoi z Twojej tabeli
  final List<String> _locationsList = [
    'Kuchnia z jadalnią',
    'Salon',
    'Gabinet / Biblioteka',
    'Ogród',
    'Siłownia',
    'Łazienka',
    'Pokój Medyczny',
    'Piwnica / Korytarz',
    'Taras / Weranda',
    'Pokój Rozrywki',
    'Pracownia Naukowa',
    'Kącik Artysty',
    'Basen'
  ];

  // 2. Pełna baza danych odwzorowująca Twoją tabelę 1:1 wraz z dopasowanymi ikonami
  final Map<String, List<Map<String, dynamic>>> _roomActivitiesWithIcons = {
    'Kuchnia z jadalnią': [
      {'name': 'Gotowanie', 'icon': Icons.soup_kitchen_rounded},
      {'name': 'Szukanie zapasów', 'icon': Icons.search_rounded},
      {'name': 'Jedzenie', 'icon': Icons.restaurant_rounded},
    ],
    'Salon': [
      {'name': 'Granie na PC', 'icon': Icons.computer_rounded},
      {'name': 'Próba roli', 'icon': Icons.theater_comedy_rounded},
      {'name': 'Oglądanie', 'icon': Icons.tv_rounded},
    ],
    'Gabinet / Biblioteka': [
      {'name': 'Pisanie książki', 'icon': Icons.menu_book_rounded},
      {'name': 'Eksperyment', 'icon': Icons.science_rounded},
      {'name': 'Czytanie', 'icon': Icons.auto_stories_rounded},
    ],
    'Ogród': [
      {'name': 'Pielęgnacja roślin', 'icon': Icons.yard_rounded},
      {'name': 'Trening', 'icon': Icons.fitness_center_rounded},
      {'name': 'Sport', 'icon': Icons.sports_volleyball_rounded},
    ],
    'Siłownia': [
      {'name': 'Trening', 'icon': Icons.fitness_center_rounded},
      {'name': 'Badanie lekarskie', 'icon': Icons.medical_services_rounded},
      {'name': 'Słuchanie muzyki', 'icon': Icons.headphones_rounded},
      {
        'name': 'Przebieranie się',
        'icon': Icons.checkroom_rounded
      }, // Obsługa 4. akcji
    ],
    'Łazienka': [
      {'name': 'Kradzież', 'icon': Icons.gavel_rounded},
      {'name': 'Mycie', 'icon': Icons.clean_hands_rounded},
      {'name': 'Ścieranie kurzu', 'icon': Icons.cleaning_services_rounded},
    ],
    'Pokój Medyczny': [
      {'name': 'Badanie lekarskie', 'icon': Icons.medical_services_rounded},
      {'name': 'Dezynfekcja', 'icon': Icons.vaccines_rounded},
      {'name': 'Odpoczynek', 'icon': Icons.hotel_rounded},
    ],
    'Piwnica / Korytarz': [
      {'name': 'Kradzież', 'icon': Icons.gavel_rounded},
      {'name': 'Ścieranie kurzu', 'icon': Icons.cleaning_services_rounded},
      {'name': 'Szukanie zapasów', 'icon': Icons.search_rounded},
    ],
    'Taras / Weranda': [
      {'name': 'Pielęgnacja roślin', 'icon': Icons.yard_rounded},
      {'name': 'Gotowanie', 'icon': Icons.soup_kitchen_rounded},
      {'name': 'Jedzenie', 'icon': Icons.restaurant_rounded},
    ],
    'Pokój Rozrywki': [
      {'name': 'Granie na PC', 'icon': Icons.sports_esports_rounded},
      {'name': 'Odpoczynek', 'icon': Icons.chair_rounded},
      {'name': 'Słuchanie muzyki', 'icon': Icons.music_note_rounded},
    ],
    'Pracownia Naukowa': [
      {'name': 'Eksperyment', 'icon': Icons.biotech_rounded},
      {'name': 'Badanie lekarskie', 'icon': Icons.health_and_safety_rounded},
      {'name': 'Czytanie', 'icon': Icons.menu_book_rounded},
    ],
    'Kącik Artysty': [
      {'name': 'Pisanie książki', 'icon': Icons.edit_note_rounded},
      {'name': 'Próba roli', 'icon': Icons.theater_comedy_rounded},
      {'name': 'Oglądanie', 'icon': Icons.movie_rounded},
    ],
    'Basen': [
      {'name': 'Sport', 'icon': Icons.pool_rounded},
      {'name': 'Mycie', 'icon': Icons.waves_rounded},
      {'name': 'Dezynfekcja', 'icon': Icons.sanitizer_rounded},
      {
        'name': 'Przebieranie się',
        'icon': Icons.checkroom_rounded
      }, // Obsługa 4. akcji
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final cardColor = widget.color ?? theme.primary;

    final currentActivities = _selectedLocation != null
        ? (_roomActivitiesWithIcons[_selectedLocation] ?? const [])
        : const [];

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

            // LOKACJA: Dropdown
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

            // LISTA 3 CZYNNOŚCI
            if (_selectedLocation != null && currentActivities.isNotEmpty) ...[
              const SizedBox(height: 16.0),
              Column(
                children: currentActivities.map((activity) {
                  final String actionName = activity['name'] as String;
                  final IconData actionIcon = activity['icon'] as IconData;
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
