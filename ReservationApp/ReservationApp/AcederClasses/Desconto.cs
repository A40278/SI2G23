using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReservationApp.AcederClasses
{
    public partial class AcederClasse
    {
        public List<Action<Dispotivos_Acesso.Dispositivo>> descontoActions =
            new List<Action<Dispotivos_Acesso.Dispositivo>>();

        public void fillClienteDesconto()
        {
            descontoActions.Add((dispositivo) =>
                IntroduzirT<Desconto>(
                    new IntroduzirForms.Descontos(dispositivo.obterTipos())
                    , dispositivo.introduzirDesconto
                )
            );

            descontoActions.Add((dispositivo) =>
                VerificarT(
                    new VerificarForms.Descontos(dispositivo.obterDescontos())
                )
            );

            descontoActions.Add((dispositivo) =>
                AlterarT<Desconto>(
                    new AlterarForms.Descontos(dispositivo.obterDescontos())
                    , dispositivo.alterarDesconto
                )
            );
                
            descontoActions.Add((dispositivo) =>
                RemoverT(
                    new RemoverForms.Descontos(dispositivo.obterDescontos())
                    , dispositivo.removerDesconto
                )
            );

            descontoActions.Add((dispositivo) =>
                VerificarDentro(
                    new RemoverForms.Descontos(dispositivo.obterDescontos()),
                    (n) =>
                    {
                        return new VerificarForms.Tipos(dispositivo.obterTiposDeDesconto(n));
                    }
                )
            );

            descontoActions.Add((dispositivo) =>
            {
                Nullable<int> numero = NumeroT(new RemoverForms.Descontos(dispositivo.obterDescontos()));
                if (numero != null)
                {
                    RemoverForms.Tipos vft = new RemoverForms.Tipos(dispositivo.obterTipos());
                    vft.ShowDialog(this.MainForm);
                    string nomeTipo = vft.nomeTipo;
                    if (nomeTipo != null)
                    {
                        dispositivo.juntarTipoADesconto((int)numero, nomeTipo);
                    }
                }
            });
        }
    }
}
