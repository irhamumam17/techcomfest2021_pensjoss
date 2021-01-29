// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:karyain/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'KaryaIn',
//       theme: ThemeData(
//         primarySwatch: Colors.grey,
//         primaryColor: Colors.white,
//         brightness: Brightness.light,
//         backgroundColor: Color(0xFFF4F4FB),
//         accentColor: Color(0xFF5F4BC4),
//         dividerColor: Colors.white54,
//         cardColor: Color(0xFFF8F8FB),
//         unselectedWidgetColor: Colors.black54,
//       ),
//       home: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: [
//               RaisedButton(
//                 child: Text('sigin'),
//                 onPressed: () {
//                   Provider.of<AuthProvider>(context, listen: false)
//                       .signin('ardianbagus7@gmail.com', 'ketupatriyoyo');
//                 },
//               ),
//               RaisedButton(
//                 child: Text('register'),
//                 onPressed: () {
//                   Provider.of<AuthProvider>(context, listen: false).register(
//                       'ardian',
//                       'ardianbagus7@gmail.com',
//                       'ketupatriyoyo',
//                       '',
//                       '');
//                 },
//               ),
//               RaisedButton(
//                 child: Text('logout'),
//                 onPressed: () {
//                   Provider.of<AuthProvider>(context, listen: false).logout();
//                 },
//               ),
//               RaisedButton(
//                 child: Text('get product'),
//                 onPressed: () {
//                   Provider.of<ProductProvider>(context, listen: false)
//                       .getProducts();
//                 },
//               ),
//               RaisedButton(
//                 child: Text('create product'),
//                 onPressed: () {
//                   Provider.of<ProductProvider>(context, listen: false)
//                       .createProduct(
//                     'name',
//                     'description',
//                     'category',
//                     '123456789',
//                     '1000-01-01 00:00:00',
//                     'videoPath',
//                     null,
//                   );
//                 },
//               ),
//               RaisedButton(
//                 child: Text('get transaction'),
//                 onPressed: () {
//                   Provider.of<TransactionProvider>(context, listen: false)
//                       .getTransaction();
//                 },
//               ),
//               RaisedButton(
//                 child: Text('checkout'),
//                 onPressed: () {
// Provider.of<TransactionProvider>(context, listen: false)
//     .checkout(
//   3,
//   1,
//   250000,
//   'status',
//   'mantap',
// );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
