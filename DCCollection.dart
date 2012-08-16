/**
* Represents a grouping of dcache documents.
* ---
*/
class DCCollection
{
    DCProvider _provider;
    String     _dbName;
    String     _collName;

    DCCollection (DCProvider provider, String dbName, String collectionName)
    {
        this._provider = provider;
        this._dbName = dbName;
        this._collName = collectionName;
    }

    /**
    * Returns the number of documents in this [collection].
    * ---
    */
    int count ()
    {
        return this._provider.count(this._dbName, this._collName);
    }

    /**
    * Inserts a document into this [collection] instance.
    * ---
    */
    void insert (DCDocument doc)
    {
        if (!this._provider.containsId(this._dbName, this._collName, doc["_id"])) {
            this._provider.setItem(this._dbName, this._collName, doc);
        }
        else {
            if (!this._provider.ignorant) {
                throw new DCException();
            }
        }
    }

    void remove (DCDocument doc)
    {
        if (!this._provider.containsId(this._dbName, this._collName, doc["_id"])) {
            this._provider.removeItem(this._dbName, this._collName, doc["_id"]);
        }
        else {
            if (!this._provider.ignorant) {
                throw new DCException();
            }
        }
    }

    void removeAll ()
    {
        this._provider.removeCollection(this._dbName, this._collName);
    }

    /**
    * Upserts a document to this [collection] instance.
    */
    void save (DCDocument doc)
    {
        this._provider.setItem(this._dbName, this._collName, doc);
    }

    List<DCDocument> toList()
    {
        return new List<DCDocument>.from(this._provider.getAll(this._dbName, this._collName));
    }

    /**
    * Updates an existing [document].
    */
    void update (DCDocument doc)
    {
      if (this._provider.containsId(this._dbName, this._collName, doc["_id"])) {
          this._provider.setItem(this._dbName, this._collName, doc);
      }
      else {
          if (!this._provider.ignorant) {
              throw new DCException();
          }
      }
    }
}
