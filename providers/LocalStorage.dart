#library('dcache:providers:localStorage');
#import('dart:html');
#import('dart:json');
#import('../DCache.dart');

/**
*
*/
class LocalStorageProvider implements DCProvider
{
    Storage _storage;
    bool    ignorant;

    LocalStorageProvider (Window window, [bool isIgnorant])
    {
        this._storage = window.localStorage;
        if (isIgnorant != null) {
          this.ignorant = isIgnorant;
        }
    }


    String _gns (String db, [String coll, String key])
    {
       if (coll == null) {
           return "dcache.${db}";
       }
       else {
           if (key == null) {
               return "dcache.${db}.${coll}";
           }
           else {
               return "dcache.${db}.${coll}.${key}";
           }
       }
    }

    int count (String db, String coll)
    {
        int _count = 0;
        var ns = this._gns(db,coll);
        this._storage.getKeys().forEach((p)
        {
            if (p.startsWith(ns)) {
                _count++;
            }
        });

        return _count;
    }

    Collection<DCDocument> getAll (String db, String coll)
    {
        var ns = this._gns(db, coll);
        List<DCDocument> docs = new List<DCDocument>();

        this._storage.getKeys().forEach((p)
        {
            if (p.startsWith(ns)) {
                docs.add(DCDocument.fromJSON(this._storage[p]));
            }
        });

        return docs;
    }

    DCDocument getItem (String db, String coll, String key)
    {
        return DCDocument.fromJSON(this._storage[this._gns(db,coll,key)]);
    }

    void setItem (String db, String coll, DCDocument doc)
    {
        this._storage[this._gns(db,coll,doc["_id"])] = doc.toString();
    }

    void removeItem (String db, String coll, String key)
    {
        this._storage.remove(this._gns(db, coll, key));
    }

    bool containsId (String db, String coll, String key)
    {
        return this._storage.containsKey(this._gns(db,coll,key));
    }

    /**
    * Removes all data associated with a given collection name.
    * ---
    */
    void removeCollection (String db, String coll)
    {
        var ns = this._gns(db, coll);
        this._storage.getKeys().forEach((p)
        {
            if (p.startsWith(ns)) {
                this._storage.remove(p);
            }
        });
    }

    /**
    * Removes all data associated with a given database name.
    * ---
    */
    void removeDatabase (String db)
    {
        var ns = this._gns(db);
        this._storage.getKeys().forEach((p)
        {
            if (p.startsWith(ns)) {
                this._storage.remove(p);
            }
        });
    }
}
