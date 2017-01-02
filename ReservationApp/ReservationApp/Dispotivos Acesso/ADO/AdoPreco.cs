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
        public override List<Preço> obterPrecos()
        {
            return obterLista<Preço>("SELECT CódigoEquipamento, Valor, TipoDuração, Inicio, Fim, NumeroSerie from dbo.Preço",
               (reader) =>
               {
                   return new Preço()
                   {
                       CódigoEquipamento = (int)reader[0],
                       Valor = (decimal)reader[1],
                       TipoDuração = reader[2].ToString(),
                       Inicio = reader.GetDateTime(reader.GetOrdinal("Inicio")),
                       Fim = (DateTime)reader[4],
                       NumeroSerie = (int)reader[5]
                   };
               });
        }

        public override void introduzirPrecos(Preço preco)
        {
            alterarElemento("INSERT INTO dbo.Preço(CódigoEquipamento, Inicio, Fim, TipoDuração, Valor) VALUES(@codigo,@inicio,@fim,@td, @valor)",
                    (cmd) => {
                        cmd.Parameters.Add("@codigo", SqlDbType.Int).Value = preco.CódigoEquipamento;
                        cmd.Parameters.Add("@inicio", SqlDbType.DateTime).Value = preco.Inicio;
                        cmd.Parameters.Add("@fim", SqlDbType.DateTime).Value = preco.Fim;
                        cmd.Parameters.Add("@td", SqlDbType.NVarChar).Value = preco.TipoDuração;
                        cmd.Parameters.Add("@valor", SqlDbType.Decimal).Value = preco.Valor;
                    });
        }

        public override void removerPrecos(int? serie)
        {
            alterarElemento("DELETE FROM dbo.Preço WHERE NumeroSerie = @serie",
                    (cmd) => {
                        cmd.Parameters.Add("@serie", SqlDbType.Int).Value = serie;
                    });
        }

        public override void alterarPrecos(Preço preco)
        {
            alterarElemento("UPDATE dbo.Preço SET CódigoEquipamento = @codigoEquipamento, Inicio = @inicio, " +
                "Fim = @fim, TipoDuração = @tipoDuracao, Valor = @valor WHERE NumeroSerie = @ns",
                    (cmd) => {
                        cmd.Parameters.Add("@codigoEquipamento", SqlDbType.Int).Value = preco.CódigoEquipamento;
                        cmd.Parameters.Add("@inicio", SqlDbType.DateTime).Value = preco.Inicio;
                        cmd.Parameters.Add("@fim", SqlDbType.DateTime).Value = preco.Fim;
                        cmd.Parameters.Add("@tipoDuracao", SqlDbType.NVarChar).Value = preco.TipoDuração;
                        cmd.Parameters.Add("@valor", SqlDbType.Decimal).Value = preco.Valor;
                        cmd.Parameters.Add("@ns", SqlDbType.Int).Value = preco.NumeroSerie;

                        /*string query = cmd.CommandText;

                        foreach (SqlParameter p in cmd.Parameters)
                        {
                            query = query.Replace(p.ParameterName, p.Value.ToString());
                        }

                        MessageBox.Show(query);*/
                    });
        }
    }
}
