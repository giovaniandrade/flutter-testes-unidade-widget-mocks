import 'package:estilizacao_componentes/components/box_card.dart';
import 'package:estilizacao_componentes/data/bank_http.mocks.dart';
import 'package:estilizacao_componentes/data/bank_inherited.dart';
import 'package:estilizacao_componentes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  // Para encontrar outros finders:
  // https://api.flutter.dev/flutter/flutter_test/CommonFinders-class.html

  // Para encontrar outros matchers:
  // https://docs.flutter.dev/cookbook/testing/widget/introduction#additional-matchers

  // Para encontrar outras ações:
  // https://docs.flutter.dev/cookbook/testing/widget/tap-drag
  // https://docs.flutter.dev/cookbook/testing/widget/scrolling

  final MockBankHttp httpMock = MockBankHttp();

  // Teste de Widget
  // pumpWidget rendereiza o widget para testar
  testWidgets('My widget has a text "Spent"', (robozinho) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => '5');

    await robozinho.pumpWidget(MaterialApp(
      home: BankInherited(
          child: Home(
        api: httpMock.dolarToReal(),
      )),
    ));

    // Procurador (procurando a palavra Spent)
    final spentFinder = find.text('Spent');

    // Espera encontrar 1 widget
    expect(spentFinder, findsOneWidget);
  });

  testWidgets('Finds a LinearProgressIndicator', (tester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => '5');

    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
          child: Home(
        api: httpMock.dolarToReal(),
      )),
    ));

    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('Finds a testKey', (tester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => '5');

    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
          child: Home(
        api: httpMock.dolarToReal(),
      )),
    ));

    expect(find.byKey(const Key('testKey')), findsOneWidget);
  });

  testWidgets('Finds 5 BoxCards', (tester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => '5');

    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
          child: Home(
        api: httpMock.dolarToReal(),
      )),
    ));

    expect(find.byWidgetPredicate((widget) {
      if (widget is BoxCard) {
        return true;
      }
      return false;
    }), findsNWidgets(5));
  });

  testWidgets('When tap Deposit should upload earned in 10', (tester) async {
    when(httpMock.dolarToReal()).thenAnswer((_) async => '5');

    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(
          api: httpMock.dolarToReal(),
        ),
      ),
    ));

    // Importante: 'await' vai fazer ele esperar o clique
    await tester.tap(find.text('Deposit'));
    await tester.tap(find.text('Earned'));

    // Importante: isso atualiza a tela e espera todos os microserviços terminarem
    await tester.pumpAndSettle();

    expect(find.text('\$10.0'), findsOneWidget);
  });

  testWidgets('Testing MockHttp dolarToReal', (tester) async {
    // _ nome privado no parametro do thenAnswer
    // Isso é um Stub, ou seja, quando chamar dolarToReal do mock, responder com '5'
    when(httpMock.dolarToReal()).thenAnswer((_) async => '5');

    await tester.pumpWidget(MaterialApp(
      home: BankInherited(
        child: Home(
          api: httpMock.dolarToReal(),
        ),
      ),
    ));

    // Verificar qual a função que foi chamada
    verify(httpMock.dolarToReal()).called(6);
  });
}
