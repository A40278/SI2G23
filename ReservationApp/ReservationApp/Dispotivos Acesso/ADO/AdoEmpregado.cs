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
        public override List<Empregado> obterEmpregados()
        {
            return obterLista<Empregado>("SELECT Nome, Numero  from dbo.Empregado",
                (reader) =>
                {
                    return new Empregado()
                    {
                        Nome = reader[0].ToString(),
                        Numero = (int)reader[1]
                    };
                });
        }

        public override void introduzirEmpregado(Empregado empregado)
        {
            alterarElemento("INSERT INTO dbo.Empregado(Nome) VALUES(@nome)",
                    (cmd) => {
                        cmd.Parameters.Add("@nome", SqlDbType.NVarChar).Value = (empregado.Nome == null) ? (object)DBNull.Value : empregado.Nome;
                    });
        }

        public override void removerEmpregado(Nullable<int> numero)
        {
            alterarElemento("DELETE FROM dbo.Empregado WHERE Numero = @numero",
                    (cmd) => {
                        cmd.Parameters.Add("@numero", SqlDbType.Int).Value = numero;
                    });
        }

        public override void alterarEmpregado(Empregado empregado)
        {
            alterarElemento("UPDATE dbo.Empregado SET Nome = @nome WHERE Numero = @numero",
                    (cmd) => {
                        cmd.Parameters.Add("@nome", SqlDbType.NVarChar).Value = empregado.Nome;
                        cmd.Parameters.Add("@numero", SqlDbType.Int).Value = empregado.Numero;
                    });
        }
    }
}
