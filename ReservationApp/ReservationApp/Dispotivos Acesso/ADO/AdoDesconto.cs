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
        public override List<Desconto> obterDescontos()
        {
            return obterLista<Desconto>("SELECT NumeroIdentificadorPromoção, Valor, Inicio, Fim, Descrição FROM(" +
                     "Desconto INNER JOIN Promoção ON Desconto.NumeroIdentificadorPromoção = Promoção.NumeroIdentificador)",
                (reader) =>
                {
                    return new Desconto()
                    {
                        NumeroIdentificadorPromoção = (int)reader[0],
                        Valor = (decimal)reader[1],
                        Promoção = new Promoção()
                        {
                            Inicio = (DateTime)reader[2],
                            Fim = (DateTime)reader[3],
                            Descrição = reader[4].ToString()
                        }
                    };
                });
        }

        public override void introduzirDesconto(Desconto desconto)
        {
            alterarElemento("Inserir_Desconto",
                    (cmd) => {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@descrição", SqlDbType.NVarChar));
                        cmd.Parameters.Add(new SqlParameter("@inicio", SqlDbType.DateTime));
                        cmd.Parameters.Add(new SqlParameter("@fim", SqlDbType.DateTime));
                        cmd.Parameters.Add(new SqlParameter("@valor", SqlDbType.Decimal));
                        
                        cmd.Parameters[0].Value = desconto.Promoção.Descrição;
                        cmd.Parameters[1].Value = desconto.Promoção.Inicio;
                        cmd.Parameters[2].Value = desconto.Promoção.Fim;
                        cmd.Parameters[3].Value = desconto.Valor;
                    });
        }

        public override void removerDesconto(Nullable<int> numero)
        {
            alterarElemento("DELETE FROM dbo.Promoção WHERE NumeroIdentificador = @numero",
                    (cmd) => {
                        cmd.Parameters.Add("@numero", SqlDbType.Int).Value = numero;
                    });
        }

        public override void alterarDesconto(Desconto desconto)
        {
            alterarElemento("Alterar_Desconto",
                    (cmd) => {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@descrição", SqlDbType.NVarChar));
                        cmd.Parameters.Add(new SqlParameter("@inicio", SqlDbType.DateTime));
                        cmd.Parameters.Add(new SqlParameter("@fim", SqlDbType.DateTime));
                        cmd.Parameters.Add(new SqlParameter("@valor", SqlDbType.Decimal));
                        cmd.Parameters.Add(new SqlParameter("@numero", SqlDbType.Int));

                        cmd.Parameters[0].Value = desconto.Promoção.Descrição;
                        if (desconto.Promoção.Inicio != default(DateTime))
                        {
                            cmd.Parameters[1].Value = desconto.Promoção.Inicio;
                        }
                        if (desconto.Promoção.Fim != default(DateTime))
                        {
                            cmd.Parameters[2].Value = desconto.Promoção.Fim;
                        }
                        cmd.Parameters[3].Value = desconto.Valor;
                        cmd.Parameters[4].Value = desconto.NumeroIdentificadorPromoção;
                    });
        }

        public override void juntarTipoADesconto(Nullable<int> numero, string nomeTipo)
        {
            alterarElemento("INSERT INTO Tipo_Desconto(NumeroIdentificadorDesconto,NomeTipo) VALUES (@nid, @nt)",
                    (cmd) => {
                        cmd.Parameters.Add("@nid", SqlDbType.Int).Value = numero;
                        cmd.Parameters.Add("@nt", SqlDbType.NVarChar).Value = nomeTipo;
                    });
        }

        public override List<Tipo> obterTiposDeDesconto(Nullable<int> numero)
        {
            return obterLista<Tipo>("SELECT Nome , Descrição FROM dbo.Tipo " +
                     "WHERE Nome IN (SELECT NomeTipo FROM " +
                     "Tipo_Desconto WHERE NumeroIdentificadorDesconto = @nid)"
                     , (cmd) =>
                     {
                         cmd.Parameters.Add("@nid", SqlDbType.Int).Value = numero;
                     }
                     , (reader) =>
                     {
                         return new Tipo()
                         {
                             Nome = reader[0].ToString(),
                             Descrição = reader[1].ToString()
                         };
                     });
        }
    }
}
