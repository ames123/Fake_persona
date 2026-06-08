import 'dart:math';
import 'package:flutter/material.dart';
import 'package:schedule_sleuth/room.dart';
import 'package:schedule_sleuth/services/action_service.dart';
import 'package:schedule_sleuth/services/room_service.dart';

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
  Map<String, String> savedUserRoutine = {};

  // POPRAWKA: Globalny rejestr odpowiedzi gracza (Klucz: Nick gracza, Wartość: Wybrany zawód)
  // Przechowywanie danych tutaj gwarantuje, że stan przetrwa zmianę ekranów i będzie identyczny w każdym widżecie.
  final Map<String, String> playerGuesses = {};

  // POPRAWKA: Dynamiczny getter zwracający wszystkie unikalne nazwy zawodów z tabeli do dropdowna
  List<String> get allProfessionOptions => staticRoutines.keys.toList();

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

  List<SlotData> rollNewProfile() {
    final roles = staticRoutines.keys.toList();
    final randomRole = roles[Random().nextInt(roles.length)];
    currentRole = randomRole;
    return getDefaultSlotsForCurrentRole();
  }

  Future<List<SlotData>> getProfileFromApi(String roomCode, String username) async {
    Room fetchedRoom = await RoomService.fetchRoom(roomCode);
    for(var p in fetchedRoom.players){
      if (p.displayName == username) {
        currentRole = p.role!.name;
      }
    }
    return getDefaultSlotsForCurrentRole();
  }

  Future<void> sendRoutineToApi(String roomCode, String username) async{
    await ActionService.finishOrdering(roomCode, username, 
      savedUserRoutine['RANO']!, savedUserRoutine['POŁUDNIE']!, savedUserRoutine['POPOŁUDNIE']!, 
      savedUserRoutine['WIECZÓR']!, savedUserRoutine['NOC']!);
  }

  List<SlotData> getDefaultSlotsForCurrentRole() {
    final routine = staticRoutines[currentRole];
    if (routine == null) return [];

    int idCounter = 1;
    List<SlotData> loadedSlots = [];

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

  void saveFinalRoutine(List<SlotData> orderedSlots) {
    final periods = ['RANO', 'POŁUDNIE', 'POPOŁUDNIE', 'WIECZÓR', 'NOC'];
    savedUserRoutine.clear();

    for (var i = 0; i < orderedSlots.length; i++) {
      if (i < periods.length) {
        savedUserRoutine[periods[i]] = orderedSlots[i].task;
      }
    }
  }
}
