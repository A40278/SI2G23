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
        public override List<Equipamento> obterEquipamentos()
        {
            return obterLista<Equipamento>((dbm) => dbm.Equipamentoes.ToList<Equipamento>());
        }

        public override void introduzirEquipamento(Equipamento equipamento)
        {
            alterarElemento((dbm) =>
            {
                dbm.Equipamentoes.Add(equipamento);
            });
        }

        public override void removerEquipamento(int? codigoEquipamento)
        {
            alterarElemento((dbm) =>
            {
                dbm.Equipamentoes.Remove(dbm.Equipamentoes.First(c => c.Código == codigoEquipamento));
            });
        }

        public override void alterarEquipamento(Equipamento equipamento)
        {
            alterarElemento((dbm) =>
            {
                Equipamento equipamentoAlterar
                        = dbm.Equipamentoes.First(c => c.Código == equipamento.Código);
                equipamentoAlterar.Descrição = equipamento.Descrição;
            });
        }

        public override List<Preço> obterPrecosEquipamento(Nullable<int> equipamento)
        {
            return obterLista<Preço>((dbm) => dbm.Equipamentoes.First(e => e.Código == equipamento).Preço.ToList<Preço>());
        }

        public override List<Equipamento> obterEquipamentoDisponiviesUltimaSemana()
        {
            return obterLista<Equipamento>((dbm) =>
            {
                return dbm.Listar_Equipamentos_Disponiveis_Ultima_Semana1().ToList<Equipamento>();
            });
        }

        public override List<Equipamento> obterEquipamentoDisponiviesEntreDatas(DataNTipo dnt)
        {
            return obterLista<Equipamento>((dbm) =>
            {
                return dbm.Listar_Equipamentos_Disponiveis_Periodo_Tipo1(dnt.Inicio, dnt.Fim, dnt.NomeTipo).ToList<Equipamento>();
            });
        }
    }
}
