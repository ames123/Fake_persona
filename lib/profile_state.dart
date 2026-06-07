import 'dart:math';
import 'package:flutter/material.dart';
// Zakładam, że SlotData jest zaimportowane lub zdefiniowane globalnie.
// Jeśli masz je w pliku widżetu, profil stanu nie musi importować widżetu,
// ale dla czystości kodu przenieśliśmy strukturę SlotData tutaj.

class SlotData {
  final int id;
  final IconData icon;
  final Color iconColor;
  final String task;

  SlotData({
    required this.id,
    required this.icon,
    required this.iconColor,
    required this.task,
  });
}

class ProfileState {
  static final ProfileState _instance = ProfileState._internal();

  factory ProfileState() {
    return _instance;
  }

  ProfileState._internal();

  // ==========================================
  // ZMIENNE STANU GRACZA (Zapisywane w locie)
  // ==========================================
  String currentRole = 'Nie wylosowano';

  // Tutaj zapiszemy ostateczny, zmieniony przez gracza harmonogram
  // Klucz: Pora dnia (RANO, POŁUDNIE...), Wartość: Czynność ułożona przez gracza
  Map<String, String> savedUserRoutine = {};

  // Mapowanie czynności na ikony, aby widżet wiedział co narysować
  final Map<String, IconData> _taskIcons = {
    'Czytanie': Icons.menu_book_rounded,
    'Czas wolny': Icons.groups_rounded,
    'Pisanie książki': Icons.edit_note_rounded,
    'Oglądanie': Icons.visibility_rounded,
    'Słuchanie muzyki': Icons.music_note_rounded,
    'Mycie': Icons.bathtub_rounded,
    'Trening': Icons.fitness_center_rounded,
    'Sport': Icons.sports_volleyball_rounded,
    'Jedzenie': Icons.restaurant_rounded,
    'Gotowanie': Icons.cookie_rounded,
    'Szukanie zapasów': Icons.search_rounded,
    'Odpoczynek': Icons.bed_rounded,
    'Ścieranie kurzu': Icons.cleaning_services_rounded,
    'Przebieranie się': Icons.checkroom_rounded,
    'Dezynfekcja': Icons.vaccines_rounded,
    'Pielęgnacja roślin': Icons.local_florist_rounded,
    'Kradzież': Icons.local_mall_rounded,
    'Badanie lekarskie': Icons.medical_services_rounded,
    'Granie na PC': Icons.computer_rounded,
    'Eksperyment': Icons.science_rounded,
    'Próba roli': Icons.theater_comedy_rounded,
  };

  // SZTYWNA BAZA HARMONOGRAMÓW RÓL (ŚCIĄGAWKA)
  final Map<String, Map<String, String>> staticRoutines = const {
    'Pisarz': {
      'RANO': 'Czytanie',
      'POŁUDNIE': 'Czas wolny',
      'POPOŁUDNIE': 'Pisanie książki',
      'WIECZÓR': 'Oglądanie',
      'NOC': 'Słuchanie muzyki'
    },
    'Sportowiec': {
      'RANO': 'Mycie',
      'POŁUDNIE': 'Trening',
      'POPOŁUDNIE': 'Sport',
      'WIECZÓR': 'Jedzenie',
      'NOC': 'Czas wolny'
    },
    'Kucharz': {
      'RANO': 'Czas wolny',
      'POŁUDNIE': 'Gotowanie',
      'POPOŁUDNIE': 'Jedzenie',
      'WIECZÓR': 'Szukanie zapasów',
      'NOC': 'Odpoczynek'
    },
    'Sprzątacz': {
      'RANO': 'Ścieranie kurzu',
      'POŁUDNIE': 'Przebieranie się',
      'POPOŁUDNIE': 'Czas wolny',
      'WIECZÓR': 'Dezynfekcja',
      'NOC': 'Słuchanie muzyki'
    },
    'Ogrodnik': {
      'RANO': 'Pielęgnacja roślin',
      'POŁUDNIE': 'Sport',
      'POPOŁUDNIE': 'Ścieranie kurzu',
      'WIECZÓR': 'Czas wolny',
      'NOC': 'Odpoczynek'
    },
    'Złodziej': {
      'RANO': 'Oglądanie',
      'POŁUDNIE': 'Przebieranie się',
      'POPOŁUDNIE': 'Słuchanie muzyki',
      'WIECZÓR': 'Kradzież',
      'NOC': 'Czas wolny'
    },
    'Lekarz': {
      'RANO': 'Badanie lekarskie',
      'POŁUDNIE': 'Mycie',
      'POPOŁUDNIE': 'Czytanie',
      'WIECZÓR': 'Odpoczynek',
      'NOC': 'Czas wolny'
    },
    'Gamer': {
      'RANO': 'Czas wolny',
      'POŁUDNIE': 'Szukanie zapasów',
      'POPOŁUDNIE': 'Jedzenie',
      'WIECZÓR': 'Granie na PC',
      'NOC': 'Mycie'
    },
    'Naukowiec': {
      'RANO': 'Czytanie',
      'POŁUDNIE': 'Ścieranie kurzu',
      'POPOŁUDNIE': 'Eksperyment',
      'WIECZÓR': 'Czas wolny',
      'NOC': 'Oglądanie'
    },
    'Aktor': {
      'RANO': 'Szukanie zapasów',
      'POŁUDNIE': 'Czas wolny',
      'POPOŁUDNIE': 'Sport',
      'WIECZÓR': 'Przebieranie się',
      'NOC': 'Próba roli'
    },
  };

  // FUNKCJA: Losowanie nowej roli i generowanie dla niej domyślnych slotów
  List<SlotData> rollNewProfile() {
    final roles = staticRoutines.keys.toList();
    final randomRole = roles[Random().nextInt(roles.length)];
    currentRole = randomRole;

    return getDefaultSlotsForCurrentRole();
  }

  // FUNKCJA: Pobieranie domyślnego zestawu zadań dla aktualnej roli
  List<SlotData> getDefaultSlotsForCurrentRole() {
    final routine = staticRoutines[currentRole];
    if (routine == null) return [];

    int idCounter = 1;
    List<SlotData> loadedSlots = [];

    // Mapujemy sztywny harmonogram z tabeli na obiekty SlotData (w domyślnej kolejności)
    routine.forEach((period, taskName) {
      loadedSlots.add(
        SlotData(
          id: idCounter++,
          icon: _taskIcons[taskName] ?? Icons.help_outline_rounded,
          iconColor: Colors.blue,
          task: taskName,
        ),
      );
    });

    return loadedSlots;
  }

  // FUNKCJA: Zapisywanie zmienionego przez gracza harmonogramu
  void saveFinalRoutine(List<SlotData> orderedSlots) {
    final periods = ['RANO', 'POŁUDNIE', 'POPOŁUDNIE', 'WIECZÓR', 'NOC'];
    savedUserRoutine.clear();

    // Ponieważ pory dnia na ekranie są stałe (od góry do dołu), przypisujemy
    // zadania w takiej kolejności, w jakiej ułożył je użytkownik w liście przeciąganej
    for (int i = 0; i < orderedSlots.length; i++) {
      if (i < periods.length) {
        savedUserRoutine[periods[i]] = orderedSlots[i].task;
      }
    }
  }
}
