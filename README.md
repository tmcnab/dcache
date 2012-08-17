# dcache #

dcache is a document-based storage system written in [Dart](http://dartlang.org). 

## usage ##

Say you want to save some people into dcache on the client side using localStorage:

    // Import the libraries
    #import('dart:html');
    #import('dcache/DCache.dart');
    #import('dcache/providers/LocalStorage.dart');

    void main()
    {
        // create a localStorage db provider
        DCProvider lsp = new LocalStorageProvider(window);
        
        // create a database called 'test_db'
        DCDatabase cache = new DCDatabase(lsp, "test_db");

        // grab the 'people' collection from the database
        var people = cache["people"];

        // create a new person document (_id will be provided if not specified)
        var p1 = new DCDocument();
        var p2 = new DCDocument();
        
        // set some fields using dot notation
        p1.firstName = "John";
        p1.lastName = "Doe";
        p1.age = 27;
        
        // set some document fields using traditional map syntax
        p2['firstName'] = "Jane";
        p2['lastName'] = "Citizen";
        
        // insert document into collection (will fail if _id already exists)
        people.insert(p1);
        
        // save will upsert (insert OR update) the document
        people.save(p2);

        // update the first person's age (will fail if p1's id doesn't already exist)
        p1.age = 28;
        people.update(p1);
        
        // query collection for people that have a firstname
        // starting with "John"
        people.query((p) => p.firstName.startsWith("John")).forEach((q) => print(q));
        
        // returns: {"firstName":"John","_id":"1345174232925","lastName":"Doe","age":28}
    }

## licence ##

Copyright (c) 2011-2012, Seditious Technologies
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.