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
        public override void introduzirCliente(Cliente cliente)
        {
            alterarElemento("INSERT INTO dbo.Cliente(Nome, NumeroFiscal, Morada) VALUES(@nome,@numeroFiscal,@morada)",
                    (cmd) => {
                        cmd.Parameters.Add("@nome", SqlDbType.NVarChar).Value = (cliente.Nome == null) ? (object)DBNull.Value : cliente.Nome;
                        cmd.Parameters.Add("@numeroFiscal", SqlDbType.Int).Value = (cliente.NumeroFiscal == null) ? (object)DBNull.Value : cliente.NumeroFiscal;
                        cmd.Parameters.Add("@morada", SqlDbType.NVarChar).Value = (cliente.Morada == null) ? (object)DBNull.Value : cliente.Morada;
                    });
        }

        public override List<Cliente> obterClientes()
        {
            return obterLista<Cliente>("SELECT Código, Nome, NumeroFiscal, Morada  from dbo.Cliente",
                (reader) =>
                {
                    return new Cliente()
                    {
                        Código = (int)reader[0],
                        Nome = reader[1].ToString(),
                        NumeroFiscal =(reader.IsDBNull(2)) ? null : 
                            (Nullable<int>)reader[2],
                        Morada = reader[3].ToString()
                    };
                });
        }

        public override void removerCliente(Nullable<int> codigoClienteRemover)
        {
            alterarElemento("DELETE FROM dbo.Cliente WHERE Código = @codigo",
                    (cmd) => {
                        cmd.Parameters.Add("@codigo", SqlDbType.Int).Value = codigoClienteRemover;
            });
        }

        public override void alterarCliente(Cliente cliente)
        {
            alterarElemento("UPDATE dbo.Cliente  SET Nome = @nome, NumeroFiscal = @nf, Morada = @morada WHERE Código = @codigo",
                    (cmd) => {
                        cmd.Parameters.Add("@nome", SqlDbType.NVarChar).Value = (cliente.Nome == null) ? (object)DBNull.Value : cliente.Nome;
                        cmd.Parameters.Add("@nf", SqlDbType.Int).Value = (cliente.NumeroFiscal == null) ? (object)DBNull.Value : cliente.NumeroFiscal;
                        cmd.Parameters.Add("@morada", SqlDbType.NVarChar).Value = (cliente.Morada == null) ? (object)DBNull.Value : cliente.Morada;
                        cmd.Parameters.Add("@codigo", SqlDbType.NVarChar).Value = cliente.Código;
                    });
        }
    }
}
