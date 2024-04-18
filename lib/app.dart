import 'package:flutter/material.dart';
import 'package:news_weather/news/view/news_page.dart';

class News extends MaterialApp {
  const News({Key? key})
      : super(
          key: key,
          home: const NewsPage(),
        );
}
