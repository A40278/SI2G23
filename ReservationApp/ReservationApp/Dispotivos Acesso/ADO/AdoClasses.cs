using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;


namespace ReservationApp.Dispotivos_Acesso.ADO
{
    public partial class Ado
    {
        private List<T> obterListaInterno<T>(string query, Action<SqlCommand> addParammeters
            , Func<SqlDataReader, T> criarObjecto)
        {
            List<T> lista = new List<T>();
            using (SqlConnection con = new SqlConnection())
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    try
                    {
                        addParammeters?.Invoke(cmd);

                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            try
                            {
                                lista.Add(criarObjecto(reader));
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }

                        }
                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        con.Close();
                        Console.WriteLine(ex.Message);
                    }
                    con.Close();
                }
            }
            return lista;
        }


        public List<T> obterLista<T> (string query, Func<SqlDataReader,T> criarObjecto)
        {
            return obterListaInterno<T>(query, null, criarObjecto);
        }

        public List<T> obterLista<T>(string query, Action<SqlCommand> addParammeters
            , Func<SqlDataReader, T> criarObjecto)
        {
            return obterListaInterno<T>(query, addParammeters, criarObjecto);
        }

        public void alterarElemento(string query, Action<SqlCommand> addParammeters)
        {
            using (SqlConnection con = new SqlConnection())
            {
                con.ConnectionString = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    addParammeters(cmd);
                    con.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception e)
                    {
                        MessageBox.Show(e.Message);
                    }

                    con.Close();
                }
            }
        }
    }
}
