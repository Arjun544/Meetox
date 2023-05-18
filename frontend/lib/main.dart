import 'package:frontend/core/app_strings.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/instances.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await graphqlInit();
  runApp(const MyApp());
}

final Rx<User> currentUser = User(
  id: '',
  email: '',
  name: '',
  displayPic: DisplayPic(),
  isPremium: false,
  createdAt: DateTime.now(),
).obs;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = getStorage.read('theme') ?? 'system';

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) => GraphQLProvider(
        client: graphqlClient,
        child: GetMaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: Themes.light,
          darkTheme: Themes.dark,
          themeMode: currentTheme == 'light'
              ? ThemeMode.light
              : currentTheme == 'dark'
                  ? ThemeMode.dark
                  : ThemeMode.system,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
