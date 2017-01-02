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
    public partial class Alugueres : VerificarForm
    {
        List<Aluguer> listaAlugueres;

        public Alugueres(List<Aluguer>alugueres)
        {
            listaAlugueres = alugueres;
            InitializeComponent();
            addToComponent();
        }

    }
}
