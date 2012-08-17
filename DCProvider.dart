/**
* A standard interface for implement dcache document providers.
* ---
*/
interface DCProvider
{
    /**
    * Indicates whether or not the document [id] is in [db].[coll]
    * ---
    */
    bool containsId (String db, String coll, String id);

    /**
    * Returns the number of documents in [db].[coll]
    * ---
    */
    int count (String db, String coll);

    /**
    * Returns every document in [db].[coll] as a collection
    * ---
    */
    Collection<DCDocument> getAll (String db, String coll);

    /**
    * Retrieves a document by its [id] from [db].[coll]
    * ---
    */
    DCDocument getItem (String db, String coll, String id);

    /**
    * Returns a list of documents matched by [fn] from [db].[coll]
    * ---
    */
    Collection<DCDocument> query (String db, String coll, bool fn(DCDocument doc));

    /**
    * Removes a single document from [db].[coll]
    * ---
    */
    void removeItem (String db, String coll, String id);

    /**
    * Removes a collection of documents from database [db]
    * ---
    */
    void removeCollection (String db, String coll);

    /**
    * Removes a database
    * ---
    */
    void removeDatabase (String db);

    /**
    * Stores (upsert) a document in [db].[coll]
    * ---
    */
    void setItem (String db, String coll, DCDocument document);

    /**
    * An instance property flag if errors should be ignored
    * ---
    */
    bool ignorant;
}
