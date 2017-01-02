using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReservationApp.Dispotivos_Acesso
{
    public abstract class Dispositivo
    {
        public abstract void introduzirCliente(Cliente cliente);
        public abstract List<Cliente> obterClientes();
        public abstract void removerCliente(Nullable<int> cliente);
        public abstract void alterarCliente(Cliente cliente);

        public abstract void introduzirTipo(Tipo tipo);
        public abstract List<Tipo> obterTipos();
        public abstract void alterarTipo(Tipo tipo);

        public abstract List<Equipamento> obterEquipamentos();
        public abstract void introduzirEquipamento(Equipamento equipamento);
        public abstract void removerEquipamento(Nullable<int> equipamento);
        public abstract void alterarEquipamento(Equipamento equipamento);
        public abstract List<Preço> obterPrecosEquipamento(Nullable<int> equipamento);

        public abstract List<Preço> obterPrecos();
        public abstract void introduzirPrecos(Preço preco);
        public abstract void removerPrecos(Nullable<int> serie);
        public abstract void alterarPrecos(Preço preco);

        public abstract List<Empregado> obterEmpregados();
        public abstract void introduzirEmpregado(Empregado empregado);
        public abstract void removerEmpregado(Nullable<int> codigo);
        public abstract void alterarEmpregado(Empregado empregado);

        public abstract List<Desconto> obterDescontos();
        public abstract void introduzirDesconto(Desconto desconto);
        public abstract void removerDesconto(Nullable<int> numero);
        public abstract void alterarDesconto(Desconto desconto);
        public abstract void juntarTipoADesconto(Nullable<int> numero, string nomeTipo);
        public abstract List<Tipo> obterTiposDeDesconto(Nullable<int> numero);

        public abstract List<TempoExtra> obterTemposExtra();
        public abstract void introduzirTempoExtra(TempoExtra tempoExtra);
        public abstract void removerTempoExtra(Nullable<int> numero);
        public abstract void alterarTempoExtra(TempoExtra tempoExtra);

        public abstract List<Aluguer> obterAluguer();
        public abstract void introduzirAluguer(Aluguer aluguer);
        public abstract void removerAluguer(Nullable<int> numero);
        public abstract void alterarAluguer(Aluguer aluguer);
        public abstract List<Equipamento> obterEquipamentosDeAluguer(Nullable<int> numero);
        public abstract void adicionaEquipamentoAluguer(Nullable<int> numero, Nullable<int> codigo);

        public abstract List<Equipamento> obterEquipamentosDisponiveisParaAlguer(Nullable<int> numero);


        public abstract void introduzirClinterAluguer(Aluguer aluguer);

        public abstract List<Equipamento> obterEquipamentoDisponiviesEntreDatas(DataNTipo dnt);
        public abstract List<Equipamento> obterEquipamentoDisponiviesUltimaSemana();

        public abstract List<Aluguer> obterAlugueresEntreDatas(DataNTipo dnt);
    }
}
