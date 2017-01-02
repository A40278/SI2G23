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
    public partial class Descontos : RemoverForm
    {
        List<Desconto> listaDescontos;

        public Descontos(List<Desconto> descontos)
        {
            this.listaDescontos = descontos;
            numero = null;
            InitializeComponent();
            addToComponent();
        }
    }
}
