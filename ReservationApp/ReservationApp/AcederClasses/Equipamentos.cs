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
        public List<Action<Dispotivos_Acesso.Dispositivo>> equipamentoActions =
            new List<Action<Dispotivos_Acesso.Dispositivo>>();

        public void fillEquipamentoActions()
        {
            equipamentoActions.Add((dispositivo) =>
                IntroduzirT<Equipamento>(
                    new IntroduzirForms.Equipamentos(dispositivo.obterTipos())
                    ,dispositivo.introduzirEquipamento
                )
            );

            equipamentoActions.Add((dispositivo) =>
                VerificarT(
                    new VerificarForms.Equipamentos(dispositivo.obterEquipamentos())
                )
            );

            equipamentoActions.Add((dispositivo) =>
                AlterarT<Equipamento>(
                    new AlterarForms.Equipamentos(dispositivo.obterEquipamentos())
                    , dispositivo.alterarEquipamento
                )
            );

            equipamentoActions.Add((dispositivo) =>
                RemoverT(
                    new RemoverForms.Equipamentos(dispositivo.obterEquipamentos()),
                    dispositivo.removerEquipamento
                )
            );

            equipamentoActions.Add((dispositivo) =>
                VerificarDentro(
                    new RemoverForms.Equipamentos(dispositivo.obterEquipamentos()),
                    (n) => new VerificarForms.Preços(dispositivo.obterPrecosEquipamento(n))
                )
            );
        }
    }
}
