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
        public override List<Desconto> obterDescontos()
        {
            return obterLista<Desconto>((dbm) => dbm.Descontoes.Include("Promoção").ToList<Desconto>());
        }

        public override void introduzirDesconto(Desconto desconto)
        {
            alterarElemento((dbm) =>
            {
                dbm.Descontoes.Add(desconto);
            });
        }

        public override void removerDesconto(Nullable<int> numero)
        {
            alterarElemento((dbm) =>
            {
                Desconto desconto = dbm.Descontoes.Include("Promoção").First(d => d.NumeroIdentificadorPromoção == numero);
                dbm.Promoção.Remove(desconto.Promoção);
                dbm.Descontoes.Remove(desconto);
            });
        }

        public override void alterarDesconto(Desconto desconto)
        {
            alterarElemento((dbm) =>
            {
                Desconto descontoOriginal = dbm.Descontoes.First(d =>
                d.NumeroIdentificadorPromoção == desconto.NumeroIdentificadorPromoção);

                descontoOriginal.Valor = desconto.Valor;

                descontoOriginal.Promoção.Inicio = desconto.Promoção.Inicio;

                descontoOriginal.Promoção.Fim = desconto.Promoção.Fim;

                descontoOriginal.Promoção.Descrição = desconto.Promoção.Descrição;
            });
        }

        public override void juntarTipoADesconto(Nullable<int> numero, string nomeTipo)
        {
            alterarElemento((dbm) =>
            {
                Desconto desconto = dbm.Descontoes.First(d => d.NumeroIdentificadorPromoção == numero);
                desconto.Tipoes.Add(dbm.Tipoes.First(t => t.Nome == nomeTipo));
            });
        }

        public override List<Tipo> obterTiposDeDesconto(Nullable<int> numero)
        {
            return obterLista<Tipo>((dbm) => dbm.Descontoes.First(d => d.NumeroIdentificadorPromoção == numero).Tipoes.ToList<Tipo>());
        }
    }
}
