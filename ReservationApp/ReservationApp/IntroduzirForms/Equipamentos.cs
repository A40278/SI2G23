using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.IntroduzirForms
{
    public partial class Equipamentos : IntroduzirForm<Equipamento>
    {
        List<Tipo> listaTipos;

        public Equipamentos(List<Tipo> tipos)
        {
            listaTipos = tipos;
            item = null;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string nt = this.NomeTipoTextBox.Text;
            string d = this.DescricaoTextBox.Text;
            item = ((string.IsNullOrWhiteSpace(nt))) ? null :
                new Equipamento()
                {
                    NomeTipo = nt,
                    Descrição = ((string.IsNullOrWhiteSpace(d))) ? null : d
                };
            this.Dispose();
        }
    }
}
