import 'dart:async';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:fordev/ui/pages/pages.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock.dart';

void main() {
  late LoginPresenter presenter;
  late StreamController<String> emailErrorController;

  Future<void> loadPage(WidgetTester tester) async {
      presenter = LoginPresenterSpy();
      emailErrorController = StreamController<String>();
      when(() => presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);

      final loginPage = MaterialApp(home: LoginPage(presenter) );
      await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
}); 

  testWidgets('Should load with correct initial state', (WidgetTester tester) async {
      await loadPage(tester);

      final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
      expect(
        emailTextChildren, 
        findsOneWidget,
        reason: 'when a TextformField has only one child, means it has no erros, since one of the childs is always the label text');

      final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
      expect(
        passwordTextChildren, 
        findsOneWidget,
        reason: 'when a TextformField has only one child, means it has no erros, since one of the childs is always the label text');
    
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, null);
  });

  testWidgets('Should call validate  with correct values', ( WidgetTester tester ) async {
    await  loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText((find.bySemanticsLabel('Email')), email);
    verify(() => presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText((find.bySemanticsLabel('Senha')), password);
    verify(() => presenter.validatePassword(password));

  });

  testWidgets('Should presente error if email is invalid', ( WidgetTester tester ) async {
    await  loadPage(tester);

    emailErrorController.add('any_error');
    await tester.pump();

    expect(find.text('any_error'), findsOneWidget);
 
  });

  testWidgets('Should presente no error if email is valid', ( WidgetTester tester ) async {
    await  loadPage(tester);

    emailErrorController.add('');
    await tester.pump();

    expect(
      find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)), 
      findsOneWidget,
    );
  });
}  