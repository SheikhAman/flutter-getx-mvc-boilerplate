import 'package:flutter/material.dart';
import 'package:flutter_getx_mvc_boilerplate/app/core/values/app_strings.dart';
import 'package:flutter_getx_mvc_boilerplate/app/data/models/post_model.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/post_detail/controllers/post_detail_controller.dart';
import 'package:flutter_getx_mvc_boilerplate/app/modules/post_detail/views/post_detail_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestHost(Widget child) {
    return GetMaterialApp(
      translations: AppStrings(),
      locale: const Locale('en', 'US'),
      home: child,
    );
  }

  group('PostDetailView Widget Tests', () {
    testWidgets('renders SliverAppBar with high-contrast title and icons',
        (tester) async {
      final post = PostModel(
        id: 1,
        userId: 1,
        title: 'Sunt aut facere repellat provident',
        body: 'quia et suscipit suscipit recusandae',
        authorName: 'Author #1',
        createdAt: DateTime(2026, 11, 15, 21, 0),
        likesCount: 7,
      );

      final controller = PostDetailController();
      controller.post.value = post;
      controller.isLoading.value = false;
      Get.put<PostDetailController>(controller);

      await tester.pumpWidget(buildTestHost(const PostDetailView()));
      await tester.pumpAndSettle();

      // Title should be visible
      expect(find.text('Post #1'), findsOneWidget);

      // Verify SliverAppBar properties
      final sliverAppBar =
          tester.widget<SliverAppBar>(find.byType(SliverAppBar));
      expect(sliverAppBar.pinned, isTrue);
      expect(sliverAppBar.foregroundColor, Colors.white);
      expect(sliverAppBar.surfaceTintColor, Colors.transparent);

      // Scroll up to collapse SliverAppBar
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Title must still be present and not blend into background
      expect(find.text('Post #1'), findsOneWidget);
    });
  });
}
