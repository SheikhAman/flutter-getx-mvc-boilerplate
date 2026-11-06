## Description
<!-- Provide a concise summary of the changes introduced in this PR. -->

## Type of Change
- [ ] 🚀 New feature (non-breaking change which adds functionality)
- [ ] 🐛 Bug fix (non-breaking change which fixes an issue)
- [ ] ♻️ Refactoring (code improvement without functional change)
- [ ] 📝 Documentation update
- [ ] 🧪 Tests (adding missing tests or fixing existing tests)
- [ ] 🔧 Chore / Build / CI configuration

## Architecture Compliance
- [ ] Follows Modular GetX (MVC+S) directory structure under `lib/app/modules/` or `lib/app/core/`
- [ ] Dependencies wired via `Bindings` and `Get.lazyPut`
- [ ] Reactive state managed in Controller; View remains declarative (`GetView`)

## How Has This Been Tested?
<!-- Describe the tests you ran to verify your changes. Include unit, widget, or manual emulator verification steps. -->

## Quality Checklist
- [ ] `dart format --output=none --set-exit-if-changed .` passes with zero formatting issues
- [ ] `flutter analyze` passes with **0 errors and 0 warnings**
- [ ] `flutter test` passes with all tests green
- [ ] Any added controller/widget includes corresponding tests in `test/`
- [ ] Documentation updated in `README.md` (if applicable)
