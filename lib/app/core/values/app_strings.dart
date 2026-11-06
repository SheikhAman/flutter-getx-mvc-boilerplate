import 'package:get/get.dart';

class AppStrings extends Translations {
  // Static Keys for compile-time safety
  static const String appName = 'app_name';
  static const String welcome = 'welcome';
  static const String welcomeSubtitle = 'welcome_subtitle';
  static const String login = 'login';
  static const String register = 'register';
  static const String email = 'email';
  static const String password = 'password';
  static const String confirmPassword = 'confirm_password';
  static const String phone = 'phone';
  static const String name = 'name';
  static const String forgotPassword = 'forgot_password';
  static const String resetPassword = 'reset_password';
  static const String sendResetLink = 'send_reset_link';
  static const String alreadyHaveAccount = 'already_have_account';
  static const String dontHaveAccount = 'dont_have_account';
  static const String rememberMe = 'remember_me';

  // OTP
  static const String otpTitle = 'otp_title';
  static const String otpSubtitle = 'otp_subtitle';
  static const String otpHint = 'otp_hint';
  static const String otpSent = 'otp_sent';
  static const String verify = 'verify';
  static const String resend = 'resend';
  static const String resendIn = 'resend_in';
  static const String demoOtpHint = 'demo_otp_hint';

  // Navigation
  static const String home = 'home';
  static const String search = 'search';
  static const String showcase = 'showcase';
  static const String profile = 'profile';
  static const String settings = 'settings';

  // Actions & States
  static const String continueText = 'continue';
  static const String submit = 'submit';
  static const String cancel = 'cancel';
  static const String save = 'save';
  static const String edit = 'edit';
  static const String delete = 'delete';
  static const String retry = 'retry';
  static const String logout = 'logout';
  static const String logoutConfirm = 'logout_confirm';
  static const String success = 'success';
  static const String error = 'error';
  static const String warning = 'warning';
  static const String info = 'info';

  // Onboarding
  static const String onboarding1Title = 'onboarding_1_title';
  static const String onboarding1Desc = 'onboarding_1_desc';
  static const String onboarding2Title = 'onboarding_2_title';
  static const String onboarding2Desc = 'onboarding_2_desc';
  static const String onboarding3Title = 'onboarding_3_title';
  static const String onboarding3Desc = 'onboarding_3_desc';
  static const String getStarted = 'get_started';
  static const String skip = 'skip';

  // Home & Posts
  static const String recentPosts = 'recent_posts';
  static const String createPost = 'create_post';
  static const String postTitle = 'post_title';
  static const String postBody = 'post_body';
  static const String postDetail = 'post_detail';
  static const String noPostsFound = 'no_posts_found';
  static const String loadMore = 'load_more';

  // Search
  static const String searchHint = 'search_hint';
  static const String searchResults = 'search_results';
  static const String noResults = 'no_results';
  static const String typeToSearch = 'type_to_search';

  // Settings & Theme
  static const String appearance = 'appearance';
  static const String darkMode = 'dark_mode';
  static const String lightMode = 'light_mode';
  static const String language = 'language';
  static const String english = 'english';
  static const String bengali = 'bengali';
  static const String primaryColor = 'primary_color';
  static const String aboutApp = 'about_app';
  static const String version = 'version';

  // Common Screens
  static const String networkError = 'network_error';
  static const String networkErrorSub = 'network_error_sub';
  static const String emptyTitle = 'empty_title';
  static const String emptySub = 'empty_sub';
  static const String notFoundTitle = 'not_found_title';
  static const String notFoundSub = 'not_found_sub';
  static const String backToHome = 'back_to_home';
  static const String webview = 'webview';

  // Validation Messages
  static const String fieldRequired = 'field_required';
  static const String invalidEmail = 'invalid_email';
  static const String invalidPhone = 'invalid_phone';
  static const String passwordTooShort = 'password_too_short';
  static const String passwordsDoNotMatch = 'passwords_do_not_match';
  static const String invalidOtp = 'invalid_otp';

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': _en,
        'bn_BD': _bn,
      };

  static const Map<String, String> _en = {
    appName: 'Flutter Core',
    welcome: 'Welcome Back',
    welcomeSubtitle: 'Sign in to continue exploring your account',
    login: 'Sign In',
    register: 'Create Account',
    email: 'Email Address',
    password: 'Password',
    confirmPassword: 'Confirm Password',
    phone: 'Phone Number',
    name: 'Full Name',
    forgotPassword: 'Forgot Password?',
    resetPassword: 'Reset Password',
    sendResetLink: 'Send Reset Instructions',
    alreadyHaveAccount: 'Already have an account? Sign In',
    dontHaveAccount: "Don't have an account? Sign Up",
    rememberMe: 'Remember Me',
    otpTitle: 'Verify Code',
    otpSubtitle: 'Enter the 6-digit verification code sent to your phone/email',
    otpHint: '6-digit code',
    otpSent: 'Verification code sent',
    verify: 'Verify & Continue',
    resend: 'Resend Code',
    resendIn: 'Resend in',
    demoOtpHint: 'Demo OTP: 112345',
    home: 'Home',
    search: 'Search',
    showcase: 'Showcase',
    profile: 'Profile',
    settings: 'Settings',
    continueText: 'Continue',
    submit: 'Submit',
    cancel: 'Cancel',
    save: 'Save Changes',
    edit: 'Edit',
    delete: 'Delete',
    retry: 'Try Again',
    logout: 'Logout',
    logoutConfirm: 'Are you sure you want to log out?',
    success: 'Success',
    error: 'Error',
    warning: 'Warning',
    info: 'Information',
    onboarding1Title: 'High-Velocity Architecture',
    onboarding1Desc:
        'Built with production-proven Modular GetX MVC+S for rapid development and enterprise scale.',
    onboarding2Title: 'Enterprise Network Engine',
    onboarding2Desc:
        'Powered by Dio with automatic JWT injection, retry handlers, and typed responses.',
    onboarding3Title: 'Production Ready UI Kit',
    onboarding3Desc:
        'Beautiful responsive components, dark mode, multi-language support, and component gallery.',
    getStarted: 'Get Started',
    skip: 'Skip',
    recentPosts: 'Recent Posts',
    createPost: 'Create Post',
    postTitle: 'Post Title',
    postBody: 'Write something interesting...',
    postDetail: 'Post Detail',
    noPostsFound: 'No posts found',
    loadMore: 'Load More',
    searchHint: 'Search posts, users, or topics...',
    searchResults: 'Search Results',
    noResults: 'No matches found',
    typeToSearch: 'Type keywords above to begin searching',
    appearance: 'Appearance',
    darkMode: 'Dark Mode',
    lightMode: 'Light Mode',
    language: 'Language',
    english: 'English',
    bengali: 'বাংলা (Bengali)',
    primaryColor: 'Primary Accent Color',
    aboutApp: 'About Flutter Core',
    version: 'Version 1.0.0',
    networkError: 'No Internet Connection',
    networkErrorSub:
        'Please check your connection and tap retry to load again.',
    emptyTitle: 'No Records Found',
    emptySub:
        'There is nothing here yet. Tap below to refresh or create new item.',
    notFoundTitle: 'Page Not Found',
    notFoundSub:
        'The page you are looking for does not exist or has been moved.',
    backToHome: 'Back to Home',
    webview: 'Web Browser',
    fieldRequired: 'This field is required',
    invalidEmail: 'Enter a valid email address',
    invalidPhone: 'Enter a valid phone number',
    passwordTooShort: 'Password must be at least 6 characters',
    passwordsDoNotMatch: 'Passwords do not match',
    invalidOtp: 'Invalid verification code',
  };

  static const Map<String, String> _bn = {
    appName: 'ফ্লাটার কোর',
    welcome: 'স্বাগতম',
    welcomeSubtitle: 'আপনার অ্যাকাউন্টে প্রবেশ করতে সাইন ইন করুন',
    login: 'সাইন ইন',
    register: 'নতুন অ্যাকাউন্ট তৈরি করুন',
    email: 'ইমেইল ঠিকানা',
    password: 'পাসওয়ার্ড',
    confirmPassword: 'পাসওয়ার্ড নিশ্চিত করুন',
    phone: 'ফোন নম্বর',
    name: 'পুরো নাম',
    forgotPassword: 'পাসওয়ার্ড ভুলে গেছেন?',
    resetPassword: 'পাসওয়ার্ড রিসেট',
    sendResetLink: 'রিসেট নির্দেশ পাঠান',
    alreadyHaveAccount: 'ইতিমধ্যে অ্যাকাউন্ট আছে? সাইন ইন করুন',
    dontHaveAccount: 'অ্যাকাউন্ট নেই? সাইন আপ করুন',
    rememberMe: 'মনে রাখুন',
    otpTitle: 'কোড যাচাই করুন',
    otpSubtitle: 'আপনার মোবাইল বা ইমেইলে পাঠানো ৬ অঙ্কের কোড লিখুন',
    otpHint: '৬ অঙ্কের কোড',
    otpSent: 'যাচাইকরণ কোড পাঠানো হয়েছে',
    verify: 'যাচাই করে এগিয়ে যান',
    resend: 'পুনরায় কোড পাঠান',
    resendIn: 'পুনরায় পাঠানো যাবে',
    demoOtpHint: 'ডেমো ওটিপি: ১১২৩৪৫',
    home: 'হোম',
    search: 'অনুসন্ধান',
    showcase: 'শোকেস',
    profile: 'প্রোফাইল',
    settings: 'সেটিংস',
    continueText: 'চালিয়ে যান',
    submit: 'সাবমিট করুন',
    cancel: 'বাতিল',
    save: 'সংরক্ষণ করুন',
    edit: 'সম্পাদনা',
    delete: 'মুছুন',
    retry: 'আবার চেষ্টা করুন',
    logout: 'লগআউট',
    logoutConfirm: 'আপনি কি নিশ্চিত যে লগআউট করতে চান?',
    success: 'সফল',
    error: 'ত্রুটি',
    warning: 'সতর্কতা',
    info: 'তথ্য',
    onboarding1Title: 'উচ্চগতির আর্কিটেকচার',
    onboarding1Desc:
        'প্রোডাকশন-প্রুভেন গেটএক্স এমভিসি+এস কাঠামো যা অত্যন্ত দ্রুত এবং স্কেলেবল।',
    onboarding2Title: 'এন্টারপ্রাইজ নেটওয়ার্ক ইঞ্জিন',
    onboarding2Desc:
        'ডিও (Dio) চালিত স্বয়ংক্রিয় টোকেন ও ত্রুটি হ্যান্ডলার সহ দ্রুততম নেটওয়ার্কিং।',
    onboarding3Title: 'প্রোডাকশন রেডি ইউআই কিট',
    onboarding3Desc:
        'ডার্ক মোড, বহুভাষিক সাপোর্ট এবং কম্পোনেন্ট শোকেস সহ আধুনিক ডিজাইন।',
    getStarted: 'শুরু করুন',
    skip: 'এড়িয়ে যান',
    recentPosts: 'সাম্প্রতিক পোস্টসমূহ',
    createPost: 'নতুন পোস্ট',
    postTitle: 'পোস্টের শিরোনাম',
    postBody: 'আপনার চিন্তাভাবনা লিখুন...',
    postDetail: 'পোস্টের বিস্তারিত',
    noPostsFound: 'কোন পোস্ট পাওয়া যায়নি',
    loadMore: 'আরও দেখুন',
    searchHint: 'পোস্ট, ব্যবহারকারী বা বিষয় অনুসন্ধান করুন...',
    searchResults: 'অনুসন্ধানের ফলাফল',
    noResults: 'কোন ফলাফল পাওয়া যায়নি',
    typeToSearch: 'অনুসন্ধান শুরু করতে টাইপ করুন',
    appearance: 'চেহারা ও রূপ',
    darkMode: 'ডার্ক মোড',
    lightMode: 'লাইট মোড',
    language: 'ভাষা',
    english: 'ইংরেজি (English)',
    bengali: 'বাংলা',
    primaryColor: 'মূল রঙ',
    aboutApp: 'ফ্লাটার কোর সম্পর্কে',
    version: 'সংস্করণ ১.০.০',
    networkError: 'ইন্টারনেট সংযোগ নেই',
    networkErrorSub: 'আপনার সংযোগ চেক করুন এবং পুনরায় চেষ্টা করতে ট্যাপ করুন।',
    emptyTitle: 'কোন তথ্য নেই',
    emptySub: 'এখানে এখনও কিছু নেই। নতুন আইটেম যুক্ত করুন বা রিফ্রেশ করুন।',
    notFoundTitle: 'পৃষ্ঠাটি পাওয়া যায়নি',
    notFoundSub: 'আপনি যে পৃষ্ঠাটি খুঁজছেন তা বিদ্যমান নেই বা সরানো হয়েছে।',
    backToHome: 'হোমে ফিরে যান',
    webview: 'ওয়েব ব্রাউজার',
    fieldRequired: 'এই ঘরটি পূরণ করা আবশ্যক',
    invalidEmail: 'একটি সঠিক ইমেইল ঠিকানা দিন',
    invalidPhone: 'একটি সঠিক ফোন নম্বর দিন',
    passwordTooShort: 'পাসওয়ার্ড কমপক্ষে ৬ অক্ষরের হতে হবে',
    passwordsDoNotMatch: 'পাসওয়ার্ড দুটি মিলছে না',
    invalidOtp: 'ভুল ওটিপি কোড',
  };
}
