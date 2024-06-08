import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_tasks/presentation/screens/task_screen.dart';

void main() {
  testWidgets('Add and delete task', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: TaskScreen(),
        ),
      ),
    );

    final taskTitleField = find.byType(TextField);
    await tester.enterText(taskTitleField, 'New Task');

    final addButton = find.byIcon(Icons.add);
    await tester.tap(addButton);

    await tester.pumpAndSettle();

    expect(find.text('New Task'), findsOneWidget);

    expect(find.byIcon(Icons.delete), findsWidgets);

    final deleteButton = find.byIcon(Icons.delete).first;
    await tester.tap(deleteButton);

    await tester.pumpAndSettle();

    expect(find.text('New Task'), findsNothing);
  });
}
