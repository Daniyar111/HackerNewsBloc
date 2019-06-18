import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository/repository.dart';

class StoriesBloc{

  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  Observable<Map<int, Future<ItemModel>>> items;

  StoriesBloc(){
    items = _items.stream.transform(_itemTransformer());
  }

  // Getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;

  // Getters to Sinks
  Function(int) get fetchItem => _items.sink.add;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemTransformer(){

    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, int index){
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{}
    );
  }

  void dispose(){
    _topIds.close();
    _items.close();
  }
}