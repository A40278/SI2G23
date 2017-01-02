using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace ReservationApp.Dispotivos_Acesso.EntityFramework
{
    public partial class EntityFramework : Dispositivo
    {
        public override List<Aluguer> obterAluguer()
        {
            return obterLista<Aluguer>((dbm) => dbm.Aluguers.ToList<Aluguer>());
        }

        public override void introduzirAluguer(Aluguer aluguer)
        {
            alterarElemento((dbm) =>
            {
                dbm.Aluguers.Add(aluguer);
            });
        }

        public override void removerAluguer(Nullable<int> numero)
        {
            alterarElemento((dbm) =>
            {
                dbm.Aluguers.Remove(dbm.Aluguers.First(c => c.NumeroSerie == numero));
            });
        }

        public override void alterarAluguer(Aluguer aluguer)
        {
            alterarElemento((dbm) =>
            {
                Aluguer aluguerAlterar
                        = dbm.Aluguers.First(a => a.NumeroSerie == aluguer.NumeroSerie);

                aluguerAlterar.CódigoCliente = aluguer.CódigoCliente;

                aluguerAlterar.NumeroEmpregado = aluguer.NumeroEmpregado;

                aluguerAlterar.Inicio = aluguer.Inicio;

                aluguerAlterar.Fim = aluguer.Fim;

                aluguerAlterar.TipoDuração = aluguer.TipoDuração;
            });
        }

        public override List<Equipamento> obterEquipamentosDeAluguer(Nullable<int> numero)
        {
            return obterLista<Equipamento>((dbm) => dbm.Aluguers.First(a => a.NumeroSerie == numero)
                    .EquipamentoAlugadoes.Select(ea => ea.Equipamento).ToList<Equipamento>());
        }

        public override void adicionaEquipamentoAluguer(Nullable<int> numero, Nullable<int> codigo)
        {
            alterarElemento((dbm) =>
            {
                Aluguer aluguer = dbm.Aluguers.First(a => a.NumeroSerie == numero);
                aluguer.EquipamentoAlugadoes.Add(
                    new EquipamentoAlugado()
                    {
                        Aluguer = aluguer,
                        Equipamento = (dbm.Equipamentoes.First(e => e.Código == codigo))
                    }
                 );
            });
        }

        public override List<Equipamento> obterEquipamentosDisponiveisParaAlguer(Nullable<int> numero)
        {
            return obterLista<Equipamento>((dbm)=>
            {
                return dbm.Listar_Equipamentos_Disponiveis_Aluguer1(numero).ToList<Equipamento>();
            });
        }

        public override void introduzirClinterAluguer(Aluguer aluguer)
        {
            alterarElemento((dbm) =>
            {
                dbm.Clientes.Add(aluguer.Cliente);
                dbm.Aluguers.Add(aluguer);
            });
        }

        public override List<Aluguer> obterAlugueresEntreDatas(DataNTipo dnt)
        {
            DateTime begin = dnt.Inicio;
            DateTime end = dnt.Fim;
            return obterLista<Aluguer>((dbm)=>
            {
                return dbm.Aluguers.Include("EquipamentoAlugadoes").Where(a => (a.Inicio >= begin && a.Inicio <= end)
                   || (a.Fim >= begin && a.Fim <= end)).ToList<Aluguer>();
            });
        }
    }
}
