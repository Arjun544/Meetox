import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/instances.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/splash_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'core/time_ago_messages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await graphqlInit();
  await dotenv.load();
  timeago.setLocaleMessages('en', TimeAgoMessages());

  // if (getStorage.read('first_run') ?? true) {
  //   await SecureStorageServices.clearAll();
  //   await getStorage.write('first_run', false);
  // }

  // Map tiles caching
  await FlutterMapTileCaching.initialise(
    rootDirectory: null,
    settings: FMTCSettings(
      databaseMaxSize: FMTCTileProviderSettings().maxStoreLength,
    ),
    debugMode: true,
  );

  final mapLight = FMTC.instance('Map light');
  final mapDark = FMTC.instance('Map dark');
  final mapSky = FMTC.instance('Map sky');
  final mapMeetox = FMTC.instance('Map meetox');

  await mapLight.manage.createAsync();
  await mapDark.manage.createAsync();
  await mapSky.manage.createAsync();
  await mapMeetox.manage.createAsync();

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
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: GetMaterialApp(
            title: 'Meetox',
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
      ),
    );
  }
}
