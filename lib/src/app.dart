import 'package:flutter/material.dart';

import 'blocs/comments/comments_provider.dart';
import 'screens/news_list.dart';
import 'screens/news_detail.dart';
import 'package:news/src/blocs/stories/stories_provider.dart';


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
//        debugShowCheckedModeBanner: false,
          title: 'News!',
          onGenerateRoute: routes,
        )
      ),
    );
  }

  Route routes(RouteSettings settings){

    if(settings.name == '/'){
      return MaterialPageRoute(
        builder: (context){

          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();

          return NewsList();
        }
      );
    }
    else{
      return MaterialPageRoute(
        builder: (context){

          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(
            itemId: itemId
          );
        }
      );
    }
  }
}
