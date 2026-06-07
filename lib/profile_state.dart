class ProfileState {
  // Gwarancja poprawnej alokacji pamięci w JS - brak błędów 'undefined'
  static final ProfileState _instance = ProfileState._internal();

  factory ProfileState() {
    return _instance;
  }

  ProfileState._internal();

  // SZTYWNA BAZA HARMONOGRAMÓW RÓL (ŚCIĄGAWKA) - Dokładnie Twoja tabela 1:1
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
}
