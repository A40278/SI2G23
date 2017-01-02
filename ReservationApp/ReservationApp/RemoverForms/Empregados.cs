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
    public partial class Empregados : RemoverForm
    {
        List<Empregado> listaEmpregados;

        public Empregados(List<Empregado> empregados)
        {
            this.listaEmpregados = empregados;
            numero = null;
            InitializeComponent();
            addToComponent();
        }
    }
}
