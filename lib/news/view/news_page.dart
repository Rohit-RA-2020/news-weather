import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_weather/news/cubit/nav_cubit.dart';
import 'package:news_weather/news/cubit/news_cubit.dart';
import 'package:news_weather/news/view/news_view.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(
          create: (context) => NewsCubit(),
        ),
        BlocProvider<NavBarCubit>(
          create: (context) => NavBarCubit(),
        ),
      ],
      child: const NewsView(),
    );
  }
}
