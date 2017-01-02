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
    public partial class TempoExtras : VerificarForm
    {
        List<TempoExtra> listaTemposExtras;

        public TempoExtras(List<TempoExtra> temposExtras)
        {
            listaTemposExtras = temposExtras;
            InitializeComponent();
            addToComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }
    }
}
