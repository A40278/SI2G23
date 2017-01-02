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
    public partial class Tipos : IntroduzirForm<Tipo>
    {

        public Tipos()
        {
            item = null;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string n = this.NomeTextBox.Text;
            string d = this.DescricaoTextBox.Text;
            item = ((string.IsNullOrWhiteSpace(n))) ? null :
                new Tipo()
                {
                    Nome = n,
                    Descrição = ((string.IsNullOrWhiteSpace(d))) ? null : d
                };
            this.Dispose();
        }
    }
}
