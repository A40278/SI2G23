using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReservationApp.AcederClasses
{
    public partial class AcederClasse
    {
        public List<Action<Dispotivos_Acesso.Dispositivo>> tempoExtraActions =
            new List<Action<Dispotivos_Acesso.Dispositivo>>();

        public void fillTempoExtraActions()
        {
            tempoExtraActions.Add((dispositivo)=>
                IntroduzirT<TempoExtra>(
                    new IntroduzirForms.TempoExtras()
                    , dispositivo.introduzirTempoExtra
                 )
            );

            tempoExtraActions.Add((dispositivo) =>
                VerificarT(
                    new VerificarForms.TempoExtras(dispositivo.obterTemposExtra())
                )
            );

            tempoExtraActions.Add((dispositivo) =>
                AlterarT<TempoExtra>(
                    new AlterarForms.TemposExtras(dispositivo.obterTemposExtra())
                   , dispositivo.alterarTempoExtra
                )
            );

            tempoExtraActions.Add((dispositivo) =>
                RemoverT(
                    new RemoverForms.TemposExtras(dispositivo.obterTemposExtra())
                    , dispositivo.removerTempoExtra
                )
            );
        }
    }
}
