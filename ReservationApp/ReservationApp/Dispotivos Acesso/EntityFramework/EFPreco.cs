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
        public override List<Preço> obterPrecos()
        {
            return obterLista<Preço>((dbm) => dbm.Preço.ToList<Preço>());
        }

        public override void introduzirPrecos(Preço preco)
        {
            alterarElemento((dbm) =>
            {
                Equipamento equipamento = dbm.Equipamentoes.First(e => e.Código == preco.CódigoEquipamento);
                preco.Equipamento = equipamento;
                equipamento.Preço.Add(preco);
            });
        }

        public override void removerPrecos(int? serie)
        {
            alterarElemento((dbm) =>
            {
                Preço preco = dbm.Preço.Include("Equipamento").First(p => p.NumeroSerie==serie);
                /*Equipamento equipamento = preco.Equipamento;
                equipamento.Preço.Remove(preco);
                */
                dbm.Preço.Remove(preco);
            });
        }

        public override void alterarPrecos(Preço preco)
        {
            alterarElemento((dbm) =>
            {
                Preço precoOriginal = dbm.Preço.First(p => p.NumeroSerie == preco.NumeroSerie);
                precoOriginal.Fim =  preco.Fim;
                precoOriginal.Valor =  preco.Valor;
                precoOriginal.CódigoEquipamento = preco.CódigoEquipamento;
                precoOriginal.Inicio = preco.Inicio;
                precoOriginal.TipoDuração = preco.TipoDuração;
            });
        }
    }
}
