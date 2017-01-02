using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.VerificarForms
{
    public partial class Clientes : VerificarForm
    {
        List<Cliente> listaClientes;

        public Clientes(List<Cliente> clientes)
        {
            this.listaClientes = clientes;
            InitializeComponent();
            addToComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }
    }
}
