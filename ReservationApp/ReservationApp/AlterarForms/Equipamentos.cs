using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.AlterarForms
{
    public partial class Equipamentos : AlterarForm<Equipamento>
    {
        List<Equipamento> listaEquipamentos;

        public Equipamentos(List<Equipamento> equipamentos)
        {
            item = null;
            listaEquipamentos = equipamentos;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(this.CodigoTextBox.Text))
                {
                    item = listaEquipamentos.First(eq => eq.Código == Int32.Parse(this.CodigoTextBox.Text));
                    item.Descrição = ((string.IsNullOrWhiteSpace(this.DescricaoTextBox.Text))) ?
                        item.Descrição : this.DescricaoTextBox.Text;
                }
            }
            catch(FormatException fe)
            {
                item = null;
                MessageBox.Show(fe.Message);
            }
            
            this.Dispose();
        }
    }
}
