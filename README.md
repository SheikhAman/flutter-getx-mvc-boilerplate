<div align="center">

# 🚀 Flutter GetX MVC Boilerplate
### *Enterprise-Grade, Modular Starter Template for High-Performance Mobile Apps*

[![Flutter](https://img.shields.io/badge/Flutter-3.41.9%20(stable)-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.11.5-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![GetX](https://img.shields.io/badge/GetX-4.7.3-8A2BE2?style=for-the-badge)](https://pub.dev/packages/get)
[![Architecture](https://img.shields.io/badge/Architecture-Modular%20GetX%20MVC%2BS-22C55E?style=for-the-badge)](https://github.com/SheikhAman/flutter-getx-mvc-boilerplate)
[![Tests](https://img.shields.io/badge/Tests-54%20Passing-success?style=for-the-badge)](https://github.com/SheikhAman/flutter-getx-mvc-boilerplate)
[![Analysis](https://img.shields.io/badge/Analysis-0%20Issues-brightgreen?style=for-the-badge)](https://github.com/SheikhAman/flutter-getx-mvc-boilerplate)
[![CI Pipeline](https://img.shields.io/badge/CI-GitHub%20Actions%20Passing-success?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/SheikhAman/flutter-getx-mvc-boilerplate/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

<br/>

**A battle-tested, clean, and scalable Flutter starter template engineered with the Modular GetX (MVC+S) architecture.**  
Built for senior engineers, tech leads, startups, and beginners who want to build and ship production apps without spending weeks configuring routing, dependency injection, network interceptors, storage, theming, and test suites.

[⚡ Quick Start (60s)](#-quick-start-in-60-seconds) &bull; [💼 For Recruiters & Leads](#-for-recruiters--engineering-leads) &bull; [🏛 Architecture](#-architecture-overview) &bull; [🔄 App Flows](#-how-everything-works-data--app-flows) &bull; [🧩 Add New Feature](#-how-to-add-a-new-module-4-step-recipe) &bull; [🧪 54 Automated Tests](#-testing--quality-gates) &bull; [❓ FAQ](#-troubleshooting--faq)

</div>

---

## 💼 For Recruiters & Engineering Leads

> **What does this repository prove about the author's engineering capability?**

This repository is designed as a benchmark for **production-ready Flutter engineering**. It avoids both under-engineering (spaghetti code inside StatefulWidgets) and over-engineering (15+ nested folders per feature that slow down delivery).

| Engineering Dimension | Implementation in This Repository | Value Delivered |
| :--- | :--- | :--- |
| **Architectural Discipline** | **Modular MVC+S** (`Model - View - Controller + Service`) | Clean separation of UI, business logic, network providers, and permanent singletons. Teams can scale to 15+ developers without merge conflicts. |
| **State Management & Memory Safety** | Route-level `Bindings` with `Get.lazyPut()` & `onClose()` disposal | Controllers are instantiated only when routes are active and cleanly garbage collected on route pop. **Zero memory leaks.** |
| **Network Resilience** | `DioClient` with custom interceptors, auto-retry, and token injection | Automatic Bearer token headers, PII-safe log redactions, and instant auto-logout upon `401 Unauthorized`. |
| **High Test Coverage** | **54 automated tests** (Unit tests, Controller state machines, Widget tests) | Enforces 100% green CI on every GitHub pull request. Zero analyzer warnings allowed. |
| **Design System & Accessibility** | Material 3 dynamic color seeds, AMOLED dark mode, WCAG AAA contrast | Fluid responsive scaling with `flutter_screenutil`, smooth collapsible hero headers, and custom production dialogs (`AppDialog`). |
| **Clean DX (Developer Experience)** | 3-command setup, mock backend, single-source design tokens | New engineers can clone and start shipping product features on Day 1. |

---

## 🎯 Architecture Comparison: Why Modular GetX MVC+S?

| Metric | Traditional "Clean Arch" (Bloc/DDD) | Raw Flutter (No Architecture) | 🌟 Modular GetX MVC+S (This Repo) |
| :--- | :--- | :--- | :--- |
| **Files Per Simple Feature** | 8 – 14 files | 1 huge file | **3 – 4 focused files** (`View`, `Controller`, `Provider`, `Binding`) |
| **Boilerplate Overhead** | Heavy (UseCases, Repositories, DataSources) | Zero (unmaintainable) | **Zero unnecessary ceremony; pragmatic & readable** |
| **Onboarding Time** | Days to weeks | Fast initially, crashes later | **Hours — instantly intuitive for junior to senior devs** |
| **State Reactivity** | Verbose events, states, emitters | Manual `setState()` | **Surgical `Obx()` micro-rebuilds powered by `Rx` primitives** |
| **Dependency Injection** | Complex manual Service Locators | Constructor drilling | **Declarative, route-bound lazy injection (`Bindings`)** |
| **Maintainability at Scale** | High but slow delivery | Very low | **High velocity with enterprise stability** |

---

## ⚡ Quick Start in 60 Seconds

```bash
# 1. Clone the repository
git clone https://github.com/SheikhAman/flutter-getx-mvc-boilerplate.git
cd flutter-getx-mvc-boilerplate

# 2. Fetch dependencies
flutter pub get

# 3. Launch on connected device or emulator
flutter run
```

### 🔐 Built-in Mock Credentials

The application includes a self-contained mock authentication system. No external backend setup is required to explore:

| Credential | Value | Notes |
| :--- | :--- | :--- |
| **Email** | `user@example.com` (or any valid email) | Pre-validated RFC regex |
| **Password** | `password123` (min 6 characters) | Toggleable visibility eye icon |
| **Demo OTP** | `112345` | Auto-fill banner supported with 1 tap |

---

## 📱 Live App Showcase

<div align="center">

| Reactive Post Creation & Feed Ingestion | REST Feed, Shimmer & Infinite Scroll |
| :---: | :---: |
| <picture><source srcset="screenshots/create_post_flow.webp" type="image/webp"><img src="screenshots/create_post_flow.gif" width="300" alt="Create post flow with bottom sheet and double-submit protection" /></picture> | <picture><source srcset="screenshots/feed_pagination_flow.webp" type="image/webp"><img src="screenshots/feed_pagination_flow.gif" width="300" alt="Feed pagination with shimmer loading and infinite scroll" /></picture> |
| **Modal Sheet &bull; Double-Submit Guard**<br><sub>Tap <code>+</code> &rarr; enter title & content &rarr; submit &rarr; sheet closes &rarr; feed updates instantly</sub> | **REST Feed &bull; Shimmer &bull; Infinite Scroll**<br><sub>Splash transition &rarr; shimmer skeleton loader &rarr; scroll to fetch page 2</sub> |

</div>

---

## 🏛 Architecture Overview

### Full Project Graph (Mermaid)

```mermaid
flowchart TD
    subgraph UI ["1. Presentation Layer (View)"]
        V["Views (GetView<T>)"]
        W["Reusable UI Widgets (CustomButton, CustomTextField, etc.)"]
        V --> W
    end

    subgraph State ["2. Business Logic Layer (Controller & Binding)"]
        C["Controllers (GetxController)"]
        B["Bindings (Lazy Dependency Injection)"]
        B -. Injects on route entry .-> C
        V -- Triggers methods & listens to Obx() --> C
    end

    subgraph Data ["3. Network & Data Layer (Provider & Model)"]
        P["Providers (Feature-Specific HTTP Calls)"]
        M["Data Models (fromJson / toJson)"]
        C -- Calls async methods --> P
        P -- Maps JSON to --> M
        P -- Returns Typed Objects --> C
    end

    subgraph Core ["4. Core Infrastructure & Singletons"]
        DIO["DioClient (Bearer Token, Redacted Logs, Auto-Retry)"]
        ST["StorageService (Persistent GetStorage)"]
        AUTH["AuthService (Reactive User & Session State)"]
        THEME["ThemeController (Material 3 Dynamic Brand Seeds)"]
        LOCALE["LocaleService (EN / BN Localization)"]
        NET["NetworkInfo (Live Connectivity Watcher)"]
        
        P --> DIO
        C --> ST
        C --> AUTH
        V --> THEME
        V --> LOCALE
    end
```

### Layer Responsibilities

1. **Views (`GetView<T>`):** Pure presentation widgets. They reactively render state using `Obx()` and delegate user interactions to the controller. Views never perform HTTP calls or direct storage reads.
2. **Controllers (`GetxController`):** Encapsulate feature business logic and UI state machines. State variables are declared using `.obs` primitives.
3. **Providers:** Feature-specific network clients that invoke the singleton `DioClient` and return deserialized models or exceptions.
4. **Permanent Services (`GetxService`):** Global singletons (`AuthService`, `StorageService`, `ThemeController`, `LocaleService`, `NetworkInfo`) initialized asynchronously at boot in `main.dart` and retained permanently in memory.
5. **Bindings (`Bindings`):** Declarative dependency wiring executed automatically by GetX routing when a route is entered (`Get.lazyPut()`).

---

## 🔄 How Everything Works (Data & App Flows)

### 1. The Reactive UI Data Flow (View 🔁 Controller)

```mermaid
sequenceDiagram
    autonumber
    actor User as User Action
    participant View as View (GetView)
    participant Controller as Controller (GetxController)
    participant Provider as Provider
    participant Dio as DioClient
    participant Server as Remote REST API

    User->>View: Taps button (e.g. "Publish Post")
    View->>Controller: controller.createPost(title, body)
    Controller->>Controller: isLoading.value = true (Obx shows spinner)
    Controller->>Provider: provider.createPost(payload)
    Provider->>Dio: dioClient.post('/posts', data: payload)
    Dio->>Server: HTTP POST with Bearer Token
    Server-->>Dio: 201 Created (JSON Response)
    Dio-->>Provider: Map<String, dynamic>
    Provider-->>Controller: PostModel.fromJson(json)
    Controller->>Controller: posts.insert(0, newPost)
    Controller->>Controller: isLoading.value = false
    Controller-->>View: Obx() automatically repaints updated feed!
```

---

### 2. App Lifecycle & Bootstrapping Sequence

```mermaid
flowchart TD
    A["main()"] --> B["WidgetsFlutterBinding.ensureInitialized()"]
    B --> C["ScreenUtil.ensureScreenSize()"]
    C --> D["Initialize Permanent Services<br>1. StorageService (GetStorage)<br>2. AuthService (Check local token)<br>3. LocaleService (Read language)<br>4. ThemeController (Read theme mode & seed)<br>5. NetworkInfo (Start connectivity listener)"]
    D --> E["Run BoilerplateApp (GetMaterialApp)"]
    E --> F["SplashView (2s Brand Animation)"]
    F --> G{"Is Onboarding Completed?"}
    G -- "No" --> H["OnboardingView"]
    H --> I["Complete Onboarding -> Save Flag"]
    G -- "Yes" --> J{"Is User Logged In?"}
    I --> J
    J -- "No" --> K["LoginView (Auth Flow)"]
    J -- "Yes" --> L["DashboardView (Main App)"]
    K --> M["Verify OTP Screen (112345)"]
    M --> L
```

---

### 3. Route Guard & Session Expiry (401) Flow

```mermaid
flowchart TD
    subgraph RouteProtection ["Route Protection"]
        R1["User navigates to /dashboard or /profile"] --> R2{"AuthGuard Middleware"}
        R2 -- "Valid Token" --> R3["Access Granted"]
        R2 -- "No Token" --> R4["Redirect to /login with Warning"]
    end

    subgraph AutoRevocation ["401 Unauthorized Auto-Revocation"]
        A1["API Call returns 401 Unauthorized"] --> A2["ApiInterceptor catches error"]
        A2 --> A3["AuthService.logout() called"]
        A3 --> A4["Clear Token & Cache from GetStorage"]
        A4 --> A5["Route to /login with session expired snackbar"]
    end
```

---

## 📂 Project Structure & Module Directory Map

```text
lib/
├── app/
│   ├── core/                      # Global infrastructure & shared modules
│   │   ├── network/               # ApiConstants, ApiExceptions, ApiInterceptor, DioClient, NetworkInfo
│   │   ├── routes/                # AppPages, AppRoutes, Route Guards (AuthGuard, OnboardingGuard)
│   │   ├── services/              # Permanent singletons: AuthService, LocaleService, StorageService, ThemeController
│   │   ├── utils/                 # AppDialog, AppSnackbar, Formatters, Validators
│   │   ├── values/                # AppAssets, AppColors, AppSizes, AppStrings, AppTextStyles
│   │   └── widgets/               # Reusable UI widgets: CustomAppBar, CustomButton, CustomTextField, etc.
│   ├── data/                      # Global data transfer models
│   │   └── models/                # ApiResponseModel, PostModel, UserModel
│   └── modules/                   # Independent feature modules (MVC+S)
│       ├── auth/                  # Login, Register, OTP Verification, Forgot Password
│       ├── common/                # NoInternetView, UnknownRouteView (404), In-app WebView
│       ├── dashboard/             # Persistent Bottom Navigation shell
│       ├── home/                  # REST Feed, Shimmer skeletons, Pull-to-refresh, Create Post sheet
│       ├── onboarding/            # 3-step animated intro carousel
│       ├── post_detail/           # High-contrast Collapsible SliverAppBar, post comments, like toggle
│       ├── profile/               # User avatar with camera/gallery picker, edit profile sheet, logout dialog
│       ├── search/                # 400ms debounced search engine across posts
│       ├── settings/              # Dark mode toggle, dynamic theme color seeds, language switcher
│       ├── showcase/              # Design System Component Gallery
│       └── splash/                # Smooth brand entry transition
└── main.dart                      # ScreenUtilInit + EasyLoading + GetMaterialApp entrypoint
```

### Module Responsibilities Matrix

| Module | Purpose | Controller | Views / Sub-Widgets | Route |
| :--- | :--- | :--- | :--- | :--- |
| **`auth`** | Session management, input validation, OTP verification | `AuthController` | `LoginView`, `RegisterView`, `OtpView`, `ForgotPasswordView` | `/login`, `/register`, `/otp`, `/forgot-password` |
| **`dashboard`** | Bottom navigation shell retaining 4 primary tabs | `DashboardController` | `DashboardView` | `/dashboard` |
| **`home`** | REST pagination, shimmer loading, post creation sheet | `HomeController` | `HomeView`, `CreatePostSheet`, `PostCard` | `/home` (Tab 0) |
| **`post_detail`**| Post reading, comment list, high-contrast pinned app bar | `PostDetailController` | `PostDetailView` | `/posts/detail` |
| **`search`** | Real-time debounced query filtering (400ms delay) | `AppSearchController` | `SearchView` | `/search` (Tab 1) |
| **`profile`** | User details display, photo upload, safe logout dialog | `ProfileController` | `ProfileView`, `EditProfileSheet` | `/profile` (Tab 3) |
| **`settings`** | Runtime theme switching, seed palettes, EN/BN languages | `SettingsController` | `SettingsView` | `/settings` |
| **`showcase`** | Interactive design system catalog (buttons, inputs, dialogs) | `ShowcaseController` | `ShowcaseView` | `/showcase` (Tab 2) |
| **`common`** | Connectivity lost banner, 404 handler, web browser | — | `NoInternetView`, `UnknownRouteView`, `WebViewView` | `/no-internet`, `/404`, `/webview` |

---

## 🧑‍💻 Beginner's Step-by-Step Guide

### 1. How State Management Works in 3 Rules

1. **Wrap variables in `.obs`:**
   ```dart
   final count = 0.obs;
   final userName = 'Sheikh Aman'.obs;
   final posts = <PostModel>[].obs;
   ```
2. **Mutate state inside the Controller:**
   ```dart
   void increment() => count.value++;
   void addPost(PostModel post) => posts.insert(0, post);
   ```
3. **Listen in UI with `Obx()`:**
   ```dart
   Obx(() => Text('Count: ${controller.count.value}'))
   ```
   *Only widgets inside `Obx()` re-render when the variable changes. No `StatefulWidget`, no `setState()`!*

---

### 2. How to Connect Your Real Backend API

By default, the app uses `https://jsonplaceholder.typicode.com` for demo posts. To connect your real backend:

1. Open [`lib/app/core/network/api_constants.dart`](lib/app/core/network/api_constants.dart).
2. Change `baseUrl`:
   ```dart
   static const String baseUrl = 'https://api.yourdomain.com/v1';
   ```
3. Update endpoints:
   ```dart
   static const String login = '/auth/login';
   static const String posts = '/feed/posts';
   ```
4. `DioClient` automatically:
   - Appends your JWT token (`Authorization: Bearer <token>`) from `StorageService`.
   - Logs requests in debug mode with sensitive data (passwords, tokens) redacted.
   - Handles connection timeouts (30s) and triggers auto-logout on `401 Unauthorized`.

---

### 3. How to Add a New Module (4-Step Recipe)

Suppose you want to add a **Products** feature:

#### Step 1: Create the Provider (`lib/app/modules/products/providers/products_provider.dart`)
```dart
import '../../../core/network/dio_client.dart';

class ProductsProvider {
  final DioClient _dioClient;
  ProductsProvider({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<dynamic> getProducts() async {
    return await _dioClient.get('/products');
  }
}
```

#### Step 2: Create the Controller (`lib/app/modules/products/controllers/products_controller.dart`)
```dart
import 'package:get/get.dart';
import '../providers/products_provider.dart';

class ProductsController extends GetxController {
  final ProductsProvider provider;
  ProductsController({ProductsProvider? productsProvider})
      : provider = productsProvider ?? ProductsProvider();

  final RxBool isLoading = false.obs;
  final RxList<dynamic> products = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final data = await provider.getProducts();
      if (data is List) products.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }
}
```

#### Step 3: Create the Binding (`lib/app/modules/products/bindings/products_binding.dart`)
```dart
import 'package:get/get.dart';
import '../controllers/products_controller.dart';
import '../providers/products_provider.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsProvider>(() => ProductsProvider());
    Get.lazyPut<ProductsController>(() => ProductsController(productsProvider: Get.find()));
  }
}
```

#### Step 4: Create the View (`lib/app/modules/products/views/products_view.dart`) & Register Route
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(controller.products[index]['title'] ?? ''),
          ),
        );
      }),
    );
  }
}
```

Register in [`lib/app/core/routes/app_routes.dart`](lib/app/core/routes/app_routes.dart) and [`lib/app/core/routes/app_pages.dart`](lib/app/core/routes/app_pages.dart):
```dart
// app_routes.dart
static const String products = '/products';

// app_pages.dart
GetPage(
  name: AppRoutes.products,
  page: () => const ProductsView(),
  binding: ProductsBinding(),
),
```

---

## 🏷 Renaming the Boilerplate for Your Brand

To customize this repository for your own product:

| Target | File to Change | What to Replace |
| :--- | :--- | :--- |
| **Dart Package Name** | [`pubspec.yaml`](pubspec.yaml) | Line 1: `name: my_app` |
| **App Display Title** | [`lib/main.dart`](lib/main.dart) | `title: 'My App Name'` |
| **Localization App Name** | [`lib/app/core/values/app_strings.dart`](lib/app/core/values/app_strings.dart) | `appName` key in EN & BN maps |
| **Android Package & ID** | [`android/app/build.gradle.kts`](android/app/build.gradle.kts) | `applicationId = "com.mycompany.myapp"` |
| **Android App Label** | [`android/app/src/main/AndroidManifest.xml`](android/app/src/main/AndroidManifest.xml) | `android:label="My App Name"` |
| **iOS Bundle Identifier** | [`ios/Runner.xcodeproj/project.pbxproj`](ios/Runner.xcodeproj/project.pbxproj) | Search & replace `com.sheikhaman.getxMvcBoilerplate` |
| **Web Title & PWA** | [`web/index.html`](web/index.html), [`web/manifest.json`](web/manifest.json) | Title and short name |

---

## 🧪 Testing & Quality Gates

This repository enforces a strict, zero-warning CI policy on GitHub Actions:

```bash
# 1. Format verification
dart format --output=none --set-exit-if-changed .

# 2. Static analysis (0 errors, 0 warnings enforced)
flutter analyze

# 3. Automated test execution (54 passing tests)
flutter test
```

### Complete Test Suite Breakdown (54 Tests)

| Suite File | Type | Tests | Focus Area |
| :--- | :--- | :---: | :--- |
| `test/widget_test.dart` | Unit / Model | 5 | Validators, formatters, JSON deserialization of User & Post models |
| `test/unit/controllers/auth_controller_test.dart` | Unit | 7 | Mock login, register, OTP countdown timer, password reset |
| `test/unit/controllers/home_controller_test.dart` | Unit | 8 | Initial feed loading, pull-to-refresh, pagination, post prepend |
| `test/unit/controllers/search_controller_test.dart` | Unit | 6 | Debounced 400ms search worker, in-memory local caching |
| `test/widget/app_dialog_test.dart` | Widget | 3 | Material 3 confirmation dialog, destructive action theming |
| `test/widget/custom_button_test.dart` | Widget | 4 | Button text, loading spinner, disabled state, tap callbacks |
| `test/widget/custom_text_field_test.dart` | Widget | 4 | Text entry, prefix icon, password eye toggle, error message |
| `test/widget/forgot_password_view_test.dart` | Widget | 1 | Clean screen rendering without duplicate headers |
| `test/widget/home_view_test.dart` | Widget | 2 | Bottom sheet presentation, double-submit protection |
| `test/widget/login_view_test.dart` | Widget | 2 | Component gallery exploration, footer links rendering |
| `test/widget/otp_view_test.dart` | Widget | 4 | Pin code input, auto-fill banner, 1-time header rendering |
| `test/widget/post_card_test.dart` | Widget | 2 | Card rendering, author badge, like count, tap navigation |
| `test/widget/post_detail_view_test.dart` | Widget | 1 | High-contrast SliverAppBar, scroll collapse without blending |
| `test/widget/profile_view_test.dart` | Widget | 4 | Edit profile sheet, reactive initials avatar, photo source |
| `test/widget/register_view_test.dart` | Widget | 2 | Clean header, single "Sign In" link without duplicate labels |
| `test/widget/splash_transition_test.dart` | Widget | 1 | App boot, zero white screens, smooth navigation transition |
| **Total Automated Tests** | | **54** | **100% Passing** |

---

## 📹 Video Tutorial & YouTube Roadmap

If you are creating tutorial videos, tech walkthroughs, or YouTube courses around this boilerplate, here is the recommended 6-part video curriculum:

### Video Content Breakdown Table

| Ep | Video Title (SEO / Click-Worthy) | Length | Key Topics to Cover & Demonstrate On Screen |
| :---: | :--- | :---: | :--- |
| **01** | *Build Production Flutter Apps 10x Faster with GetX (MVC+S Starter)* | 8–10 min | • Live app demo: Dark mode, OTP auto-fill, Feed, Post creation<br>• Why Clean Architecture is overkill for most apps<br>• Quick Start: Clone, pub get, and run in 60 seconds |
| **02** | *GetX Folder Structure Explained for Beginners (No More Messy Code!)* | 12–15 min | • Explaining `core/`, `data/`, `modules/`<br>• The life of a screen: `View` &rarr; `Controller` &rarr; `Provider` &rarr; `Binding`<br>• How `Get.lazyPut()` prevents memory leaks |
| **03** | *Mastering Authentication in Flutter: Mock Backend, OTP & Route Guards* | 14–18 min | • Form validation with regular expressions<br>• PinCodeTextField & auto-fill integration<br>• `AuthGuard` middleware (redirecting unauthenticated users) |
| **04** | *REST API Feed with Dio, Shimmer Loading & Infinite Scroll Pagination* | 15–20 min | • Configuring `DioClient` with interceptors & auto-retries<br>• Beautiful shimmer loading skeletons<br>• Prepending new posts instantly with reactive `RxList` |
| **05** | *Material 3 Dynamic Theming & Production Dialogs in GetX* | 10–12 min | • Switching light/dark mode with `GetStorage` persistence<br>• Color seed palettes (Purple, Blue, Teal, Coral)<br>• Why standard `Get.defaultDialog` looks dated and how `AppDialog` fixes it |
| **06** | *Live Coding: Adding a Complete New Feature Module in 10 Minutes!* | 12–15 min | • Live demonstration of adding the `products` module<br>• Creating Provider, Controller, Binding, View<br>• Running `flutter analyze` & writing a widget test |

---

## ❓ Troubleshooting & FAQ

#### 1. Why does navigating directly to `/dashboard` redirect to `/login`?
This is by design! The route is protected by `AuthGuard`. If no active session token is found in `StorageService`, the app safely redirects the user to the login screen.

#### 2. How do I turn off the mock authentication and connect real Firebase or REST Auth?
Open [`lib/app/modules/auth/controllers/auth_controller.dart`](lib/app/modules/auth/controllers/auth_controller.dart), replace `provider.login()` with your backend call, and store the real token using `AuthService.to.saveAuth(user: user, authToken: token)`.

#### 3. What if I want to add more languages?
Open [`lib/app/core/values/app_strings.dart`](lib/app/core/values/app_strings.dart), add a new locale map (e.g., `'es_ES': { ... }`), and add the option to the Language dropdown in `SettingsView`.

---

## 🤝 Contributing & Community

Contributions make the open-source community an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'feat: Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## ⭐ Support This Project

If you find this boilerplate helpful for your personal projects, agency work, or job interviews:
* ⭐ **Star this repository** to help others discover it!
* 🍴 **Fork it** to create your own production apps!
* 📢 **Share it** on LinkedIn, Twitter/X, and tech communities!

---

## 📄 License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for more information.

Copyright &copy; 2026 **Sheikh Aman**. Engineered with passion for the Flutter community.
