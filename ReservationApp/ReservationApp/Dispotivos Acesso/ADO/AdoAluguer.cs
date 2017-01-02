using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;

namespace ReservationApp.Dispotivos_Acesso.ADO
{
    public partial class Ado : Dispositivo
    {
        public override List<Aluguer> obterAluguer()
        {
            return obterLista<Aluguer>("SELECT TipoDuração, Inicio, FimComExtra, CódigoCliente, NumeroEmpregado, NumeroSerie, Preço from dbo.Aluguer",
                (reader) =>
                {
                    return new Aluguer()
                    {
                        TipoDuração = reader[0].ToString(),
                        Inicio = (DateTime)reader[1],
                        Fim = (DateTime)reader[2],
                        CódigoCliente = (int)reader[3],
                        NumeroEmpregado = (int)reader[4],
                        NumeroSerie = (int)reader[5],
                        Preço = (decimal)reader[6]
                    };
                });
        }

        public override void introduzirAluguer(Aluguer aluguer)
        {
            alterarElemento("INSERT INTO dbo.Aluguer(TipoDuração, Inicio, Fim, CódigoCliente, NumeroEmpregado) "
                    + "VALUES (@tipoDuracao,@inicio,@fim,@cliente,@empregado)",
                    (cmd)=> {
                        cmd.Parameters.Add("@tipoDuracao", SqlDbType.NVarChar).Value = aluguer.TipoDuração;
                        cmd.Parameters.Add("@inicio", SqlDbType.DateTime).Value = aluguer.Inicio;
                        cmd.Parameters.Add("@fim", SqlDbType.DateTime).Value = aluguer.Fim;
                        cmd.Parameters.Add("@cliente", SqlDbType.Int).Value = aluguer.CódigoCliente;
                        cmd.Parameters.Add("@empregado", SqlDbType.Int).Value = aluguer.NumeroEmpregado;
                    });
        }

        public override void removerAluguer(Nullable<int> numero)
        {
            alterarElemento("DELETE FROM dbo.Aluguer WHERE NumeroSerie = @ns",
                    (cmd) => {
                        cmd.Parameters.Add("@ns", SqlDbType.Int).Value = numero;
                    });
        }

        public override void alterarAluguer(Aluguer aluguer)
        {

            alterarElemento("UPDATE dbo.Aluguer SET TipoDuração = @tipoDuracao, Inicio = @inicio, "+
                "Fim = @fim, CódigoCliente = @cliente, NumeroEmpregado = @empregado WHERE NumeroSerie = @ns",
                    (cmd) => {
                        cmd.Parameters.Add("@tipoDuracao", SqlDbType.NVarChar).Value = aluguer.TipoDuração;
                        cmd.Parameters.Add("@inicio", SqlDbType.DateTime).Value = aluguer.Inicio;
                        cmd.Parameters.Add("@fim", SqlDbType.DateTime).Value = aluguer.Fim;
                        cmd.Parameters.Add("@cliente", SqlDbType.Int).Value = aluguer.CódigoCliente;
                        cmd.Parameters.Add("@empregado", SqlDbType.Int).Value = aluguer.NumeroEmpregado;
                        cmd.Parameters.Add("@ns", SqlDbType.Int).Value = aluguer.NumeroSerie;
                    });
        }

        public override List<Equipamento> obterEquipamentosDeAluguer(Nullable<int> numero)
        {
            return obterLista<Equipamento>("SELECT Código, NomeTipo, Descrição FROM Equipamento WHERE Código " +
                     "IN (SELECT CódigoEquipamento FROM EquipamentoAlugado WHERE NumeroSerieAluguer = @nsa)"
                     , (cmd) =>
                      {
                          cmd.Parameters.Add("@nsa", SqlDbType.Int).Value = numero;
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

        public override void adicionaEquipamentoAluguer(Nullable<int> numero, Nullable<int> codigo)
        {
            alterarElemento("INSERT INTO EquipamentoAlugado(CódigoEquipamento, "
                    + "NumeroSerieAluguer) VALUES(@ce, @nsa)",
                    (cmd) => {
                        cmd.Parameters.Add("@ce", SqlDbType.Int).Value = codigo;
                        cmd.Parameters.Add("@nsa", SqlDbType.Int).Value = numero;
                    });
        }


        public override List<Equipamento> obterEquipamentosDisponiveisParaAlguer(Nullable<int> numero)
        {
            return obterLista<Equipamento>("Listar_Equipamentos_Disponiveis_Aluguer"
                     , (cmd) =>
                     {
                         cmd.CommandType = CommandType.StoredProcedure;
                         cmd.Parameters.Add(new SqlParameter("@num", SqlDbType.Int));

                         cmd.Parameters[0].Value = numero;
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

        public override void introduzirClinterAluguer(Aluguer aluguer)
        {
            alterarElemento("Inserir_Aluguer_e_Cliente",
                    (cmd) => {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@tipoDuração", SqlDbType.NVarChar));
                        cmd.Parameters.Add(new SqlParameter("@inicio", SqlDbType.DateTime));
                        cmd.Parameters.Add(new SqlParameter("@fim", SqlDbType.DateTime));
                        cmd.Parameters.Add(new SqlParameter("@numeroEmpregado", SqlDbType.Int));
                        cmd.Parameters.Add(new SqlParameter("@nome", SqlDbType.NVarChar));
                        cmd.Parameters.Add(new SqlParameter("@numeroFiscal", SqlDbType.Int));
                        cmd.Parameters.Add(new SqlParameter("@morada", SqlDbType.NVarChar));

                        cmd.Parameters[0].Value = aluguer.TipoDuração;
                        cmd.Parameters[1].Value = aluguer.Inicio;
                        cmd.Parameters[2].Value = aluguer.Fim;
                        cmd.Parameters[3].Value = aluguer.NumeroEmpregado;
                        cmd.Parameters[4].Value = aluguer.Cliente.Nome;
                        cmd.Parameters[5].Value = aluguer.Cliente.NumeroFiscal;
                        cmd.Parameters[6].Value = aluguer.Cliente.Morada;
                    });
        }

        public override List<Aluguer> obterAlugueresEntreDatas(DataNTipo dnt)
        {

            return obterLista<Aluguer>("Obter_Aluguers_Datas"
                     , (cmd) =>
                     {
                         cmd.CommandType = CommandType.StoredProcedure;
                         cmd.Parameters.Add(new SqlParameter("@inicioPeriodo", SqlDbType.DateTime));
                         cmd.Parameters.Add(new SqlParameter("@fimPeriodo", SqlDbType.DateTime));

                         cmd.Parameters[0].Value = dnt.Inicio;
                         cmd.Parameters[1].Value = dnt.Fim;
                     }
                     , (reader) =>
                     {
                         return new Aluguer()
                         {
                             NumeroSerie = (int)reader[0],
                             TipoDuração = reader[1].ToString(),
                             CódigoCliente = (int)reader[2],
                             EquipamentoAlugadoes = {
                                 new EquipamentoAlugado()
                                 {
                                     CódigoEquipamento = (int)reader[3]
                                 }
                             }
                         };
                     });
        }
    }
}
