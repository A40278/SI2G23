using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Entity.Infrastructure;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
namespace ReservationApp.Dispotivos_Acesso.EntityFramework
{
    public partial class EntityFramework
    {
        public override List<TempoExtra> obterTemposExtra()
        {
            return obterLista<TempoExtra>((dbm) => dbm.TempoExtras.Include("Promoção").ToList<TempoExtra>());
        }


        public override void introduzirTempoExtra(TempoExtra tempoExtra)
        {
            alterarElemento((dbm) =>
            {
                dbm.TempoExtras.Add(tempoExtra);
            });
        }


        public override void removerTempoExtra(Nullable<int> numero)
        {
            alterarElemento((dbm) =>
            {
                Promoção promocao = dbm.Promoção.First(p => p.NumeroIdentificador == numero);
                TempoExtra tempoExtra = dbm.TempoExtras.First(te => te.NumeroIdentificadorPromoção == numero);
                dbm.TempoExtras.Remove(tempoExtra);
                dbm.Promoção.Remove(promocao);
            });
        }


        public override void alterarTempoExtra(TempoExtra tempoExtra)
        {
            alterarElemento((dbm) =>
            {
                TempoExtra tempoExtraOriginal = dbm.TempoExtras.First(te =>
                te.NumeroIdentificadorPromoção == tempoExtra.NumeroIdentificadorPromoção);

                tempoExtraOriginal.FracçãoExtra = tempoExtra.FracçãoExtra;

                tempoExtraOriginal.TipoDuração = tempoExtra.TipoDuração;

                tempoExtraOriginal.Promoção.Inicio = tempoExtra.Promoção.Inicio;

                tempoExtraOriginal.Promoção.Fim = tempoExtra.Promoção.Fim;

                tempoExtraOriginal.Promoção.Descrição = tempoExtra.Promoção.Descrição;
            });
        }
    }
}
