using System;
using System.Data;

namespace TIMLibrary.DataService
{
    public interface IDataService: IDisposable
    {
        IDbConnection Connection { get; }
    }
}
