import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/fetch_post_bloc.dart';
import 'screens/post_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FetchPostDataBloc()),
      ],
      child: MaterialApp(
        title: 'Posts',
        theme: ThemeData(),
        home: const PostScreen(),
      ),
    );
  }
}
