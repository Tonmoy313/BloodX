import 'app_language.dart';

/// Centralized bilingual strings for BloodX (Bangla-first with English toggle).
class BloodStrings {
  BloodStrings._();

  static bool get _bn => AppLanguage.instance.isBangla;

  // App General
  static String get appName => 'BloodX';
  static String get tagline => _bn ? 'প্রতিটি রক্তবিন্দু জীবন বাঁচায়' : 'Every drop saves a life';
  static String get languageToggleText => _bn ? 'English' : 'বাংলা';

  // Splash
  static String get splashSubtitle => _bn
      ? 'স্বেচ্ছাসেবী রক্তদাতাদের বিশ্বস্ত প্ল্যাটফর্ম'
      : 'Trusted Platform for Volunteer Donors';

  // Onboarding (S01 Welcome)
  static String get welcomeTitle => _bn ? 'ব্লাডএক্স-এ স্বাগতম' : 'Welcome to BloodX';
  static String get welcomeSubtitle => _bn
      ? 'জরুরি প্রয়োজনে দ্রুত রক্তদাতা সন্ধান ও রক্তদানের একমাত্র বিশ্বস্ত প্ল্যাটফর্ম'
      : 'The trusted platform for emergency blood matching and voluntary donation';

  static String get onb1Title => _bn ? 'জরুরি রক্তের সন্ধান' : 'Emergency Blood Matching';
  static String get onb1Desc => _bn
      ? 'ঢাকা সহ যেকোনো প্রান্তে কয়েক মিনিটে উপযুক্ত ও প্রস্তুত রক্তদাতার সাড়া পান'
      : 'Find verified, available volunteer blood donors within minutes in Dhaka & beyond';

  static String get onb2Title => _bn ? '১০০% স্বেচ্ছাসেবী ও সম্পূর্ণ ফ্রি' : '100% Volunteer & Always Free';
  static String get onb2Desc => _bn
      ? 'রক্ত কেনাবেচা সম্পূর্ণ নিষিদ্ধ। রক্তের অনুরোধ চিরকাল বিনামূল্যে থাকবে'
      : 'Blood trade is strictly prohibited. Blood requests are forever free of charge';

  static String get onb3Title => _bn ? 'নিরাপত্তা ও গোপনীয়তা' : 'Safety & Privacy First';
  static String get onb3Desc => _bn
      ? 'অনুমতি এবং প্রতিশ্রুতি ছাড়া আপনার ফোন নম্বর কখনো প্রকাশ করা হয় না'
      : 'Your phone number and private data are protected and never revealed without consent';

  static String get getStarted => _bn ? 'শুরু করুন' : 'Get Started';
  static String get skip => _bn ? 'এড়িয়ে যান' : 'Skip';
  static String get next => _bn ? 'পরবর্তী' : 'Next';

  static String get termsPrefix => _bn
      ? 'চালিয়ে যাওয়ার মাধ্যমে আপনি ব্লাডএক্স-এর '
      : 'By continuing, you agree to BloodX ';
  static String get termsOfService => _bn ? 'শর্তাবলী' : 'Terms';
  static String get and => _bn ? ' ও ' : ' & ';
  static String get privacyPolicy => _bn ? 'গোপনীয়তা নীতি' : 'Privacy Policy';
  static String get agreed => _bn ? ' মেনে নিচ্ছেন।' : '.';

  // Auth - Phone Input (S02)
  static String get phoneScreenTitle => _bn ? 'মোবাইল নম্বর লিখুন' : 'Enter Phone Number';
  static String get phoneScreenSubtitle => _bn
      ? 'আপনার একাউন্ট যাচাই করতে আমরা একটি ৬ সংখ্যার ওটিপি কোড পাঠাবো'
      : 'We will send a 6-digit OTP code to verify your account';
  static String get phoneFieldLabel => _bn ? 'মোবাইল নম্বর' : 'Phone Number';
  static String get phoneFieldHint => '017XXXXXXXX';
  static String get phoneErrorInvalid => _bn
      ? 'সঠিক বাংলাদেশী মোবাইল নম্বর দিন (১১ সংখ্যা)'
      : 'Enter a valid 11-digit Bangladeshi mobile number';

  // D-015: Donor mode is opt-in (unchecked box by default)
  static String get donorOptInCheckbox => _bn
      ? 'আমিও রক্তদাতা হিসেবে সাহায্য করতে চাই (ঐচ্ছিক)'
      : 'I also want to help as a volunteer donor (Optional)';
  static String get donorOptInNote => _bn
      ? 'আপনি যেকোনো সময় রক্তদাতা প্রোফাইল চালু বা বন্ধ রাখতে পারবেন।'
      : 'You can update or pause your donor availability anytime.';

  static String get sendOtpButton => _bn ? 'ওটিপি কোড পাঠান' : 'Send Verification Code';

  // Auth - OTP Verification
  static String get otpScreenTitle => _bn ? 'ওটিপি যাচাই করুন' : 'Verify OTP';
  static String get otpScreenSubtitle => _bn
      ? 'একটি ৬ সংখ্যার যাচাইকরণ কোড পাঠানো হয়েছে'
      : 'A 6-digit verification code was sent to';
  static String get wrongNumber => _bn ? 'নম্বর পরিবর্তন করবেন?' : 'Wrong number? Edit';
  static String get enterOtpHint => _bn ? 'কোড লিখুন' : 'Enter 6-digit code';
  static String get resendCodeIn => _bn ? 'পুনরায় কোড পাঠানোর সময়: ' : 'Resend code in: ';
  static String get resendCodeNow => _bn ? 'পুনরায় ওটিপি পাঠান' : 'Resend OTP Code';
  static String get verifyButton => _bn ? 'যাচাই করে এগিয়ে যান' : 'Verify & Continue';
  static String get invalidOtpError => _bn
      ? 'ভুল ওটিপি কোড! অনুগ্রহ করে আবার চেষ্টা করুন'
      : 'Invalid OTP code! Please try again';

  // Passwordless explanation note
  static String get passwordlessNoteTitle => _bn
      ? 'পাসওয়ার্ডহীন নিরাপদ লগইন'
      : 'Passwordless & Hassle-Free';
  static String get passwordlessNoteDesc => _bn
      ? 'ব্লাডএক্স পাসওয়ার্ডহীন ওটিপি ভিত্তিক নিরাপদ লগইন ব্যবহার করে যাতে জরুরি মুহূর্তে পাসওয়ার্ড ভুলে যাওয়ার ভয় না থাকে।'
      : 'BloodX uses secure phone OTP instead of passwords, ensuring quick and stress-free access during medical emergencies.';

  // Help & Account Recovery
  static String get loginHelp => _bn ? 'লগইন সহায়তা ও অ্যাকাউন্ট রিকভারি' : 'Login Help & Account Recovery';
  static String get loginHelpDesc => _bn
      ? 'ব্লাডএক্সে কোনো পাসওয়ার্ড মনে রাখার প্রয়োজন নেই। আপনার সিম নম্বরে আসা ওটিপি-ই আপনার চাবি।'
      : 'BloodX does not require passwords. Your registered SIM and SMS OTP are your secure key.';
  static String get simLostTitle => _bn ? 'সিম কার্ড হারিয়ে গেছে বা নম্বর পরিবর্তন?' : 'Lost your SIM or changed number?';
  static String get simLostDesc => _bn
      ? 'আপনার সিম রিপ্লেস করুন অথবা পূর্ববর্তী একাউন্ট স্থানান্তর করতে আমাদের সাপোর্ট হেল্পলাইনে যোগাযোগ করুন।'
      : 'Please re-issue your SIM or contact BloodX volunteer support to safely migrate your account.';
  static String get supportHelpline => _bn ? 'ব্লাডএক্স হেল্পলাইন: +880 9612-000000' : 'BloodX Helpline: +880 9612-000000';
  static String get close => _bn ? 'বন্ধ করুন' : 'Close';

  // Auth - Register Profile
  static String get registerTitle => _bn ? 'প্রোফাইল সম্পন্ন করুন' : 'Complete Profile';
  static String get registerSubtitle => _bn
      ? 'জরুরি রক্তদানের সুবিধার্থে আপনার নাম ও সাধারণ তথ্য দিন'
      : 'Help us personalize your emergency blood coordination';
  static String get nameFieldLabel => _bn ? 'আপনার পুরো নাম' : 'Full Name';
  static String get nameFieldHint => _bn ? 'যেমন: তানভীর আহমেদ' : 'e.g. Tanvir Ahmed';
  static String get nameErrorEmpty => _bn ? 'অনুগ্রহ করে আপনার নাম লিখুন' : 'Please enter your name';

  static String get bloodGroupLabel => _bn ? 'রক্তের গ্রুপ (জানা থাকলে)' : 'Blood Group (If known)';
  static String get selectBloodGroup => _bn ? 'রক্তের গ্রুপ নির্বাচন করুন' : 'Select Blood Group';
  static String get areaLabel => _bn ? 'বর্তমান এলাকা (ঢাকা)' : 'Current Area (Dhaka)';
  static String get selectArea => _bn ? 'এলাকা নির্বাচন করুন' : 'Select Dhaka Area';
  static String get completeRegistrationButton => _bn ? 'নিবন্ধন সম্পন্ন করুন' : 'Complete Registration';

  // General Actions
  static String get loading => _bn ? 'অপেক্ষা করুন...' : 'Please wait...';
  static String get continueText => _bn ? 'এগিয়ে যান' : 'Continue';
  static String get signOut => _bn ? 'লগআউট' : 'Sign Out';
}
