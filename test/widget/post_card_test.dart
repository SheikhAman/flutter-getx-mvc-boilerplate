import 'package:flutter/material.dart';
import 'package:flutter_core/app/core/routes/app_routes.dart';
import 'package:flutter_core/app/data/models/post_model.dart';
import 'package:flutter_core/app/modules/home/widgets/post_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  tearDown(() {
    Get.reset();
  });

  const samplePost = PostModel(
    id: 101,
    userId: 42,
    title: 'Testing Modular Architecture with GetX',
    body: 'Clean separation of concerns improves code maintainability.',
    likesCount: 128,
  );

  Widget buildTestableWidget(Widget child) {
    return GetMaterialApp(
      home: Scaffold(
        body: child,
      ),
      getPages: [
        GetPage(
          name: AppRoutes.postDetail,
          page: () => const Scaffold(body: Text('Post Detail Screen')),
        ),
      ],
    );
  }

  group('PostCard Widget Tests', () {
    testWidgets('displays post title, body, user badge and metrics',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(buildTestableWidget(const PostCard(post: samplePost)));

      expect(
          find.text('Testing Modular Architecture with GetX'), findsOneWidget);
      expect(
          find.text(
              'Clean separation of concerns improves code maintainability.'),
          findsOneWidget);
      expect(find.text('#42'), findsOneWidget);
    });

    testWidgets('navigates to postDetail route when tapped',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(buildTestableWidget(const PostCard(post: samplePost)));

      await tester.tap(find.byType(PostCard));
      await tester.pumpAndSettle();

      expect(find.text('Post Detail Screen'), findsOneWidget);
    });
  });
}
