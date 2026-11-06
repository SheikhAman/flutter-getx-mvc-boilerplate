# Contributing to Flutter GetX MVC Boilerplate

Thank you for your interest in contributing! This project is maintained as an open-source, modular Flutter template. Following these guidelines helps maintain code quality, architecture consistency, and smooth reviews.

---

## 🚀 Getting Started

### 1. Fork & Clone
Fork the repository on GitHub and clone your fork locally:
```bash
git clone https://github.com/<your-username>/flutter-getx-mvc-boilerplate.git
cd flutter-getx-mvc-boilerplate
```

### 2. Environment Setup
Verify you have the required environment:
- **Flutter SDK:** `>=3.3.0` (Tested on `3.41.9` stable)
- **Dart SDK:** `3.11.5`

Install project dependencies:
```bash
flutter pub get
```

---

## 🌿 Branch Naming Conventions

Create a feature or fix branch from `main`:
```bash
git checkout -b <type>/<short-description>
```

Recommended prefix types:
* `feat/` — A new feature, module, or user-facing addition
* `fix/` — Bug fixes or UI issue corrections
* `refactor/` — Code improvement without feature additions
* `test/` — Adding or improving unit/widget tests
* `docs/` — Documentation updates or guides
* `chore/` — Maintenance, dependencies, or tooling updates

*Example:* `feat/add-notification-module` or `fix/otp-timer-cleanup`

---

## 📐 Architecture & Coding Standards

1. **Modular GetX Pattern:**
   * Place feature modules under `lib/app/modules/<feature_name>/` containing `bindings/`, `controllers/`, `providers/`, and `views/`.
   * Keep views purely declarative (`GetView<T>`).
   * Put persistent cross-cutting concerns into `lib/app/core/services/` as `GetxService`.
2. **No Clean Architecture Domain Leakage:**
   * Do not introduce abstract Domain/UseCases layers; keep business logic directly in GetX controllers.
3. **Format Before Commit:**
   Always format code before committing:
   ```bash
   dart format .
   ```
4. **Static Analysis & Linting:**
   Ensure zero errors and zero warnings:
   ```bash
   flutter analyze
   ```

---

## 🧪 Testing Before PR

Every PR must maintain or improve test stability:
```bash
# Run complete test suite
flutter test

# Verify line coverage locally
flutter test --coverage
```

---

## 📥 Submitting a Pull Request

1. Push your branch to your GitHub fork:
   ```bash
   git push origin <type>/<short-description>
   ```
2. Open a Pull Request against the `main` branch of `SheikhAman/flutter-getx-mvc-boilerplate`.
3. Fill out the provided **Pull Request Template** completely.
4. Ensure all automated GitHub Actions CI checks (`dart format`, `flutter analyze`, `flutter test`) pass.
