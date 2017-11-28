using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
namespace GenStoredProc
{
    class Program
    {
        public static string ConnectionString { get; set; }
        public static string SaveToPath { get; set; }

        public class GenInfo
        {
            public string PrimaryKey { get; set; }
            public Dictionary<string, string> Colunms { get; set; }
            public GenInfo()
            {
                Colunms = new Dictionary<string, string>();
            }

        }

        static void Main(string[] args)
        {

            ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString();// "Data Source=MACDEVWIN10;Initial Catalog=Mukuru;Integrated Security=True;";
            SaveToPath = ConfigurationManager.AppSettings["SaveToPath"];

            Console.WriteLine("GENERATOR CRUD STRORED PROCEDURE   --- SAVING PATH: {0}" + SaveToPath);

            string tableName = null;

            do
            {
                try
                {
                    Console.WriteLine("Enter An Existing Table Name Or Type QUIT then Press ENTER to Exit: ");
                    tableName = Console.ReadLine();
                    Console.WriteLine("Generating CRUD Strored Procedure for Table: {0}", tableName);

                    if (tableName == null)
                        throw new ArgumentNullException(nameof(tableName));

                    //char[] a = tableName.ToLower().ToCharArray();
                    //a[0] = char.ToUpper(a[0]);
                    //tableName = new string(a);

                    Program.GenStoredProc(tableName);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error during app ! {0}", ex.Message);
                }

            } while (tableName != null && tableName != "QUIT");


        }



        public static GenInfo GetTableGenInfo(string tableName)
        {



            var genInfo = new GenInfo();

            using (var connection = new SqlConnection(ConnectionString))
            {
                try
                {
                    connection.Open();
                    DataTable dtColumnInfo = connection.GetSchema("Columns", new string[] { null, null, tableName });
                    DataRow rowColumnInfo;
                    if (dtColumnInfo.Rows.Count >= 1)
                    {
                        for (int i = 0; i < dtColumnInfo.Rows.Count; i++)
                        {
                            rowColumnInfo = dtColumnInfo.Rows[i];


                            switch (rowColumnInfo["DATA_TYPE"])
                            {
                                case "nchar":
                                case "nvarchar":
                                case "char":
                                case "varchar":
                                    genInfo.Colunms.Add(Convert.ToString(rowColumnInfo["COLUMN_NAME"]), Convert.ToString(rowColumnInfo["DATA_TYPE"]) + "(" + (Convert.ToString(rowColumnInfo["CHARACTER_MAXIMUM_LENGTH"]) + ")"));
                                    break;
                                case "decimal":
                                case "numeric":
                                    genInfo.Colunms.Add(Convert.ToString(rowColumnInfo["COLUMN_NAME"]), Convert.ToString(rowColumnInfo["DATA_TYPE"]) + "(" + Convert.ToString(rowColumnInfo["NUMERIC_PRECISION"]) + "," + Convert.ToString(rowColumnInfo["NUMERIC_SCALE"]) + ")");
                                    break;
                                default:
                                    genInfo.Colunms.Add(Convert.ToString(rowColumnInfo["COLUMN_NAME"]), Convert.ToString(rowColumnInfo["DATA_TYPE"]));
                                    break;
                            }



                            var sql = @"SELECT K.COLUMN_NAME
                        FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS C
                        JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS K
                        ON C.TABLE_NAME = K.TABLE_NAME
                        AND C.CONSTRAINT_CATALOG = K.CONSTRAINT_CATALOG
                        AND C.CONSTRAINT_SCHEMA = K.CONSTRAINT_SCHEMA
                        AND C.CONSTRAINT_NAME = K.CONSTRAINT_NAME
                        WHERE C.CONSTRAINT_TYPE = 'PRIMARY KEY' AND  K.TABLE_NAME='" + tableName + "'";


                            var command = new SqlCommand(sql, connection);

                            genInfo.PrimaryKey = Convert.ToString(command.ExecuteScalar());

                        }
                    }
                    else
                    {
                        Console.WriteLine("TABLE {0} DOES NOT EXIST OR COULD NOT RETREIVE METADATA !", tableName);
                    }

                }
                catch (Exception ex)
                {

                }


            }

            return genInfo;
        }

        public static void GenStoredProc(string tableName)
        {

            var info = GetTableGenInfo(tableName);

            if (String.IsNullOrEmpty(info.PrimaryKey))
            {
                return;
            }

            var tpl = File.ReadAllText("tpl/GenCRUDStoredProc.tpl");

            var genStr = new StringBuilder(tpl);

            genStr.Replace("<<TableName>>", tableName);
            genStr.Replace("<<KeyColunm>>", info.PrimaryKey);
            genStr.Replace("<<KeyColunmType>>", info.Colunms.Single(p => p.Key.Equals(info.PrimaryKey)).Value);

            var genParam = new StringBuilder("");
            var genUpdateCols = new StringBuilder("");
            var genInsertCols = new StringBuilder("");
            var genInsertValues = new StringBuilder("");
            foreach (var col in info.Colunms)
            {

                genParam.Append("@" + col.Key + " " + col.Value).AppendLine(",");
                genUpdateCols.Append("[" + col.Key + "] = @" + col.Key).AppendLine(",");
                genInsertCols.Append("[" + col.Key + "]").AppendLine(",");
                genInsertValues.Append("@" + col.Key).AppendLine(",");


            }
            genStr.Replace("<<ParamColunms>>", genParam.Remove(genParam.Length - 3, 3).ToString());
            genStr.Replace("<<UpdateColunms>>", genUpdateCols.Remove(genUpdateCols.Length - 3, 3).ToString());
            genStr.Replace("<<InsertColunms>>", genInsertCols.Remove(genInsertCols.Length - 3, 3).ToString());
            genStr.Replace("<<InsertValues>>", genInsertValues.Remove(genInsertValues.Length - 3, 3).ToString());


            File.WriteAllText("sql/" + tableName + "_GenCRUDStoredProc.sql", genStr.ToString());
            Console.WriteLine("OK DONE!");

        }



    }
}
