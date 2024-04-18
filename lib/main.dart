import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_weather/app.dart';

import 'news_observer.dart';

void main() {
  Bloc.observer = NewsObserver();
  runApp(const News());
}
