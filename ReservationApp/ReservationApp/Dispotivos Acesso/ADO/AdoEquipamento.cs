using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.Dispotivos_Acesso.ADO
{
    public partial class Ado
    {
        public override List<Equipamento> obterEquipamentos()
        {
            return obterLista<Equipamento>("SELECT Código, NomeTipo, Descrição  from dbo.Equipamento",
                (reader) =>
                {
                    return new Equipamento()
                    {
                        Código = (int)reader[0],
                        NomeTipo = reader[1].ToString(),
                        Descrição = reader[2].ToString(),
                    };
                });
        }

        public override void introduzirEquipamento(Equipamento equipamento)
        {
            alterarElemento("INSERT INTO dbo.Equipamento(Descrição, NomeTipo) VALUES(@descricao,@nt)",
                    (cmd) => {
                        cmd.Parameters.Add("@nt", SqlDbType.NVarChar).Value = equipamento.NomeTipo;
                        cmd.Parameters.Add("@descricao", SqlDbType.NVarChar).Value = (equipamento.Descrição == null) ? (object)DBNull.Value : equipamento.Descrição;
                    });
        }

        public override void removerEquipamento(int? equipamento)
        {
            alterarElemento("DELETE FROM dbo.Equipamento WHERE Código = @codigo",
                    (cmd) => {
                        cmd.Parameters.Add("@codigo", SqlDbType.Int).Value = equipamento;
                    });
        }

        public override void alterarEquipamento(Equipamento equipamento)
        {
            alterarElemento("UPDATE dbo.Equipamento SET Descrição = @descricao WHERE Código = @codigo",
                    (cmd) => {
                        cmd.Parameters.Add("@descricao", SqlDbType.NVarChar).Value = (equipamento.Descrição == null) ? (object)DBNull.Value : equipamento.Descrição;
                        cmd.Parameters.Add("@codigo", SqlDbType.NVarChar).Value = equipamento.Código;
                    });
        }

        public override List<Preço> obterPrecosEquipamento(Nullable<int> equipamento)
        {
            return obterLista<Preço>("SELECT Valor, TipoDuração, Inicio, Fim, NumeroSerie from dbo.Preço WHERE CódigoEquipamento = @ce"
                , (cmd)=>
                {
                    cmd.Parameters.Add("@ce", SqlDbType.Int).Value = equipamento;
                }
                ,(reader) =>
                {
                    return new Preço()
                    {
                        CódigoEquipamento = (int)equipamento,
                        Valor = (decimal)reader[0],
                        TipoDuração = reader[1].ToString(),
                        Inicio = (DateTime)reader[2],
                        Fim = (DateTime)reader[3],
                        NumeroSerie = (int)reader[4]
                    };
                });
        }

        public override List<Equipamento> obterEquipamentoDisponiviesEntreDatas(DataNTipo dnt)
        {
            return obterLista<Equipamento>("Listar_Equipamentos_Disponiveis_Periodo_Tipo"
                , (cmd) =>
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@inicioPeriodo", SqlDbType.DateTime));
                    cmd.Parameters.Add(new SqlParameter("@fimPeriodo", SqlDbType.DateTime));
                    cmd.Parameters.Add(new SqlParameter("@tipo", SqlDbType.NVarChar));

                    cmd.Parameters[0].Value = dnt.Inicio;
                    cmd.Parameters[1].Value = dnt.Fim;
                    cmd.Parameters[2].Value = dnt.NomeTipo;

                }
                , (reader) =>
                {
                    return new Equipamento()
                    {
                        Código = (int)reader[0],
                        NomeTipo = reader[1].ToString(),
                        Descrição = reader[2].ToString()
                    };
                });
        }

        public override List<Equipamento> obterEquipamentoDisponiviesUltimaSemana()
        {
            return obterLista<Equipamento>("Listar_Equipamentos_Disponiveis_Ultima_Semana"
                , (cmd) =>
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                }
                , (reader) =>
                {
                    return new Equipamento()
                    {
                        Código = (int)reader[0],
                        NomeTipo = reader[1].ToString(),
                        Descrição = reader[2].ToString()
                    };
                });
        }
    }
}
