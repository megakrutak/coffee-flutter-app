
abstract class CacheManager {

  Type read<Type>() ;

  void write(dynamic data);

  void clear<Type>();

  void clearAll();

}

class MemoryCacheManager implements CacheManager {
  Map<Type, dynamic> _data = Map.of({});

  @override
  void clear<Type>() {
    if (_data.containsKey(Type)) {
      _data.remove(Type);
    }
  }

  @override
  void clearAll() {
    _data.clear();
    _data = Map.of({});
  }

  @override
  Type read<Type>() {
    return _data[Type];
  }

  @override
  void write(dynamic data) {
    _data[data.runtimeType] = data;
  }
}