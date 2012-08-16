/**
*
*/
class DCDocument extends Object
{
    Map<String,Dynamic> _data;

    DCDocument ([String id])
    {
      _data = new Map<String,Dynamic>();
      if(id != null) {
        this["_id"] = id;
      }
      else {
        this["_id"] = new Date.now().millisecondsSinceEpoch.toString();
      }
    }

    static DCDocument fromJSON (String jsonString)
    {
      var doc = new DCDocument();
      doc._data = JSON.parse(jsonString);
      return doc;
    }

    noSuchMethod(String function_name, List args)
    {
      if (args.length == 0 && function_name.startsWith("get:"))
      {
        var property = function_name.replaceFirst("get:", "");
        if (this._data.containsKey(property)) {
          return this[property];
        }
      }
      else if (args.length == 1 && function_name.startsWith("set:")) {
        var property = function_name.replaceFirst("set:", "");
        this[property] = args[0];
        return this[property];
      }

      super.noSuchMethod(function_name, args);
    }

    toString() => JSON.stringify(this._data);

    Map toMap() => new Map.from(this._data);

    operator [] (key) => this._data[key];

    operator []= (key,value) => this._data[key] = value;
}