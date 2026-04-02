import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show exit;
import 'package:td2_mobile/ui/addtask.dart';
import 'package:td2_mobile/ui/mytheme.dart';
import 'package:td2_mobile/ui/ecran1.dart';
import 'package:td2_mobile/ui/ecran2.dart';
import 'package:td2_mobile/ui/ecran3.dart';
import 'package:td2_mobile/ui/settings.dart';
import 'package:td2_mobile/viewmodel/settingsviewmodel.dart';
import 'package:td2_mobile/viewmodel/taskviewmodel.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://twuzlqinrgesqedrishs.supabase.co",
    anonKey: "sb_publishable_bkA61cg_crZZ51M2bzsMwg_vf5eHR8t",
  );
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    databaseFactory = databaseFactoryFfi;
  }
  final String dbPath = join(await getDatabasesPath(), 'task.db');
  final Database database = await openDatabase(
    dbPath,
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, nbhours INTEGER, difficulty INTEGER, tags TEXT, connecterSupabase INTEGER DEFAULT 0)",
      );
    },
    version: 1,
  );
  runApp(MyApp(database));
}

// It's handy to then extract the Supabase client in a variable for later uses
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  final Database database;
  const MyApp(this.database, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            SettingViewModel settingviewmodel = SettingViewModel();
            return settingviewmodel;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            TaskViewModel taskViewModel = TaskViewModel(database);
            return taskViewModel;
          },
        ),
      ],
      child: Consumer<SettingViewModel>(
        builder: (context, SettingViewModel notifier, child) {
          return MaterialApp(
            title: 'TD2',
            theme: context.watch<SettingViewModel>().isDark
                ? MyTheme.dark()
                : MyTheme.light(),
            home: MyHomePage(title: "TD2"),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> mesPages = [
    ScreenOne(),
    ScreenTwo(),
    ScreenThree(),
    EcranSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TD2", style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTask()),
                );
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox.shrink(),
      body: mesPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Theme.of(
          context,
        ).bottomNavigationBarTheme.unselectedItemColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.eleven_mp_sharp),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
