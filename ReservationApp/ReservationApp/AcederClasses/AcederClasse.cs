using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.AcederClasses
{
    public partial class AcederClasse
    {
        Form MainForm;

        public AcederClasse(Form mainForm)
        {
            this.MainForm = mainForm;
            fillAluguerActions();
             fillClienteActions();
            fillTipoActions();
            fillEquipamentoActions();
            fillPrecoActions();
            fillEmpregadoActions();
            fillClienteDesconto();
            fillTempoExtraActions();
        }

        public void IntroduzirT<T>(IntroduzirForms.IntroduzirForm<T> ift,
            Action<T> acaoIntroduzir)
        {
            ift.ShowDialog(this.MainForm);
            T item = ift.item;
            if (item != null)
            {
                acaoIntroduzir(item);
            }
        }

        public void VerificarT(VerificarForms.VerificarForm vf)
        {
            vf.ShowDialog(this.MainForm);
        }

        public void AlterarT<T>(AlterarForms.AlterarForm<T> aft, 
            Action<T> acaoAlterar)
        {
            aft.ShowDialog(this.MainForm);
            T novoT = aft.item;
            if (novoT != null)
            {
                acaoAlterar(novoT);
            }
        }

        public void RemoverT(RemoverForms.RemoverForm rft, Action<Nullable<int>> acaoRemover)
        {
            Nullable<int> numero = NumeroT(rft);
            if (numero != null)
            {
                acaoRemover(numero);
            }
        }

        public void VerificarDentro(RemoverForms.RemoverForm rft, Func<Nullable<int>, VerificarForms.VerificarForm> verifcarForm)
        {
            Nullable<int> numero = NumeroT(rft);
            if (numero != null)
            {
                VerificarT(verifcarForm(numero));
            }
        }

        public Nullable<int> NumeroT(RemoverForms.RemoverForm rft)
        {
            rft.ShowDialog(this.MainForm);
            return rft.numero;
        }

        public void AluguerAndCliente(Dispotivos_Acesso.Dispositivo dispositivo)
        {
            IntroduzirT<Aluguer>(new IntroduzirForms.AlugueresClientes()
                , dispositivo.introduzirClinterAluguer);
        }

        public void EquipamentoDisponivelDatas(Dispotivos_Acesso.Dispositivo dispositivo)
        {
            IntroduzirT<DataNTipo>(new IntroduzirForms.DatasComTipo(),
                (dnt) =>
                {
                    VerificarT(new VerificarForms.Equipamentos(dispositivo.obterEquipamentoDisponiviesEntreDatas(dnt)));
                });
        }

        public void EquipamentoDisponivelUltimaSemana(Dispotivos_Acesso.Dispositivo dispositivo)
        {
            VerificarT(new VerificarForms.Equipamentos(dispositivo.obterEquipamentoDisponiviesUltimaSemana()));
        }


        public void CriarXml(Dispotivos_Acesso.Dispositivo dispositivo, XMLFileWriter xmlw)
        {
            IntroduzirT<DataNTipo>(new IntroduzirForms.DatasSemTipo(),
                (dnt) =>
                {
                    xmlw.WriteFile(dispositivo.obterAlugueresEntreDatas(dnt), dnt.Inicio, dnt.Fim);
                });
        }
    }
}
