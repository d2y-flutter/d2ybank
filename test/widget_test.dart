import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:d2ybank/shared/components/buttons/d2y_button.dart';
import 'helpers/pump_app.dart';

void main() {
  group('D2YButton', () {
    testWidgets('renders text correctly', (tester) async {
      await tester.pumpApp(D2YButton(text: 'Press Me', onPressed: () {}));
      expect(find.text('Press Me'), findsOneWidget);
    });

    testWidgets('shows loading indicator', (tester) async {
      await tester.pumpApp(D2YButton(text: 'Submit', isLoading: true, onPressed: () {}));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('calls onPressed', (tester) async {
      bool tapped = false;
      await tester.pumpApp(D2YButton(text: 'Tap', onPressed: () => tapped = true));
      await tester.tap(find.text('Tap'));
      expect(tapped, isTrue);
    });
  });
}
