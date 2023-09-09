import 'package:dummy_project/core/services/injection_container.dart';
import 'package:dummy_project/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:dummy_project/src/auth/presentation/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<AuthBloc>(),
      child: MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
