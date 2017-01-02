using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.AcederClasses
{
    public partial class AcederClasse
    {
        public List<Action<Dispotivos_Acesso.Dispositivo>> clienteActions =
            new List<Action<Dispotivos_Acesso.Dispositivo>>();

        public void fillClienteActions()
        {
            clienteActions.Add((dispositivo) =>
                IntroduzirT<Cliente>(
                    new IntroduzirForms.Clientes()
                    , dispositivo.introduzirCliente
                )
            );

            clienteActions.Add((dispositivo) =>
               VerificarT(
                   new VerificarForms.Clientes(dispositivo.obterClientes())
               )
            );

            clienteActions.Add((dispositivo) =>
                AlterarT<Cliente>(
                    new AlterarForms.Clientes(dispositivo.obterClientes())
                    , dispositivo.alterarCliente
                )
            );

            clienteActions.Add((dispositivo) =>
                RemoverT(
                    new RemoverForms.Clientes(dispositivo.obterClientes())
                    , dispositivo.removerCliente
                )
            );

            
        }
    }
}
