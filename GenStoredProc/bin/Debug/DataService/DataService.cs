using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DataService
{
    public class DataService :  IDataService
    {
        private readonly IDbConnection _connection;

        public IDbConnection Connection
        {
            get
            {
                if (_connection.State != ConnectionState.Open && _connection.State != ConnectionState.Connecting)
                    _connection.Open();
                return _connection;
            }
        }

        public DataService()
        {
            _connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
        }

        public DataService(IDbConnection connection)
        {
            _connection = connection;
        }

        public void Dispose()
        {
            if (_connection == null || _connection.State == ConnectionState.Closed)
                return;
            _connection.Close();
        }
        
    }
}