import 'package:flutter_test/flutter_test.dart';
import 'package:garden_planner/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GardenPlannerApp());
  });
}