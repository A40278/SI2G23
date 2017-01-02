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
    public partial class Alugueres : RemoverForm
    {
        List<Aluguer> listaAlugueres;

        public Alugueres(List<Aluguer>alugueres)
        {
            numero = null;
            listaAlugueres = alugueres;
            InitializeComponent();
            addToComponent();
        }
    }
}
