# 📹 Video Tutorial & YouTube Roadmap
> *Internal creator reference for Sheikh Aman (@fluttercodelab). Keep this file in `docs/` for recording reference.*

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

### 🛠 Recording Setup & Checklist
1. **Screen Mirroring:** `scrcpy --stay-awake --window-title "Flutter Demo"`
2. **Resolution:** 1080p 60fps on OBS Studio.
3. **Status Bar:** Enable Demo Mode / 100% battery, no notifications.
4. **Theme & Font:** Tokyo Night / One Dark Pro, font size 15-16px.
