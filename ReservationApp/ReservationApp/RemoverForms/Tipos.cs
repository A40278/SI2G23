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
    public partial class Tipos : RemoverForm
    {
        List<Tipo> listaTipos;
        public string nomeTipo;

        public Tipos(List<Tipo> tipos)
        {
            this.listaTipos = tipos;
            nomeTipo = null;
            InitializeComponent();
            addToComponent();
        }

        private void button1_Click1(object sender, EventArgs e)
        {
            nomeTipo =(string.IsNullOrWhiteSpace(this.TextBox.Text))? null:
                this.TextBox.Text;
            //nomeTipo
            this.Dispose();
        }
    }
}
