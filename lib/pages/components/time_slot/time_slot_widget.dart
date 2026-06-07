import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeSlotWidget extends StatelessWidget {
  const TimeSlotWidget({
    super.key,
    required this.icon,
    required this.task,
    required this.timeLabel,
    required this.editable, // Flaga określająca aktywną porę dnia
  });

  final Widget icon;
  final String task;
  final String timeLabel;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    final backgroundColor =
        editable ? const Color(0xFFF4F9FF) : theme.secondaryBackground;

    final borderColor = editable ? const Color(0xFF1E88E5) : theme.alternate;
    final borderThickness = editable ? 2.0 : 1.0;

    final accentColor =
        editable ? const Color(0xFF1E88E5) : const Color.fromARGB(255, 0, 0, 0);

    final taskTextColor =
        editable ? theme.primaryText : const Color.fromARGB(255, 0, 0, 0);
    return Container(
      width: double.infinity,
      height: 72.0,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: borderColor,
          width: borderThickness,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Ikona z dynamicznym dopasowaniem koloru (niebieska vs szara)
            Theme(
              data: ThemeData(
                iconTheme: IconThemeData(
                  color: accentColor,
                ),
              ),
              child: icon,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeLabel,
                    style: theme.bodySmall.override(
                      font:
                          GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
                      color:
                          accentColor, // Niebieski dla aktywnego, szary dla reszty
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    task,
                    style: theme.bodyLarge.override(
                      font: GoogleFonts.urbanist(fontWeight: FontWeight.bold),
                      color:
                          taskTextColor, // Czarny dla aktywnego, przygaszony szary dla reszty
                    ),
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
