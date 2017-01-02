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
        public override List<Empregado> obterEmpregados()
        {
            return obterLista<Empregado>((dbm) => dbm.Empregadoes.ToList<Empregado>());
        }

        public override void introduzirEmpregado(Empregado empregado)
        {
            alterarElemento((dbm) =>
            {
                dbm.Empregadoes.Add(empregado);
            });
        }

        public override void removerEmpregado(Nullable<int> numero)
        {
            alterarElemento((dbm) =>
            {
                dbm.Empregadoes.Remove(dbm.Empregadoes.First(e => e.Numero == numero));
            });
        }

        public override void alterarEmpregado(Empregado empregado)
        {
            alterarElemento((dbm) =>
            {
                Empregado empregadoAlterar = dbm.Empregadoes.First(e => e.Numero == empregado.Numero);
                empregadoAlterar.Nome = empregado.Nome;
            });
        }
    }
}
