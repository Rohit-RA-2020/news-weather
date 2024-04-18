import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_weather/news/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/nav_cubit.dart';
import '../cubit/news_cubit.dart';

List<Widget> _pages = <Widget>[
  AllNewsWidget(),
  FavoriteNewsWidget(),
  SavedNewsWidget(),
];

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NewsCubit>().storeNews();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, int>(
      builder: (context, navBarState) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            centerTitle: true,
            title: const Text('Good Afternoon John Doe'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '32 °C',
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          body: _pages[navBarState],
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              context.read<NavBarCubit>().updateIndex(index);
            },
            indicatorColor: Theme.of(context).colorScheme.inversePrimary,
            selectedIndex: navBarState,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.newspaper),
                icon: Icon(Icons.newspaper_outlined),
                label: 'All News',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.bookmark),
                label: 'Saved News',
              ),
            ],
          ),
        );
      },
    );
  }
}

class AllNewsWidget extends StatelessWidget {
  const AllNewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<NewsCubit, NewsDataModel>(
        builder: (context, state) {
          return state.status == 'initial'
              ? Text('No news Items')
              : ListView.builder(
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) {
                    return NewsItem(
                      title: state.articles[index].title,
                      heading: state.articles[index].description ?? "No desc",
                      image: state.articles[index].urlToImage ??
                          "https://t3.ftcdn.net/jpg/05/52/37/18/360_F_552371867_LkVmqMEChRhMMHDQ2drOS8cwhAWehgVc.jpg",
                      url: state.articles[index].url,
                    );
                  },
                );
        },
      ),
    );
  }
}

class FavoriteNewsWidget extends StatelessWidget {
  const FavoriteNewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favorite News'),
    );
  }
}

class SavedNewsWidget extends StatelessWidget {
  const SavedNewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Your Saved News here'),
    );
  }
}

class NewsItem extends StatelessWidget {
  const NewsItem({
    super.key,
    required this.title,
    required this.heading,
    required this.image,
    required this.url,
  });

  final String title;
  final String heading;
  final String image;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      leading: SizedBox(
        width: 100, // Set the desired width
        height: 100, // Set the desired height
        child: Image.network(image),
      ),
      title: Text(title),
      subtitle: Text(heading),
    );
  }
}
