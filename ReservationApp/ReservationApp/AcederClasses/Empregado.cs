using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.AcederClasses
{
    public partial class AcederClasse
    {
        public List<Action<Dispotivos_Acesso.Dispositivo>> empregadosActions =
            new List<Action<Dispotivos_Acesso.Dispositivo>>();

        public void fillEmpregadoActions()
        {
            empregadosActions.Add((dispositivo) =>
                IntroduzirT<Empregado>(
                    new IntroduzirForms.Empregados()
                    , dispositivo.introduzirEmpregado
                )
            );

            empregadosActions.Add((dispositivo) =>
                VerificarT(
                    new VerificarForms.Empregados(dispositivo.obterEmpregados())
                )
            );

            empregadosActions.Add((dispositivo) =>
                AlterarT<Empregado>(
                    new AlterarForms.Empregados(dispositivo.obterEmpregados())
                    , dispositivo.alterarEmpregado
                )
            );

            empregadosActions.Add((dispositivo) =>
                RemoverT(
                    new RemoverForms.Empregados(dispositivo.obterEmpregados())
                    ,dispositivo.removerEmpregado
                )
            );
        }
    }
}
