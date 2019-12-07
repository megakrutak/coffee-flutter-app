import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:robo_coffee_app/base/json_encodable.dart';

abstract class CacheManager {

  Future<Map<String, dynamic>> read<Type>();

  Future<void> write(JsonEncodable data);

  Future<void> clear<Type>();

  Future<void> clearAll();
}

class MemoryCacheManager implements CacheManager {
  Map<Type, Map<String, dynamic>> _data = Map.of({});

  @override
  Future<void> clear<Type>() async {
    if (_data.containsKey(Type)) {
      _data.remove(Type);
    }
  }

  @override
  Future<void> clearAll() async {
    _data.clear();
    _data = Map.of({});
  }

  @override
  Future<Map<String, dynamic>> read<Type>() async {
    return _data[Type];
  }

  @override
  Future<void> write(JsonEncodable data) async {
    _data[data.runtimeType] = data.toJson();
  }
}

class FileCacheManager implements CacheManager {

  final String localPath;

  FileCacheManager({@required this.localPath}) : assert(localPath != null);

  @override
  Future<void> clear<Type>() async {
    var dir = await _getCacheDir();
    var file = File(_getFilePath(dir, Type.toString()));
    var exists = await file.exists();
    if (exists) {
      await file.delete();
    }
  }

  @override
  Future<void> clearAll() async {
    var dir = await _getCacheDir();
    var exists = await dir.exists();
    if (exists) {
      await dir.delete(recursive: true);
    }
  }

  @override
  Future<Map<String, dynamic>> read<Type>() async {
    var dir = await _getCacheDir();
    var file = File(_getFilePath(dir, Type.toString()));
    var exists = await file.exists();
    if (!exists) {
      return null;
    }

    var data = await file.readAsString();
    return json.decode(data);
  }

  @override
  Future<void> write(JsonEncodable data) async {
    var fileName = data.runtimeType.toString();
    var dir = await _getCacheDir();
    var exists = await dir.exists();
    if (!exists) {
      await dir.create();
    }

    await File(_getFilePath(dir, fileName))
        .writeAsString(json.encode(data.toJson()));
  }

  Future<Directory> _getCacheDir() async {
    final tempDir = await getTemporaryDirectory();
    var dir = Directory("${tempDir.path}/$localPath");
    return dir;
  }

  String _getFilePath(Directory dir, String typeName) {
    return "${dir.path}/$typeName.json";
  }
}