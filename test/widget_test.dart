import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery/fullscreen_image.dart';
import 'package:image_gallery/image_gallery.dart';

void main() {
  group('GalleryPage widget', () {
    testWidgets('Renders gallery with correct number of images',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GalleryPage()));

      final gridViewFinder = find.byType(GridView);
      expect(gridViewFinder, findsOneWidget);

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsNWidgets(6));
    });
  });

  group('FullscreenImage widget', () {
    testWidgets('Renders fullscreen image with correct image URL',
        (WidgetTester tester) async {
      const imageUrl = 'https://www.example.com/image.jpg';
      await tester.pumpWidget(
          const MaterialApp(home: FullscreenImage(imageUrl: imageUrl)));

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);
      final Image imageWidget = tester.widget(imageFinder);
      expect(imageWidget.image, isA<NetworkImage>());
      expect((imageWidget.image as NetworkImage).url, imageUrl);
    });

    testWidgets('Returns to previous screen when tapped',
        (WidgetTester tester) async {
      const imageUrl = 'https://www.example.com/image.jpg';
      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: const FullscreenImage(imageUrl: imageUrl),
      ));

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(navigatorKey.currentState!.canPop(), isFalse);
    });
  });
}