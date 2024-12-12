//! Yetişmedi ancak daha önceki projelerimde yazdığım testleri aşağıdaki gibidir!.

/*
void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("should be disabled the continue button on start", (tester) async {
    await app.main(); // start the app

    await tester.pumpAndSettle();

    final Finder buttonContinue = find.byType(PrimaryButtonIcon);

    expect(buttonContinue, findsOneWidget);

    final PrimaryButtonIcon buttonWidget = tester.widget<PrimaryButtonIcon>(buttonContinue);

    bool isButtonEnabled = buttonWidget.onPressed != null;

    expect(isButtonEnabled, false);
  });
}
*/