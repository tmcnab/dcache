
interface provider {
  document getItem          (String db, String coll, String key);
  void     setItem          (String db, String coll, document document);
  void     removeItem       (String db, String coll, String key);
  bool     containsKey      (String db, String coll, String key);
  void     removeCollection (String db, String coll);
  void     removeDatabase   (String db);
}
