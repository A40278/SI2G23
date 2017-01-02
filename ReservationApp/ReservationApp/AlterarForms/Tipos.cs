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
    public partial class Tipos : AlterarForm<Tipo>
    {
        List<Tipo> listaTipos;

        public Tipos(List<Tipo>tipos)
        {
            item = null;
            listaTipos = tipos;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(this.NomeTextBox.Text))
            {
                item = listaTipos.First(t => t.Nome.Equals(this.NomeTextBox.Text));
                item.Descrição = this.DescricaoTextBox.Text;
            }
            this.Dispose();
        }
    }
}
