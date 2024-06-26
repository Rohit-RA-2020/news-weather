import 'package:bloc/bloc.dart';
import 'package:news_weather/news/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsCubit extends Cubit<NewsDataModel> {
  NewsCubit()
      : super(NewsDataModel(status: 'initial', articles: [], totalResults: 0));

  void storeNews() {
    emit(NewsDataModel(status: 'loading', articles: [], totalResults: 0));
    http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=dee04e97a7004d10b103ffb7baba4e15'))
      ..then((value) {
        if (value.statusCode == 200) {
          emit(newsDataModelFromJson(value.body));
        } else {
          emit(NewsDataModel(status: 'error', articles: [], totalResults: 0));
        }
      });
  }
}
