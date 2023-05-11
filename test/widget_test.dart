import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_gallery/fullscreen_image.dart';
import 'package:image_gallery/image_gallery.dart';

void main() {
  group('GalleryPage widget', () {
    setUpAll(() => HttpOverrides.global = null);
    testWidgets('Renders gallery with correct number of images',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GalleryPage()));

      final gridViewFinder = find.byType(GridView);
      expect(gridViewFinder, findsOneWidget);
      final imageFinder = find.byType(Image);
      expect(imageFinder, findsNWidgets(6));
    });

    testWidgets('Navigates to FullscreenImage widget when image is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GalleryPage()));

      final imageFinder = find.byType(Image).first;
      expect(imageFinder, findsOneWidget);

      await tester.tap(imageFinder);
      await tester.pumpAndSettle();

      expect(find.byType(FullscreenImage), findsOneWidget);
    });
  });

  group('FullscreenImage widget', () {
    testWidgets('Renders fullscreen image with correct image URL',
        (WidgetTester tester) async {
      const imageUrl =
          'https://images.unsplash.com/photo-1683464623235-d165004a9e75?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=600&q=60';
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
      const imageUrl =
          'https://images.unsplash.com/photo-1683464623235-d165004a9e75?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=600&q=60';
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
