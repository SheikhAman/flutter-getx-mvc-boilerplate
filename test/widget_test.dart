import 'package:flutter_core/app/core/network/api_constants.dart';
import 'package:flutter_core/app/core/utils/formatters.dart';
import 'package:flutter_core/app/core/utils/validators.dart';
import 'package:flutter_core/app/data/models/post_model.dart';
import 'package:flutter_core/app/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Core Unit Tests', () {
    test('ApiConstants demo credentials', () {
      expect(ApiConstants.demoOtp, '112345');
      expect(ApiConstants.baseUrl, isNotEmpty);
    });

    test('Validators validation rules', () {
      expect(Validators.required(''), isNotNull);
      expect(Validators.required('Valid text'), isNull);

      expect(Validators.email('invalid-email'), isNotNull);
      expect(Validators.email('valid@fluttercore.dev'), isNull);

      expect(Validators.phone('123'), isNotNull);
      expect(Validators.phone('+15551234567'), isNull);

      expect(Validators.password('123'), isNotNull);
      expect(Validators.password('secret123'), isNull);

      expect(Validators.otp('123'), isNotNull);
      expect(Validators.otp('112345'), isNull);
    });

    test('Formatters data formatting', () {
      expect(Formatters.capitalize('hello'), 'Hello');
      expect(Formatters.compactNumber(1500), '1.5K');
      expect(Formatters.maskPhone('+15551234567'), startsWith('+15'));
    });

    test('UserModel serialization', () {
      final user = UserModel(
        id: 'usr_1',
        name: 'Alex Johnson',
        email: 'alex@fluttercore.dev',
        phone: '+1 555-0199',
        role: 'member',
      );

      final json = user.toJson();
      expect(json['id'], 'usr_1');
      expect(json['name'], 'Alex Johnson');

      final fromJson = UserModel.fromJson(json);
      expect(fromJson.id, user.id);
      expect(fromJson.email, user.email);
    });

    test('PostModel serialization', () {
      final post = PostModel(
        id: 1,
        userId: 42,
        title: 'Enterprise Architecture',
        body: 'Modular GetX MVC+S delivers superior velocity.',
        likesCount: 25,
      );

      final json = post.toJson();
      expect(json['id'], 1);
      expect(json['userId'], 42);

      final fromJson = PostModel.fromJson(json);
      expect(fromJson.title, post.title);
      expect(fromJson.body, post.body);
    });
  });
}
