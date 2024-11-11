import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_registration_api/data/local/connectivity_page.dart';
import 'package:user_registration_api/data/local/db_helper.dart';
import 'package:user_registration_api/data/remote/api_helper.dart';
import 'package:user_registration_api/screens/offline/bloc/user_bloc.dart';
import 'package:user_registration_api/screens/online/bloc/online_bloc.dart';
import 'package:user_registration_api/screens/registration_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectivityPage().ConnectivityServices();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context){
      return OfflineUserBloc(mainDb: DbHelper.getInstance);
    }),
    BlocProvider(create: (context){
      return OnlineBloc(apiHelper: ApiHelper());
    }),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RegistrationPage(),
    );
  }
}

