#library('dcache:providers:file');
#import('dart:io');
#import('dart:json');
#import('../DCache.dart');

class FileStorageProvider implements DCProvider
{
    Path _dbdir;
    bool ignorant;

    FileStorageProvider (Directory workingDirectory, [bool isIgnorant])
    {
      this._dbdir = new Path(workingDirectory.path).append("dcache");
      var dir = new Directory.fromPath(this._dbdir);
      if(!dir.existsSync()) dir.createSync();

      this.ignorant = (isIgnorant != null) ? isIgnorant : false;
    }

    Path _gns(String db, [String coll, String key])
    {
        if (coll == null) {
            return _dbdir.append(db);
        }
        else {
            if (key == null) {
                return _dbdir.append(db).append(coll);
            }
            else {
                return _dbdir.append(db).append(coll).append(key);
            }
        }
    }

    void _throwError (String message) {
      if (!this.ignorant) {
        throw new DCException();
      }
    }

    Collection<File> _getDirectoryFiles (Directory dir)
    {
      print("Getting files");
      List<File> files = new List<File>();

      var isDone = false;
      DirectoryLister lister = dir.list(false);

      lister.onFile = (file) {
        print("Found a file $file");
        files.add(new File(file));
        print("Found file: ${file.path}");
      };

      lister.onDone = (completed) {
        isDone = true;
        print("$completed completed");
      };

      while(!isDone);

      return files;
    }

    // really not sure this'll work ...
    int count (String db, String coll)
    {
      var d = new Directory.fromPath(_gns(db,coll));
      if (d.existsSync()) {
        int _count = 0;
        var listOperation = d.list(false);
        bool isDone = false;

        listOperation.onFile = (file) {
          _count++;
        };

        listOperation.onDone = (completed) {
          isDone = completed;
        };

        while(!isDone);
      }
      else {
        _throwError("Specified database or collection does not exist.");
      }
    }

    bool containsId (String db, String coll, String key)
    {
        File f = new File.fromPath(_gns(db,coll,key));
        return f.existsSync();
    }

    DCDocument getItem (String db, String coll, String key)
    {
        File f = new File.fromPath(_gns(db,coll,key));
        if (f.existsSync()) {
            return DCDocument.fromJSON(f.readAsTextSync());
        }
        else {
            _throwError("Specified db/collection/document does not exist.");
        }
    }

    Collection<DCDocument> getAll (String db, String coll)
    {
        List<DCDocument> docs = new List<DCDocument>();
        Directory dir = new Directory.fromPath(_gns(db,coll));

        if(!dir.existsSync()) {
          this._throwError("Specified db/collection does not exist.");
        }

        for (File f in this._getDirectoryFiles(dir))
        {
            docs.add(DCDocument.fromJSON(f.readAsTextSync()));
        }

        return docs;
    }

    Collection<DCDocument> query (String db, String coll, String queryString)
    {
      // implementation here

      return new List<DCDocument>();
    }

    void removeItem (String db, String coll, String key)
    {
        File f = new File.fromPath(_gns(db,coll,key));
        if (f.existsSync()) {
          f.deleteSync();
        }
        else {
          _throwError("Specified db/collection/document does not exist.");
        }
    }

    void setItem (String db, String coll, DCDocument doc)
    {
        var dbdir = new Directory.fromPath(_gns(db));
        print(dbdir.path);
        if(!dbdir.existsSync()) dbdir.createSync();

        var collDir = new Directory.fromPath(_gns(db,coll));
        if (!collDir.existsSync()) collDir.createSync();

        File f = new File.fromPath(_gns(db,coll,doc["_id"]));
        if (!f.existsSync()) {
          f.createSync();
        }

        var os = f.openOutputStream();
        os.writeString(doc.toString());
        os.close();
    }

    void removeCollection (String db, String coll) {
      throw new NotImplementedException();
    }

    void removeDatabase (String db)
    {
      throw new NotImplementedException();
    }
}
