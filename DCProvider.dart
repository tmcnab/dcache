
interface DCProvider
{
    /**
    *
    */
    bool containsId (String db, String coll, String key);
           int count            (String db, String coll);
  Collection<DCDocument> getAll (String db, String coll);
    DCDocument getItem          (String db, String coll, String key);
   Collection<DCDocument> query (String db, String coll, String queryString);
          void removeItem       (String db, String coll, String key);
          void removeCollection (String db, String coll);
          void removeDatabase   (String db);
          void setItem          (String db, String coll, DCDocument document);
          bool ignorant;
}
