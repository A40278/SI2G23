using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp
{
    public partial class MainForm : Form
    {
        List<Action> actions = new List<Action>();
        Dispotivos_Acesso.ADO.Ado ado;
        Dispotivos_Acesso.EntityFramework.EntityFramework ef;
        Dispotivos_Acesso.Dispositivo dispositivo;
        XMLFileWriter xmlw = new XMLFileWriter();
        AcederClasses.AcederClasse ac;

        public void fillActions()
        {
            actions.Add(AcederTipo);
            actions.Add(AcederEquipamento);
            actions.Add(AcederPreço);
            actions.Add(AcederCliente);
            actions.Add(AcederEmpregado);
            actions.Add(AcederAluguer);
            actions.Add(AcederDesconto);
            actions.Add(AcederTempoExtra);
            actions.Add(AluguerCliente);
            actions.Add(EquipamentoDisponivelDatas);
            actions.Add(EquipamentoDisponivelUltimaSemana);
            actions.Add(CriarXml);
        }

        public void AcederT<T>(AcederForms.AcederForm acederForm,
            List<Action<Dispotivos_Acesso.Dispositivo>> listAction)
        {
            acederForm.ShowDialog(this);
            Nullable<int> choice = acederForm.choice;
            if (choice != null)
            {
                listAction[(int)choice].Invoke(dispositivo);
            }
        }

      
        public MainForm()
        {
            ef = new Dispotivos_Acesso.EntityFramework.EntityFramework();
            ado = new Dispotivos_Acesso.ADO.Ado();
            fillActions();
            InitializeComponent();
            ac = new AcederClasses.AcederClasse(this);
        }

        public void AcederTipo()
        {
            AcederT<Tipo>(
                new AcederForms.Tipos()
                , ac.tipoActions
            );
        }

        public void AcederEquipamento()
        {
            AcederT<Equipamento>(
                new AcederForms.Equipamentos()
                , ac.equipamentoActions
            );
        }

        public void AcederPreço()
        {
            AcederT<Preço>(
                new AcederForms.Precos()
                , ac.precoActions
            );
        }

        public void AcederCliente()
        {
            AcederT<Cliente>(
                new AcederForms.Clientes()
                , ac.clienteActions
            );
        }

        public void AcederEmpregado()
        {
            AcederT<Empregado>(
                new AcederForms.Empregados()
                , ac.empregadosActions
            );
        }

        public void AcederAluguer()
        {
            AcederT<Aluguer>(
                new AcederForms.Alugueres()
                , ac.aluguerActions
            );
        }

        public void AcederDesconto()
        {
            AcederT<Desconto>(
                new AcederForms.Descontos()
                , ac.descontoActions
            );
        }

        public void AcederTempoExtra()
        {
            AcederT<TempoExtra>(
                new AcederForms.TempoExtras()
                , ac.tempoExtraActions
            );
        }

        public void AluguerCliente()
        {
            ac.AluguerAndCliente(dispositivo);
        }

        public void EquipamentoDisponivelDatas()
        {
            ac.EquipamentoDisponivelDatas(dispositivo);
        }

        public void EquipamentoDisponivelUltimaSemana()
        {
            ac.EquipamentoDisponivelUltimaSemana(dispositivo);
        }


        public void CriarXml()
        {
            ac.CriarXml(dispositivo, xmlw);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int indexChecked = checkedListBox1.CheckedIndices[0];
            if (this.checkBox1.Checked)
            {
                dispositivo = ef;
            }else
            {
                dispositivo = ado;
            }
            this.Visible = false;
            this.actions[indexChecked].Invoke();
            this.Visible = true;
        }

        private void checkedListBox1_ItemCheck(object sender, ItemCheckEventArgs e)
        {
            for (int ix = 0; ix < checkedListBox1.Items.Count; ++ix)
                if (ix != e.Index) checkedListBox1.SetItemChecked(ix, false);
        }
    }
}
