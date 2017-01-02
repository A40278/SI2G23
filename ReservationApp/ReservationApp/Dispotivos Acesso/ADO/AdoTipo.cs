using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.Dispotivos_Acesso.ADO
{
    public partial class Ado
    {
        public override void introduzirTipo(Tipo tipo)
        {
            alterarElemento("INSERT INTO dbo.Tipo(Nome, Descrição) VALUES(@nome,@descricao)",
                    (cmd) => {
                        cmd.Parameters.Add("@nome", SqlDbType.NVarChar).Value = tipo.Nome;
                        cmd.Parameters.Add("@descricao", SqlDbType.NVarChar).Value = (tipo.Descrição == null) ? (object)DBNull.Value : tipo.Descrição;

                    });
        }

        public override List<Tipo> obterTipos()
        {
            return obterLista<Tipo>("SELECT Nome, Descrição from dbo.Tipo",
               (reader) =>
               {
                   return new Tipo()
                   {
                       Nome = reader[0].ToString(),
                       Descrição = reader[1].ToString()
                   };
               });
        }

        public override void alterarTipo(Tipo tipo)
        {
            alterarElemento("UPDATE dbo.Tipo  SET Descrição = @descrição WHERE Nome = @nome",
                    (cmd) => {
                        cmd.Parameters.Add("@descrição", SqlDbType.NVarChar).Value = (tipo.Descrição == null) ? (object)DBNull.Value : tipo.Descrição;
                        cmd.Parameters.Add("@nome", SqlDbType.NVarChar).Value = tipo.Nome;
                    });
        }
    }
}
