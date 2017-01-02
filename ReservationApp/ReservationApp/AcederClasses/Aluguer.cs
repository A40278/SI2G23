using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReservationApp.AcederClasses
{
    public partial class AcederClasse
    {
        public List<Action<Dispotivos_Acesso.Dispositivo>> aluguerActions = 
            new List<Action<Dispotivos_Acesso.Dispositivo>>();

        public void fillAluguerActions()
        {
            aluguerActions.Add(
                (dispositivo)=>
                    IntroduzirT<Aluguer>(
                        new IntroduzirForms.Alugueres(dispositivo.obterClientes())
                        , dispositivo.introduzirAluguer
                    )
            );

            aluguerActions.Add(
                (dispositivo) =>
                    VerificarT(
                        new VerificarForms.Alugueres(dispositivo.obterAluguer())
                    )
            );

            aluguerActions.Add((dispositivo) =>
                    AlterarT<Aluguer>(
                        new AlterarForms.Alugueres(dispositivo.obterAluguer())
                        , dispositivo.alterarAluguer
                    )
            );

            aluguerActions.Add((dispositivo) =>
                    RemoverT(
                        new RemoverForms.Alugueres(dispositivo.obterAluguer())
                        , dispositivo.removerAluguer
                    )
            );

            aluguerActions.Add((dispositivo) =>
                    VerificarDentro(
                        new RemoverForms.Alugueres(dispositivo.obterAluguer()),
                        (n)=>  
                            new VerificarForms.Equipamentos(dispositivo.obterEquipamentosDeAluguer(n))
                    )
            );

            aluguerActions.Add((dispositivo) =>
            {
                Nullable<int> numero = NumeroT(new RemoverForms.Alugueres(dispositivo.obterAluguer()));
                if (numero != null)
                {
                    Nullable<int> codigo = NumeroT(
                        new RemoverForms.Equipamentos(
                        dispositivo.obterEquipamentosDisponiveisParaAlguer(numero))
                    );
                    if (codigo != null)
                    {
                        dispositivo.adicionaEquipamentoAluguer(numero, codigo);
                    }
                }
            });
        }
    }
}
