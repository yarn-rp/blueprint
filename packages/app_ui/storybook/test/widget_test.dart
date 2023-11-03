import 'package:flutter_test/flutter_test.dart';
import 'package:storybook/main.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  group('Storybook', () {
    testWidgets('renders Storybook app', (tester) async {
      await tester.pumpWidget(const StoryBookApp());

      // expect to find a Storybook widget
      expect(find.byType(Storybook), findsOneWidget);
    });
  });
}
