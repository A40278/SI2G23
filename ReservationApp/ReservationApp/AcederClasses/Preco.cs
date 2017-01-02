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
        public List<Action<Dispotivos_Acesso.Dispositivo>> precoActions = 
            new List<Action<Dispotivos_Acesso.Dispositivo>>();

        public void fillPrecoActions()
        {
            precoActions.Add((dispositivo)=>
                IntroduzirT<Preço>(
                    new IntroduzirForms.Precos(dispositivo.obterEquipamentos())
                   , dispositivo.introduzirPrecos
                )
            );

            precoActions.Add((dispositivo) =>
                VerificarT(
                    new VerificarForms.Preços(dispositivo.obterPrecos())
                )
            );

            precoActions.Add((dispositivo) =>
                AlterarT<Preço>(
                    new AlterarForms.Precos(dispositivo.obterPrecos())
                    , dispositivo.alterarPrecos
                )
            );

            precoActions.Add((dispositivo) =>
                RemoverT(
                    new RemoverForms.Precos(dispositivo.obterPrecos()),
                    dispositivo.removerPrecos
                )
            );
        } 
    }
}
