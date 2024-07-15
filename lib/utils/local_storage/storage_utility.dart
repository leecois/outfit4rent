import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  late final GetStorage _storage;

  static TLocalStorage? _instance;

  TLocalStorage._internal();

  static Future<TLocalStorage> init(String bucketName) async {
    if (_instance == null) {
      await GetStorage.init(bucketName);
      _instance = TLocalStorage._internal();
      _instance!._storage = GetStorage(bucketName);
    }
    return _instance!;
  }

  static TLocalStorage get instance {
    if (_instance == null) {
      throw StateError('TLocalStorage has not been initialized. Call TLocalStorage.init() first.');
    }
    return _instance!;
  }

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}


/// *** *** *** *** *** Example *** *** *** *** *** ///

// LocalStorage localStorage = LocalStorage();
//
// // Save data
// localStorage.saveData('username', 'JohnDoe');
//
// // Read data
// String? username = localStorage.readData<String>('username');
// print('Username: $username'); // Output: Username: JohnDoe
//
// // Remove data
// localStorage.removeData('username');
//
// // Clear all data
// localStorage.clearAll();

