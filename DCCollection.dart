/**
* Represents a grouping of documents
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
    * Returns the number of documents in this collection
    * ---
    */
    int count ()
    {
        return this._provider.count(this._dbName, this._collName);
    }

    /**
    * Inserts a document into the collection
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

    /**
    * Queries the collection for documents, returning the documents as a native collection
    * ---
    */
    Collection<DCDocument> query (bool fn(DCDocument doc))
    {
        return this._provider.query(this._dbName, this._collName, fn);
    }

    /**
    * Removes a single document from the collection
    * ---
    */
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

    /**
    * Removes all documents in this collection
    * ---
    */
    void removeAll ()
    {
        this._provider.removeCollection(this._dbName, this._collName);
    }

    /**
    * Upserts (insert or update) a document into the collection
    * ---
    */
    void save (DCDocument doc)
    {
        this._provider.setItem(this._dbName, this._collName, doc);
    }

    /**
    * Returns all documents in the collection as a native collection
    * ---
    */
    Collection<DCDocument> toCollection ()
    {
        return new List<DCDocument>.from(this._provider.getAll(this._dbName, this._collName));
    }

    /**
    * Updates an existing document in the collection
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
