#library('dcache:html');
#import('dart:html');
#import('dart:json');
#import('../dcache.dart');

class localStorageProvider implements provider
{
  Storage _storage;

  localStorageProvider(Window window) {
    this._storage = window.localStorage;
  }

  String _generateKey (String db, String coll, String key) {
    return "dcache.${db}.${coll}.${key}";
  }

  document getItem (String db, String coll, String key) {
    return document.fromJSON(this._storage[this._generateKey(db,coll,key)]);
  }

  void setItem (String db, String coll, document doc) {
    this._storage[this._generateKey(db,coll,doc["_id"])] = doc.toString();
  }

  void removeItem (String db, String coll, String key) {
    this._storage.remove(this._generateKey(db, coll, key));
  }

  bool containsKey (String db, String coll, String key) {
    return this._storage.containsKey(this._generateKey(db,coll,key));
  }

  void removeCollection (String db, String coll) {
    var _partialKey = "dcache.${db}.${coll}";
    this._storage.getKeys().forEach((p) {
      if (p.startsWith(_partialKey)) {
        this._storage.remove(p);
      }
    });
  }

  void removeDatabase (String db) {
    var _partialKey = "dcache.${db}";
    this._storage.getKeys().forEach((p) {
      if (p.startsWith(_partialKey)) {
        this._storage.remove(p);
      }
    });
  }
}
