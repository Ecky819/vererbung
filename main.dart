import 'dart:io';
import 'dart:math';

late int spielfeldGroesse;
const int anzahlSpieler = 2;
const Map<String, int> schiffsKlassen = {'Zerstörer': 2, 'Kreuzer': 3};

late List<List<List<String>>> spielfelder;
late List<List<List<bool>>> schiffePosition;
late List<int> punkte;
late List<int> schuesse;
bool spielLaeuft = true;
int aktuellerSpieler = 0;
final File highscoreDatei = File('highscore.txt');

void zeigeBegruessung() {
  print("""
╔════════════════════════════════════════╗
║       🛥️  SCHIFFE VERSENKEN  🎯        ║
╚════════════════════════════════════════╝
Ziel: Versenke alle Schiffe des Gegners!
""");
}

void zeigeAbschied() {
  print("\nDanke fürs Spielen! Auf Wiedersehen!");
}

void zeigeSieger() {
  int maxPunkte = punkte.reduce(max);
  List<int> gewinner = [];
  for (int i = 0; i < punkte.length; i++) {
    if (punkte[i] == maxPunkte) {
      gewinner.add(i + 1);
    }
  }
  print("\n🏆 Gewinner: Spieler \${gewinner.join}");
  print("🎉 TÖRÖÖÖ! 🎉");
}

void zeigeStatistik() {
  print("\n📊 Spielstatistik:");
  for (int i = 0; i < anzahlSpieler; i++) {
    double trefferquote =
        (punkte[i] / (schuesse[i] == 0 ? 1 : schuesse[i]) * 100);
    print(
      "Spieler ${i + 1}: ${punkte[i]} Treffer bei ${schuesse[i]} Schüssen ${trefferquote.toStringAsFixed(1)}%)",
    );
  }
}

void schreibeHighscore() {
  int sieger = punkte[0] > punkte[1] ? 1 : 2;
  String eintrag =
      "Spieler $sieger | Treffer: ${punkte[sieger - 1]} | Schüsse: ${schuesse[sieger - 1]} | Größe: $spielfeldGroesse\n";
  highscoreDatei.writeAsStringSync(eintrag, mode: FileMode.append);
  print("\n📝 Highscore aktualisiert.");
}

void platziereSchiffeZufaellig(int spieler) {
  Random rand = Random();
  schiffsKlassen.forEach((typ, groesse) {
    bool platziert = false;
    while (!platziert) {
      int x = rand.nextInt(spielfeldGroesse);
      int y = rand.nextInt(spielfeldGroesse);
      bool horizontal = rand.nextBool();
      if (pruefePlatz(x, y, groesse, horizontal, spieler)) {
        for (int i = 0; i < groesse; i++) {
          int xi = x + (horizontal ? 0 : i);
          int yi = y + (horizontal ? i : 0);
          schiffePosition[spieler][xi][yi] = true;
        }
        platziert = true;
      }
    }
  });
}

bool pruefePlatz(int x, int y, int groesse, bool horizontal, int spieler) {
  for (int i = 0; i < groesse; i++) {
    int xi = x + (horizontal ? 0 : i);
    int yi = y + (horizontal ? i : 0);
    if (xi >= spielfeldGroesse ||
        yi >= spielfeldGroesse ||
        schiffePosition[spieler][xi][yi]) {
      return false;
    }
  }
  return true;
}

void zeigeSpielfeld(int spieler) {
  int gegner = (spieler + 1) % anzahlSpieler;
  print("\n🧭 Gegnerisches Feld von Spieler ${gegner + 1}:");
  print("   ${List.generate(spielfeldGroesse, (i) => i).join(' ')}");
  for (int i = 0; i < spielfeldGroesse; i++) {
    stdout.write("$i  ");
    for (int j = 0; j < spielfeldGroesse; j++) {
      String zelle = spielfelder[gegner][i][j];
      stdout.write("${zelle == '🚢' ? '🌊' : zelle} ");
    }
    print("");
  }

  print("\n🛡️  Eigenes Feld von Spieler ${spieler + 1}:");
  print("   ${List.generate(spielfeldGroesse, (i) => i).join(' ')}");
  for (int i = 0; i < spielfeldGroesse; i++) {
    stdout.write("$i  ");
    for (int j = 0; j < spielfeldGroesse; j++) {
      if (spielfelder[spieler][i][j] == 'X') {
        stdout.write("🔥 ");
      } else if (spielfelder[spieler][i][j] == 'o') {
        stdout.write("💦 ");
      } else if (schiffePosition[spieler][i][j]) {
        stdout.write("🚢 ");
      } else {
        stdout.write("🌊 ");
      }
    }
    print("");
  }
}

void macheZug(int spieler) {
  int gegner = (spieler + 1) % anzahlSpieler;
  print("\nSpieler ${spieler + 1}, du bist am Zug!");
  int x = leseZahl("Reihe (0-${spielfeldGroesse - 1}):");
  int y = leseZahl("Spalte (0-${spielfeldGroesse - 1}):");
  schuesse[spieler]++;

  if (spielfelder[gegner][x][y] != '🌊') {
    print("⚠️  Diese Stelle wurde bereits beschossen.");
    return;
  }

  if (schiffePosition[gegner][x][y]) {
    spielfelder[gegner][x][y] = 'X';
    punkte[spieler]++;
    print("🔥 BOOM! Treffer!");
  } else {
    spielfelder[gegner][x][y] = 'o';
    print("💦 Platsch... daneben.");
  }
}

bool istSpielVorbei() {
  int gesamtTreffer = schiffsKlassen.values.reduce((a, b) => a + b);
  return punkte.any((p) => p >= gesamtTreffer);
}

int leseZahl(String aufforderung) {
  int? zahl;
  do {
    stdout.write("$aufforderung ");
    String? eingabe = stdin.readLineSync();
    zahl = int.tryParse(eingabe ?? '');
  } while (zahl == null || zahl < 2 || zahl > 10);
  return zahl;
}

// Hauptfunktion, die das Spiel startet
void main() {
  zeigeBegruessung();
  spielfeldGroesse = leseZahl("Wähle die Spielfeldgröße (z.B. 5 für 5x5):");

  spielfelder = List.generate(
    anzahlSpieler,
    (_) => List.generate(
      spielfeldGroesse,
      (_) => List.filled(spielfeldGroesse, '🌊'),
    ),
  );

  schiffePosition = List.generate(
    anzahlSpieler,
    (_) => List.generate(
      spielfeldGroesse,
      (_) => List.filled(spielfeldGroesse, false),
    ),
  );

  punkte = List.filled(anzahlSpieler, 0);
  schuesse = List.filled(anzahlSpieler, 0);

  for (int i = 0; i < anzahlSpieler; i++) {
    print("Spieler ${i + 1}, Schiffe werden automatisch platziert...");
    platziereSchiffeZufaellig(i);
    print("Fertig!");
  }

  while (spielLaeuft) {
    zeigeSpielfeld(aktuellerSpieler);
    macheZug(aktuellerSpieler);
    if (istSpielVorbei()) {
      zeigeSieger();
      zeigeStatistik();
      schreibeHighscore();
      spielLaeuft = false;
    } else {
      aktuellerSpieler = (aktuellerSpieler + 1) % anzahlSpieler;
    }
  }
  zeigeSieger();
  zeigeStatistik();
  schreibeHighscore();
  zeigeAbschied();
}
