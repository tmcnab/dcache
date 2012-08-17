/**
* Represents a collection of named dcache collections
* ---
*/
class DCDatabase extends Object
{
    DCProvider _source;
    String   _dbname;

    DCDatabase (DCProvider prov, String db_name)
    {
        this._source = prov;
        this._dbname = db_name;
    }

    /**
    * Gets a collection using the square bracket operators. See also [getCollection]
    * ---
    */
    DCCollection operator [] (String name) => this.getCollection(name);

    /**
    * Gets a [collection] specified by [name]
    * ---
    */
    DCCollection getCollection (String name) => new DCCollection(this._source, this._dbname, name);
}