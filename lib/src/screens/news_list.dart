import 'package:flutter/material.dart';

import 'package:news/src/blocs/stories/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {

  @override
  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              bloc.fetchItem(snapshot.data[index]);

              return NewsListTile(
                itemId: snapshot.data[index],
              );
            },
          ),
        );
      },
    );
  }

//  Widget _buildList(){
//
//    return ListView.builder(
//      itemCount: 1000,
//      itemBuilder: (context, index){
//        return FutureBuilder(
//          future: getFuture(),
//          builder: (context, snapshot){
//
//            return Container(
//              height: 80,
//              child: snapshot.hasData
//                  ? Text('I\'m visible $index ${snapshot.data}')
//                  : Text('I\'m not visible yet $index ${snapshot.data}'),
//            );
//          },
//        );
//      },
//    );
//  }
//
//  getFuture(){
//    return Future.delayed(Duration(seconds: 2), () => 'hi');
//  }
}
