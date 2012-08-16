#library('dcache');
#import('dart:core');
#import('dart:json');

#source('DCDocument.dart');
#source('DCProvider.dart');
#source('DCCollection.dart');
#source('DCException.dart');

/**
*
*/
class DCache extends Object
{
    DCProvider _source;
    String   _dbname;

    DCache (DCProvider prov, String db_name)
    {
        this._source = prov;
        this._dbname = db_name;
    }

  /**
  * Gets a [collection] using the square bracket operators. See also [getCollection].
  * ---
  */
  DCCollection operator [] (String name) => this.getCollection(name);

  /**
  * Gets a [collection] specified by [name].
  * ---
  */
  DCCollection getCollection (String name) => new DCCollection(this._source, this._dbname, name);

  /**
  * Returns the [String] representation of the current database.
  * ---
  */
  toString() => "[DCache(${this._dbname})]";
}
