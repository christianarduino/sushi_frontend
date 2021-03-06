import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sushi/redux/reducers/index.dart';
import 'package:sushi/redux/store/AppState.dart';
import 'package:sushi/screens/LoginPage/login_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sushi/utils/functions.dart';

void main() async {
  final Store<AppState> store = Store(
    reducers,
    initialState: AppState(),
    middleware: [thunkMiddleware],
  );
  await DotEnv().load('.env');
  runApp(SushiApp(store: store));
}

class SushiApp extends StatefulWidget {
  final Store<AppState> store;

  SushiApp({this.store});

  @override
  _SushiAppState createState() => _SushiAppState();
}

class _SushiAppState extends State<SushiApp> {
  @override
  void initState() {
    super.initState();
    initStatusBar();
  }

  final accentColor = Color(0xFFEF586C);
  final primaryColor = Color(0xFF433C3F);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: widget.store,
      child: MaterialApp(
        theme: ThemeData(
          canvasColor: Color(0xfffafafa),
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              title: TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            elevation: 0,
            color: Color(0xfffafafa),
            iconTheme: IconThemeData(
              color: primaryColor,
            ),
            brightness: Brightness.light,
          ),
          fontFamily: 'Poppins',
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: accentColor,
                width: 1.0,
              ),
            ),
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          primaryColor: primaryColor,
          cursorColor: accentColor,
          accentColor: accentColor,
          textTheme: TextTheme(
            body1: TextStyle(
              color: primaryColor,
            ),
            subtitle: TextStyle(
              color: Color(0xFFD1CFD0),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            Size size = MediaQuery.of(context).size;
            ScreenUtil.init(context, width: size.width, height: size.height);

            return LoginPage();
          },
        ),
      ),
    );
  }
}
