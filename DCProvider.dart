
interface DCProvider
{
  Collection<DCDocument> getAll (String db, String coll);
    DCDocument getItem          (String db, String coll, String key);
          void setItem          (String db, String coll, DCDocument document);
          bool containsId       (String db, String coll, String key);
           int count            (String db, String coll);
          void removeItem       (String db, String coll, String key);
          void removeCollection (String db, String coll);
          void removeDatabase   (String db);
          bool ignorant;
}
