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
    public partial class Clientes : AlterarForm<Cliente>
    {
        public List<Cliente> listaClientes;

        public Clientes(List<Cliente>clientes)
        {
            this.listaClientes = clientes;
            item = null;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(this.CódigoTextBox.Text))
                {
                    item = listaClientes.First(c => c.Código == Int32.Parse(this.CódigoTextBox.Text));

                    item.Nome = (string.IsNullOrWhiteSpace(this.NomeTextBox.Text)) ? 
                        item.Nome : this.NomeTextBox.Text;

                    item.Morada = (string.IsNullOrWhiteSpace(this.MoradaTextBox.Text)) ? 
                        item.Morada : this.MoradaTextBox.Text;

                    item.NumeroFiscal = (string.IsNullOrWhiteSpace(this.NumeroFiscalTextBox.Text)) ?
                        item.NumeroFiscal : (Nullable<int>)Int32.Parse(this.NumeroFiscalTextBox.Text);
                }
            }catch(FormatException exce)
            {
                item = null;
                MessageBox.Show(exce.Message);
            }
            this.Dispose();
        }
    }
}
