using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace ReservationApp.Dispotivos_Acesso.EntityFramework
{
    public partial class EntityFramework
    {
        public override void introduzirCliente(Cliente cliente)
        {
            alterarElemento((dbm) =>
            {
                dbm.Clientes.Add(cliente);
            });
        }

        public override List<Cliente> obterClientes()
        {
            return obterLista<Cliente>((dbm)=> dbm.Clientes.ToList<Cliente>());
        }

        public override void removerCliente(Nullable<int> codigoClienteRemover)
        {
            alterarElemento((dbm) =>
            {
                dbm.Clientes.Remove(dbm.Clientes.First(c => c.Código == codigoClienteRemover));
            });
        }

        public override void alterarCliente(Cliente cliente)
        {
            alterarElemento((dbm) =>
            {
                Cliente clienteAlterar
                        = dbm.Clientes.First(c => c.Código == cliente.Código);
                clienteAlterar.Nome = cliente.Nome;
                clienteAlterar.Morada = cliente.Morada;
                clienteAlterar.NumeroFiscal = cliente.NumeroFiscal;
            });
        }
    }
}
