/**
* Represents a grouping of dcache documents.
* ---
*/
class collection
{
    provider _provider;
    String _dbName;
    String _collName;

    collection (provider provider, String dbName, String collectionName)
    {
        this._provider = provider;
        this._dbName = dbName;
        this._collName = collectionName;
    }

  //------------------------------------------------------------------------//

    /**
    * Inserts a document into this [collection] instance.
    * ---
    */
    bool insert (document doc)
    {
        if (!this._provider.containsKey(this._dbName, this._collName, doc["_id"]))
        {
            this._provider.setItem(this._dbName, this._collName, doc);
            return true;
        }
        else
        {
            return false;
        }
    }

  void save (document doc) {
    this._provider.setItem(this._dbName, this._collName, doc);
  }

  bool update (document doc) {
    if(this._provider.containsKey(this._dbName, this._collName, doc["_id"])) {
      this._provider.setItem(this._dbName, this._collName, doc);
      return true;
    }
    else {
      return false;
    }
  }
}
