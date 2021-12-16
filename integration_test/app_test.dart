import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todos/main.dart' as app;

import 'pages/home_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();

      // Finds the floating action button to tap on.
      var homeScreen = HomeScreen(tester);
      var addUpdateScreen = await homeScreen.goToCreateTodoScreen();
      homeScreen = await addUpdateScreen.fillTodoAndSubmit("task", "note");

      addUpdateScreen = await homeScreen.goToCreateTodoScreen();
      homeScreen = await addUpdateScreen.fillTodoAndSubmit("task 2", "note 2");

      await homeScreen.updateStatusTodo(homeScreen.findTodoByTask("task"));
      homeScreen.verifItems(1, (todo) => todo.complete);
      homeScreen.verifItems(1, (todo) => !todo.complete);

      // check incompletes
      await homeScreen.switchTap(1);
      homeScreen.verifyAllItemsStatus(1, false);

      // check completes
      await homeScreen.switchTap(2);
      homeScreen.verifyAllItemsStatus(1, true);

      addUpdateScreen = await homeScreen
          .goToUpdateTodoScreen(homeScreen.findTodoByTask("task"));
      homeScreen = await addUpdateScreen.fillTodoAndSubmit("task 3", "note 3");

      homeScreen.verifItems(1, (todo) => todo.task == "task 3");

      await homeScreen.switchTap(0);
      await homeScreen.deleteTodo(homeScreen.findTodoByTask("task 3"));
      await homeScreen.deleteTodo(homeScreen.findTodoByTask("task 2"));

      homeScreen.verifItems(0, (_) => true);
    });
  });
}
