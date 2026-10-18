import 'app_language.dart';

/// Centralized bilingual strings for BloodX (Bangla-first with English toggle).
class BloodStrings {
  BloodStrings._();

  static bool get _bn => AppLanguage.instance.isBangla;

  // App General
  static String get appName => 'BloodX';
  static String get tagline =>
      _bn ? 'প্রতিটি রক্তবিন্দু জীবন বাঁচায়' : 'Every drop saves a life';
  static String get languageToggleText => _bn ? 'EN' : 'বাং';
  static String get themePresetClassic => _bn ? 'ক্লাসিক থিম' : 'Classic Theme';
  static String get themePresetModern => _bn ? 'মডার্ন থিম' : 'Modern Theme';
  static String get switchTheme => _bn ? 'থিম পরিবর্তন' : 'Switch Theme';

  // Splash
  static String get splashSubtitle => _bn
      ? 'স্বেচ্ছাসেবী রক্তদাতাদের বিশ্বস্ত প্ল্যাটফর্ম'
      : 'Trusted Platform for Volunteer Donors';

  // Onboarding (S01 Welcome)
  static String get welcomeTitle =>
      _bn ? 'ব্লাডএক্স-এ স্বাগতম' : 'Welcome to BloodX';
  static String get welcomeSubtitle => _bn
      ? 'জরুরি প্রয়োজনে দ্রুত রক্তদাতা সন্ধান ও রক্তদানের একমাত্র বিশ্বস্ত প্ল্যাটফর্ম'
      : 'The trusted platform for emergency blood matching and voluntary donation';

  static String get onb1Title =>
      _bn ? 'জরুরি রক্তের সন্ধান' : 'Emergency Blood Matching';
  static String get onb1Desc => _bn
      ? 'ঢাকা সহ যেকোনো প্রান্তে কয়েক মিনিটে উপযুক্ত ও প্রস্তুত রক্তদাতার সাড়া পান'
      : 'Find verified, available volunteer blood donors within minutes in Dhaka & beyond';

  static String get onb2Title => _bn
      ? '১০০% স্বেচ্ছাসেবী ও সম্পূর্ণ ফ্রি'
      : '100% Volunteer & Always Free';
  static String get onb2Desc => _bn
      ? 'রক্ত কেনাবেচা সম্পূর্ণ নিষিদ্ধ। রক্তের অনুরোধ চিরকাল বিনামূল্যে থাকবে'
      : 'Blood trade is strictly prohibited. Blood requests are forever free of charge';

  static String get onb3Title =>
      _bn ? 'নিরাপত্তা ও গোপনীয়তা' : 'Safety & Privacy First';
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
  static String get phoneScreenTitle =>
      _bn ? 'মোবাইল নম্বর লিখুন' : 'Enter Phone Number';
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

  static String get sendOtpButton =>
      _bn ? 'ওটিপি কোড পাঠান' : 'Send Verification Code';

  // Auth - OTP Verification
  static String get otpScreenTitle => _bn ? 'ওটিপি যাচাই করুন' : 'Verify OTP';
  static String get otpScreenSubtitle => _bn
      ? 'একটি ৬ সংখ্যার যাচাইকরণ কোড পাঠানো হয়েছে'
      : 'A 6-digit verification code was sent to';
  static String get wrongNumber =>
      _bn ? 'নম্বর পরিবর্তন করবেন?' : 'Wrong number? Edit';
  static String get enterOtpHint => _bn ? 'কোড লিখুন' : 'Enter 6-digit code';
  static String get resendCodeIn =>
      _bn ? 'পুনরায় কোড পাঠানোর সময়: ' : 'Resend code in: ';
  static String get resendCodeNow =>
      _bn ? 'পুনরায় ওটিপি পাঠান' : 'Resend OTP Code';
  static String get verifyButton =>
      _bn ? 'যাচাই করে এগিয়ে যান' : 'Verify & Continue';
  static String get invalidOtpError => _bn
      ? 'ভুল ওটিপি কোড! অনুগ্রহ করে আবার চেষ্টা করুন'
      : 'Invalid OTP code! Please try again';

  // Passwordless explanation note
  static String get passwordlessNoteTitle =>
      _bn ? 'পাসওয়ার্ডহীন নিরাপদ লগইন' : 'Passwordless & Hassle-Free';
  static String get passwordlessNoteDesc => _bn
      ? 'ব্লাডএক্স পাসওয়ার্ডহীন ওটিপি ভিত্তিক নিরাপদ লগইন ব্যবহার করে যাতে জরুরি মুহূর্তে পাসওয়ার্ড ভুলে যাওয়ার ভয় না থাকে।'
      : 'BloodX uses secure phone OTP instead of passwords, ensuring quick and stress-free access during medical emergencies.';

  // Help & Account Recovery
  static String get loginHelp => _bn
      ? 'লগইন সহায়তা ও অ্যাকাউন্ট রিকভারি'
      : 'Login Help & Account Recovery';
  static String get loginHelpDesc => _bn
      ? 'ব্লাডএক্সে কোনো পাসওয়ার্ড মনে রাখার প্রয়োজন নেই। আপনার সিম নম্বরে আসা ওটিপি-ই আপনার চাবি।'
      : 'BloodX does not require passwords. Your registered SIM and SMS OTP are your secure key.';
  static String get simLostTitle => _bn
      ? 'সিম কার্ড হারিয়ে গেছে বা নম্বর পরিবর্তন?'
      : 'Lost your SIM or changed number?';
  static String get simLostDesc => _bn
      ? 'আপনার সিম রিপ্লেস করুন অথবা পূর্ববর্তী একাউন্ট স্থানান্তর করতে আমাদের সাপোর্ট হেল্পলাইনে যোগাযোগ করুন।'
      : 'Please re-issue your SIM or contact BloodX volunteer support to safely migrate your account.';
  static String get supportHelpline => _bn
      ? 'ব্লাডএক্স হেল্পলাইন: +880 9612-000000'
      : 'BloodX Helpline: +880 9612-000000';
  static String get close => _bn ? 'বন্ধ করুন' : 'Close';

  // Auth - Register Profile
  static String get registerTitle =>
      _bn ? 'প্রোফাইল সম্পন্ন করুন' : 'Complete Profile';
  static String get registerSubtitle => _bn
      ? 'জরুরি রক্তদানের সুবিধার্থে আপনার নাম ও সাধারণ তথ্য দিন'
      : 'Help us personalize your emergency blood coordination';
  static String get nameFieldLabel => _bn ? 'আপনার পুরো নাম' : 'Full Name';
  static String get nameFieldHint =>
      _bn ? 'যেমন: তানভীর আহমেদ' : 'e.g. Tanvir Ahmed';
  static String get nameErrorEmpty =>
      _bn ? 'অনুগ্রহ করে আপনার নাম লিখুন' : 'Please enter your name';

  static String get bloodGroupLabel =>
      _bn ? 'রক্তের গ্রুপ (জানা থাকলে)' : 'Blood Group (If known)';
  static String get selectBloodGroup =>
      _bn ? 'রক্তের গ্রুপ নির্বাচন করুন' : 'Select Blood Group';
  static String get areaLabel =>
      _bn ? 'বর্তমান এলাকা (ঢাকা)' : 'Current Area (Dhaka)';
  static String get selectArea =>
      _bn ? 'এলাকা নির্বাচন করুন' : 'Select Dhaka Area';
  static String get completeRegistrationButton =>
      _bn ? 'নিবন্ধন সম্পন্ন করুন' : 'Complete Registration';

  // General Actions
  static String get loading => _bn ? 'অপেক্ষা করুন...' : 'Please wait...';
  static String get continueText => _bn ? 'এগিয়ে যান' : 'Continue';
  static String get signOut => _bn ? 'লগআউট' : 'Sign Out';
  static String get cancel => _bn ? 'বাতিল' : 'Cancel';
  static String get confirm => _bn ? 'নিশ্চিত করুন' : 'Confirm';
  static String get saveAndProceed =>
      _bn ? 'সংরক্ষণ করে এগিয়ে যান' : 'Save & Continue';

  // Navigation Links
  static String get alreadyHaveAccount =>
      _bn ? 'আগে থেকেই অ্যাকাউন্ট আছে? ' : 'Already have an account? ';
  static String get loginLink => _bn ? 'লগইন করুন' : 'Log In';
  static String get dontHaveAccount =>
      _bn ? 'অ্যাকাউন্ট নেই? ' : "Don't have an account? ";
  static String get signUpLink => _bn ? 'নতুন অ্যাকাউন্ট খুলুন' : 'Sign Up';

  // Auth - S5 PIN Setup
  static String get pinSetupTitle =>
      _bn ? '৫ সংখ্যার পিন সেট করুন' : 'Set 5-Digit PIN';
  static String get pinSetupSubtitle => _bn
      ? 'প্রতিবার দ্রুত ও নিরাপদে লগইন করতে একটি গোপন ৫ সংখ্যার পিন নির্ধারণ করুন'
      : 'Create a secure 5-digit PIN for quick and protected access';
  static String get pinConfirmTitle =>
      _bn ? 'পিনটি আবার লিখুন' : 'Confirm Your PIN';
  static String get pinConfirmSubtitle => _bn
      ? 'নিশ্চিত করতে একই ৫ সংখ্যার পিন পুনরায় প্রবেশ করান'
      : 'Re-enter your 5-digit PIN to confirm';
  static String get pinMismatchError => _bn
      ? 'পিন মেলেনি! অনুগ্রহ করে আবার চেষ্টা করুন'
      : 'PINs do not match. Please try again';
  static String get pinInsecureError => _bn
      ? 'সহজ পিন (যেমন 00000) গ্রহণযোগ্য নয়'
      : 'Insecure PIN (like 00000) is not allowed';
  static String get pinSetSuccess => _bn
      ? 'পিন সফলভাবে সেট হয়েছে! এখন পিন দিয়ে লগইন করুন'
      : 'PIN created successfully! Please log in with your PIN';

  // Auth - S6 Phone + PIN Login
  static String get loginTitle =>
      _bn ? 'ব্লাডএক্সে লগইন করুন' : 'Log In to BloodX';
  static String get loginSubtitle => _bn
      ? 'আপনার নিবন্ধিত মোবাইল নম্বর ও ৫ সংখ্যার পিন দিন'
      : 'Enter your registered mobile number and 5-digit PIN';
  static String get pinFieldLabel => _bn ? '৫ সংখ্যার পিন' : '5-Digit PIN';
  static String get pinFieldHint => '•••••';
  static String get forgotPin => _bn ? 'পিন ভুলে গেছেন?' : 'Forgot PIN?';
  static String get forgotPinPrompt => _bn ? 'পিন রিসেট করুন' : 'Reset PIN';
  static String get loginButton => _bn ? 'লগইন করুন' : 'Log In';
  static String get loginInvalidCredentials =>
      _bn ? 'মোবাইল নম্বর অথবা পিন সঠিক নয়' : 'Invalid mobile number or PIN';
  static String get loginLockedError => _bn
      ? 'অতিরিক্ত ভুল পিন দেওয়ার কারণে অ্যাকাউন্ট ১৫ মিনিটের জন্য সাময়িক স্থগিত'
      : 'Too many incorrect attempts. Login locked for 15 minutes';

  // S7 Terms and Privacy Dialog
  static String get termsDialogTitle =>
      _bn ? 'শর্তাবলী ও গোপনীয়তা নীতি' : 'Terms & Privacy Policy';
  static String get termsIntro => _bn
      ? 'ব্লাডএক্স একটি অলাভজনক ও ১০০% স্বেচ্ছাসেবী রক্তদান প্ল্যাটফর্ম।'
      : 'BloodX is a non-profit, 100% voluntary blood donation coordination platform.';
  static String get termsPoint1Title =>
      _bn ? '১. রক্তের কোনো কেনাবেচা নয়' : '1. Zero Blood Trade';
  static String get termsPoint1Desc => _bn
      ? 'ব্লাডএক্সে রক্তদান ও রক্তের আবেদন চিরকাল বিনামূল্যে। রক্ত বিক্রি বা কোনো মধ্যস্বত্বভোগী কঠোরভাবে নিষিদ্ধ।'
      : 'Blood requests and voluntary pledges are always free. Any blood sale or commercial brokerage is strictly prohibited.';
  static String get termsPoint2Title =>
      _bn ? '২. স্বেচ্ছাসেবী রক্তদাতা নীতি' : '2. Voluntary Donor Principle';
  static String get termsPoint2Desc => _bn
      ? 'রক্তদান সম্পূর্ণ আপনার ইচ্ছাধীন। কোনো চাপ, অনুশোচনা বা বাধ্যতামূলক অ্যালার্ট নেই। আপনি যেকোনো সময় প্রাপ্যতা বন্ধ করতে পারেন।'
      : 'Donation is purely voluntary. No guilt, pressure, or nagging. Availability is always off by default and expires automatically.';
  static String get termsPoint3Title => _bn
      ? '৩. গোপনীয়তা ও ফোন নম্বর সুরক্ষা'
      : '3. Privacy & Phone Number Protection';
  static String get termsPoint3Desc => _bn
      ? 'আপনার পূর্ণ ফোন নম্বর প্রকাশ্যে দেখা যাবে না। রক্তদাতা প্রতিশ্রুতি নিশ্চিত করার পরই কেবল গ্রহীতা ও দাতার মধ্যে যোগাযোগ উন্মুক্ত হয়।'
      : 'Your full phone number is never shown publicly. Contact details are securely revealed only after mutual pledge verification.';
  static String get termsPoint4Title => _bn
      ? '৪. স্বাস্থ্য ও নিরাপত্তা যাচাই'
      : '4. Health & Safety Verification';
  static String get termsPoint4Desc => _bn
      ? 'চূড়ান্ত রক্তদানের সিদ্ধান্ত ও উপযুক্ততা রক্তদান কেন্দ্রের চিকিৎসকদের দায়িত্ব।'
      : 'Final donor medical eligibility and screening are always determined by qualified hospital blood bank personnel.';
  static String get understandAndAgree =>
      _bn ? 'আমি পড়েছি এবং একমত' : 'I Understand & Agree';
  static String get termsCheckboxText =>
      _bn ? 'আমি শর্তাবলী ও গোপনীয়তা নীতি পড়েছি এবং সম্মত' : 'I have read and agree to the Terms of Use & Privacy Policy';
  static String get termsConfirmPrompt =>
      _bn ? 'আমি নিশ্চিত করছি যে আমি শর্তাবলী এবং গোপনীয়তা নীতি পড়েছি এবং এতে সম্মত।' : 'I confirm that I have read and agree to the terms and privacy policy';
  static String get agree => _bn ? 'সম্মত' : 'Agree';

  // S8 Donor Health Details
  static String get donorHealthTitle =>
      _bn ? 'রক্তদাতার স্বাস্থ্য ও তথ্য' : 'Donor Health Profile';
  static String get donorHealthSubtitle => _bn
      ? 'জরুরি প্রয়োজনে আপনাকে ডাকার জন্য প্রাথমিক স্বাস্থ্য ও এলাকা সংক্রান্ত তথ্য প্রয়োজন'
      : 'Required details to match urgent blood requests in your area';
  static String get eligibilityHeader => _bn
      ? 'প্রাথমিক উপযুক্ততা যাচাই (সবগুলোতে টিক দিন)'
      : 'Initial Medical Screening (Check all)';
  static String get eligAge => _bn
      ? 'আমার বয়স ১৮ থেকে ৬০ বছরের মধ্যে'
      : 'I am between 18 and 60 years old';
  static String get eligWeight => _bn
      ? 'আমার ওজন ন্যূনতম ৪৫ কেজি (নারী) বা ৫০ কেজি (পুরুষ)'
      : 'My weight is at least 45kg (female) or 50kg (male)';
  static String get eligHealth => _bn
      ? 'আমি আজ সুস্থ বোধ করছি (জ্বর, সর্দি বা সংক্রমণ নেই)'
      : 'I feel well today (no fever, flu, or infection)';
  static String get eligCooldown => _bn
      ? 'বিগত ৩ মাস (পুরুষ) বা ৪ মাসে (নারী) রক্তদান করিনি'
      : 'Passed minimum cooldown since last donation (90d M / 120d F)';
  static String get eligMedication => _bn
      ? 'গত ৬ মাসে বড় কোনো সার্জারি বা ঝুঁকিপূর্ণ ওষুধ সেবন করিনি'
      : 'No major surgery, tattooing, or restricted medication recently';
  static String get eligIncompleteWarning => _bn
      ? 'রক্তদাতা হিসেবে প্রস্তুত হতে সবগুলো উপযুক্ততার শর্ত পূরণ আবশ্যক'
      : 'All eligibility checks must be confirmed to become matchable';
  static String get locationFieldLabel =>
      _bn ? 'আপনার বর্তমান অবস্থান (এলাকা)' : 'Current Location (Area)';
  static String get pickLocationOnMap =>
      _bn ? 'ম্যাপে এলাকা নির্বাচন করুন' : 'Pick on Map';
  static String get preferredHospitalsLabel => _bn
      ? 'পছন্দের বা নিকটস্থ হাসপাতাল (একাধিক নির্বাচনযোগ্য)'
      : 'Preferred Nearby Hospitals (Select multiple)';
  static String get donorVolunteerNote => _bn
      ? 'নোট: প্রোফাইল সম্পন্ন করার পরও রক্তদাতা অ্যালার্ট ডিফল্টভাবে "বন্ধ" থাকবে (D-016)। আপনি নিজে চালু না করলে নোটিফিকেশন আসবে না।'
      : 'Note: Alerts start OFF by default (D-016). No emergency alerts will be sent until you explicitly set your availability.';

  // S9 Location Picker
  static String get mapPickerTitle =>
      _bn ? 'অবস্থান নির্বাচন করুন' : 'Select Location';
  static String get mapSearchHint => _bn
      ? 'ঢাকার এলাকা বা হাসপাতাল খুঁজুন...'
      : 'Search Dhaka area or hospital...';
  static String get useCurrentLocationGps =>
      _bn ? 'বর্তমান জিপিএস লোকেশন ব্যবহার করুন' : 'Use Current GPS Location';
  static String get confirmThisLocation =>
      _bn ? 'এই অবস্থান নিশ্চিত করুন' : 'Confirm This Location';
  static String get selectedAreaLabel =>
      _bn ? 'নির্বাচিত এলাকা: ' : 'Selected: ';

  // Dialog D1: Location Permission
  static String get permLocationTitle =>
      _bn ? 'অবস্থান তথ্যের অনুমতি' : 'Location Permission';
  static String get permLocationDesc => _bn
      ? 'ব্লাডএক্স আপনার কাছাকাছি হাসপাতালের জরুরি রক্তের অনুরোধ মেলাতে অবস্থান তথ্য ব্যবহার করে। ব্যাকগ্রাউন্ডে সার্বক্ষণিক ট্র্যাকিং করা হয় না।'
      : 'BloodX uses location strictly to coordinate nearby emergency blood requests. We never track your background location continuously.';
  static String get allowAccess => _bn ? 'অনুমতি দিন' : 'Allow Access';
  static String get notNow => _bn ? 'এখন নয়' : 'Not Now';

  // Dialog D2: Notification Permission
  static String get permNotifTitle =>
      _bn ? 'জরুরি নোটিফিকেশন চালু করুন' : 'Emergency Notifications';
  static String get permNotifDesc => _bn
      ? 'আপনার রক্তের গ্রুপের কোনো রোগীর জরুরি প্রয়োজন দেখা দিলে তাৎক্ষণিক নোটিফিকেশন পেতে অনুমতি দিন।'
      : 'Allow notifications so you never miss an urgent wave-based blood alert when someone nearby needs your blood group.';
  static String get enableNotifications =>
      _bn ? 'নোটিফিকেশন চালু করুন' : 'Enable Notifications';

  // Dialog D3: Storage Permission
  static String get permStorageTitle =>
      _bn ? 'স্টোরেজ ও ক্যামেরা অনুমতি' : 'Storage & Camera Permission';
  static String get permStorageDesc => _bn
      ? 'হাসপাতালের রক্তের রিকুইজিশন স্লিপ বা রক্তদানের কার্ড আপলোড করতে অনুমতি প্রয়োজন।'
      : 'Permission needed to upload hospital blood requisition slips or donation confirmation cards.';

  // Dialog D4: Delete Account
  static String get deleteAccountTitle =>
      _bn ? 'অ্যাকাউন্ট স্থায়ীভাবে মুছে ফেলা' : 'Permanently Delete Account';
  static String get deleteAccountDesc => _bn
      ? 'আপনার অ্যাকাউন্ট মুছে ফেললে সব ব্যক্তিগত তথ্য ও রক্তদাতার ইতিহাস স্থায়ীভাবে আনসাবস্ক্রাইব এবং অপসারণ করা হবে। পূর্বের লেনদেন রেকর্ড থেকে নাম মুছে ফেলা হবে।'
      : 'Deleting your account will immediately revoke all sessions, remove personal details, and permanently anonymize past transaction references.';
  static String get deleteAccountTypePrompt => _bn
      ? 'নিশ্চিত করতে নিচে ইংরেজিতে "DELETE" শব্দটি লিখুন:'
      : 'To confirm, type the word "DELETE" in uppercase below:';
  static String get deleteAccountConfirmButton =>
      _bn ? 'স্থায়ীভাবে মুছে ফেলুন' : 'Delete Account';
  static String get deleteSuccessMsg => _bn
      ? 'আপনার অ্যাকাউন্ট সফলভাবে মুছে ফেলা হয়েছে'
      : 'Your account has been deleted successfully';

  // S22 Update Required
  static String get updateRequiredTitle =>
      _bn ? 'অ্যাপ আপডেট আবশ্যক' : 'Update Required';
  static String get updateRequiredSubtitle => _bn
      ? 'ব্লাডএক্স-এর নিরাপত্তা ও জরুরি রক্তদান ব্যবস্থাপনা নিশ্চিত করতে নতুন সংস্করণে আপডেট করুন।'
      : 'A critical update is required to continue using BloodX safely for emergency coordination.';
  static String get updateNowButton => _bn ? 'এখনই আপডেট করুন' : 'Update Now';
}
