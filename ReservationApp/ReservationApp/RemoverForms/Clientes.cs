using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.RemoverForms
{
    public partial class Clientes : RemoverForm
    {
        public List<Cliente> listaClientes;

        public Clientes(List<Cliente> clientes)
        {
            this.listaClientes = clientes;
            numero = null;
            InitializeComponent();
            addToComponent();
        }
    }
}
