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
        public List<Action<Dispotivos_Acesso.Dispositivo>> tipoActions = 
            new List<Action<Dispotivos_Acesso.Dispositivo>>();

        public void fillTipoActions()
        {
            tipoActions.Add((dispositvo) =>
                IntroduzirT<Tipo>(
                    new IntroduzirForms.Tipos(), 
                    dispositvo.introduzirTipo
                )
            );

            tipoActions.Add((dispositvo) =>
                VerificarT(
                    new VerificarForms.Tipos(dispositvo.obterTipos())
                )
            );

            tipoActions.Add((dispositvo) =>
                AlterarT<Tipo>(
                    new AlterarForms.Tipos(dispositvo.obterTipos())
                    , dispositvo.alterarTipo
                )
            );
        }
    }
}
