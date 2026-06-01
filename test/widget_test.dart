// Test de fumée basique pour FuelTrack.
import 'package:flutter_test/flutter_test.dart';

import 'package:fuel_track/core/utils/consumption_calculator.dart';

void main() {
  test('Détection d\'anomalie de consommation (+20%)', () {
    // Moyenne 6 L/100km, seuil 20% => anomalie au-dessus de 7.2.
    expect(ConsumptionCalculator.estAnormale(7.5, 6, 20), isTrue);
    expect(ConsumptionCalculator.estAnormale(6.5, 6, 20), isFalse);
  });
}
