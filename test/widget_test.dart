import 'package:flutter_test/flutter_test.dart';

import 'package:smart_retina_app/main.dart';

void main() {
  testWidgets('Smart Retina app renders the home screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SmartRetinaApp());

    expect(find.text('Smart Retina'), findsWidgets);
    expect(find.text('Upload Retinal Image'), findsOneWidget);
    expect(find.text('Why Choose Our AI?'), findsOneWidget);
  });
}
