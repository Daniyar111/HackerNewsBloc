import 'package:flutter/material.dart';

import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = StoriesProvider.of(context);

    // THIS IS BAD!!! DON'T DO THIS
    // TEMPORARY
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
//      body: _buildList(),
      body: _buildList(bloc),
    );
  }

  Widget _buildList(StoriesBloc bloc){

    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){

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
