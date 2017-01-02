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
        public override List<TempoExtra> obterTemposExtra()
        {
            return obterLista<TempoExtra>("SELECT NumeroIdentificadorPromoção, FracçãoExtra, TipoDuração, Inicio, Fim, Descrição FROM(" +
                     "TempoExtra INNER JOIN Promoção ON TempoExtra.NumeroIdentificadorPromoção = Promoção.NumeroIdentificador)",
                (reader) =>
                {
                    return new TempoExtra()
                    {
                        NumeroIdentificadorPromoção = (int)reader[0],
                        FracçãoExtra = (int)reader[1],
                        TipoDuração = reader[2].ToString(),
                        Promoção = new Promoção()
                        {
                            Inicio = (DateTime)reader[3],
                            Fim = (DateTime)reader[4],
                            Descrição = reader[5].ToString()
                        }
                    };
                });
        }

        public override void introduzirTempoExtra(TempoExtra tempoExtra)
        {
            alterarElemento("Inserir_TempoExtra",
                    (cmd) => {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@descrição", SqlDbType.NVarChar));
                        cmd.Parameters.Add(new SqlParameter("@inicio", SqlDbType.DateTime));
                        cmd.Parameters.Add(new SqlParameter("@fim", SqlDbType.DateTime));
                        cmd.Parameters.Add(new SqlParameter("@fracçãoExtra", SqlDbType.Int));
                        cmd.Parameters.Add(new SqlParameter("@tipoDuração", SqlDbType.NVarChar));

                        cmd.Parameters[0].Value = tempoExtra.Promoção.Descrição;
                        cmd.Parameters[1].Value = tempoExtra.Promoção.Inicio;
                        cmd.Parameters[2].Value = tempoExtra.Promoção.Fim;
                        cmd.Parameters[3].Value = tempoExtra.FracçãoExtra;
                        cmd.Parameters[4].Value = tempoExtra.TipoDuração;
                    });
        }

        public override void removerTempoExtra(Nullable<int> numero)
        {
            alterarElemento("DELETE FROM dbo.Promoção WHERE NumeroIdentificador = @numero",
                   (cmd) => {
                       cmd.Parameters.Add("@numero", SqlDbType.Int).Value = numero;
                   });
        }


        public override void alterarTempoExtra(TempoExtra tempoExtra)
        {
            alterarElemento("Alterar_TempoExtra",
                    (cmd) => {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@descrição", SqlDbType.NVarChar));
                        cmd.Parameters.Add(new SqlParameter("@inicio", SqlDbType.DateTime));
                        cmd.Parameters.Add(new SqlParameter("@fim", SqlDbType.DateTime));
                        cmd.Parameters.Add(new SqlParameter("@extra", SqlDbType.Int));
                        cmd.Parameters.Add(new SqlParameter("@tipoDuracao", SqlDbType.NVarChar));
                        cmd.Parameters.Add(new SqlParameter("@numero", SqlDbType.Int));

                        cmd.Parameters[0].Value = tempoExtra.Promoção.Descrição;
                        if (tempoExtra.Promoção.Inicio != default(DateTime))
                            cmd.Parameters[1].Value = tempoExtra.Promoção.Inicio;
                        if (tempoExtra.Promoção.Fim != default(DateTime))
                            cmd.Parameters[2].Value = tempoExtra.Promoção.Fim;
                        cmd.Parameters[3].Value = tempoExtra.FracçãoExtra;

                        cmd.Parameters[4].Value = (string.IsNullOrWhiteSpace(tempoExtra.TipoDuração)) ?
                            "" : tempoExtra.TipoDuração;

                        cmd.Parameters[5].Value = tempoExtra.NumeroIdentificadorPromoção;
                    });
        }
    }
}
