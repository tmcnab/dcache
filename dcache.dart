#library('dcache');
#import('dart:core');
#import('dart:json');

#source('document.dart');
#source('provider.dart');
#source('collection.dart');

/**
*
*/
class dcache extends Object
{
  provider _source;
  String   _dbname;

  dcache (provider prov, String db_name)
  {
    this._source = prov;
    this._dbname = db_name;
  }

  /**
  * Gets a [collection] using the square bracket operators. See also [getCollection].
  * ---
  */
  collection operator [] (String name) => this.getCollection(name);

  /**
  * Gets a [collection] specified by [name].
  * ---
  */
  collection getCollection (String name) => new collection(this._source, this._dbname, name);

  /**
  * Returns the [String] representation of the current database.
  * ---
  */
  toString() => "[dCache(${this._dbname})]";
}
