/**
* A custom exception that will be thrown if an error occurs in dcache
* ---
*/
class DCException implements Exception
{
    String _errorMessage;

    DCException ([String errorMessage]) : super ()
    {
        this._errorMessage = errorMessage;
    }
}
