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
  String? _selectedLocation; // Początkowo null = brak przypisanego pokoju
  String? _selectedAction; // Początkowo null = brak aktywnej czynności

  // Lista lokacji dostępnych w aplikacji
  final List<String> _locationsList = [
    'Basen',
    'Kuchnia',
    'Jadalnia',
    'Łazienka',
    'Pokój'
  ];

  // Baza danych 3 czynności per pokój
  final Map<String, List<String>> _roomActivities = {
    'Basen': ['Pływanie', 'Mycie', 'Unknown'],
    'Kuchnia': ['Gotowanie', 'Zmywanie naczyń', 'Parzenie kawy'],
    'Jadalnia': ['Jedzenie obiadu', 'Rozmowa przy stole', 'Ścieranie kurzy'],
    'Łazienka': ['Kąpiel', 'Pranie', 'Mycie zębów'],
    'Pokój': ['Oglądanie TV', 'Spanie', 'Czytanie książki'],
  };

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    // Ustawiamy sztywny, jednolity niebieski kolor z góry aplikacji
    final cardColor = theme.primary;

    // Wyciągamy czynności tylko jeśli wybrano pokój
    final currentActivities = _selectedLocation != null
        ? (_roomActivities[_selectedLocation] ?? [])
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
            // GÓRA KARTY: Usunięto CircleAvatar, tekst wyrównany do lewej
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.playerName, // RANO, WIECZÓR, itp.
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

            // LOKACJA: Dropdown (Z ujednoliconym niebieskim kolorem pinezki)
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
                    color: cardColor, // Zawsze niebieski
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

            // LISTA 3 CZYNNOŚCI (Zawsze niebieskie akcenty przy wyborze)
            if (_selectedLocation != null) ...[
              const SizedBox(height: 16.0),
              Column(
                children: currentActivities.map((action) {
                  final isSelected = _selectedAction == action;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedAction = isSelected ? null : action;
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
                            if (isSelected) ...[
                              Icon(
                                Icons.check_rounded,
                                color: cardColor,
                                size: 16.0,
                              ),
                              const SizedBox(width: 8.0),
                            ],
                            Text(
                              action,
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
