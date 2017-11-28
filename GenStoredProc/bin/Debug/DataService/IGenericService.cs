using System.Collections.Generic;

namespace TIMLibrary.DataService
{
    public interface IGenericService<TEntity> : IDataService where TEntity : class
    {
        IEnumerable<TEntity> GetAll();
        TEntity GetById(object filter);
        bool Insert(TEntity item);
        bool Update(TEntity item);
        bool Delete(object filter);
    }
}