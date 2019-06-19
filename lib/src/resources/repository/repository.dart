import 'dart:async';

import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/providers/news_api_provider.dart';
import 'package:news/src/resources/providers/news_db_provider.dart';

import 'cache_repository.dart';
import 'source_repository.dart';

class Repository{

  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider()
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider
  ];

  Future<List<int>> fetchTopIds(){
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {

    ItemModel item;
    var source;

    for(source in sources){
      item = await source.fetchItem(id);
      if(item != null){
        break;
      }
    }

    for (var cache in caches){
      if(cache != source){
          cache.addItem(item);
      }
    }

    return item;
  }

  clearCache() async {
    for(var cache in caches){
      await cache.clear();
    }
  }
}
