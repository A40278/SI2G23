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
    public partial class Clientes : IntroduzirForm<Cliente>
    {

        public Clientes()
        {
            item = null;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string n = this.NomeTextBox.Text;
            string m = this.MoradaTextBox.Text;
            string nf = this.NumeroFiscalTextBox.Text;
            try
            {
                this.item = new Cliente()
                {
                    Nome = (string.IsNullOrWhiteSpace(n)) ? null : n,
                    Morada = (string.IsNullOrWhiteSpace(m)) ? null : m,
                    NumeroFiscal = (string.IsNullOrWhiteSpace(nf)) ? (int?)null :
                            (Nullable<int>)Int32.Parse(nf)
                };
            }catch(FormatException)
            {
                MessageBox.Show("Numero Fiscal têm de ser um numero");
            }
            this.Dispose();
        }
    }
}
