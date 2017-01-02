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
        public override void introduzirTipo(Tipo tipo)
        {
            alterarElemento((dbm) =>
            {
                dbm.Tipoes.Add(tipo);
            });
        }

        public override List<Tipo> obterTipos()
        {
            return obterLista<Tipo>((dbm) => dbm.Tipoes.ToList<Tipo>());
        }

        public override void alterarTipo(Tipo tipo)
        {
            alterarElemento((dbm) =>
            {
                Tipo tipoAlterar = dbm.Tipoes.First(t => t.Nome == tipo.Nome);
                tipoAlterar.Descrição = tipo.Descrição;
            });
        }
    }
}
