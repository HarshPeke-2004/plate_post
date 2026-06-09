import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plate_post/core/app_pages.dart';
import 'package:plate_post/core/app_theme.dart';
import 'package:plate_post/firebase_options.dart';
import 'package:plate_post/localization/localization.dart';
import 'package:plate_post/src/features/bookmark_recipe/repository/bookmark_interface.dart';
import 'package:plate_post/src/features/splash/screens/splash_screen.dart';
import 'package:plate_post/src/models/shopping_item.dart';
import 'package:plate_post/src/navigation/route_generator.dart';
import 'package:plate_post/src/providers/auth_provider.dart';
import 'package:plate_post/src/providers/bookmark_provider.dart';
import 'package:plate_post/src/providers/message_provider.dart';
import 'package:plate_post/src/providers/recipe_post_provider.dart';
import 'package:plate_post/src/providers/settings_provider.dart';
import 'package:plate_post/src/providers/shopping_provider.dart';
import 'package:plate_post/src/providers/user_image_provider.dart';
import 'package:plate_post/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

Box? onboardingBox;
void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ShoppingItemAdapter());
  await Hive.openBox<ShoppingItem>('shoppingItems');
  onboardingBox = await Hive.openBox('onboarding');
  // SystemChrome.setSystemUIOverlayStyle(
  // const SystemUiOverlayStyle(
  //   systemNavigationBarColor: kBlackColor2,
  // ),
  // );
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BookmarkInterface>(
          create: (context) => BookmarkProvider(),
        ),
        ChangeNotifierProvider<MessageProvider>(
          lazy: false,
          create: (context) => MessageProvider(
            FirebaseFirestore.instance,
            FirebaseAuth.instance,
          ),
        ),
        ChangeNotifierProvider<UserProvider>(
          lazy: false,
          create: (context) => UserProvider(
            FirebaseFirestore.instance,
            FirebaseAuth.instance,
          ),
        ),
        ChangeNotifierProvider<UserImageProvider>(
          create: (context) => UserImageProvider(
            FirebaseAuth.instance,
            FirebaseStorage.instance,
          ),
        ),
        ChangeNotifierProvider<RecipePostProvider>(
          lazy: false,
          create: (context) => RecipePostProvider(
            FirebaseFirestore.instance,
          ),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => ShoppingProvider(),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => AuthProvider(
            FirebaseAuth.instance,
            FirebaseFirestore.instance,
          ),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => SettingsProvider(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsManager, _) {
          ThemeData theme;
          if (settingsManager.darkMode) {
            theme = AppTheme.dark();
          } else {
            theme = AppTheme.light();
          }
          return GetMaterialApp(
            supportedLocales: Localization.all,
            debugShowCheckedModeBanner: false,
            theme: theme,
            initialRoute: AppPages.splashPath,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
