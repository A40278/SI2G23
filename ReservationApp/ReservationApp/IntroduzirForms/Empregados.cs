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
    public partial class Empregados : IntroduzirForm<Empregado>
    {

        public Empregados()
        {
            item = null;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string n = this.NomeTextoBox.Text;
            item = (string.IsNullOrWhiteSpace(n)) ? null :
                new Empregado() { Nome = n };
            this.Dispose();
        }
    }
}
