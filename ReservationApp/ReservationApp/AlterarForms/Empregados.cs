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
    public partial class Empregados : AlterarForm<Empregado>
    {
        List<Empregado> listaEmpregados;

        public Empregados(List<Empregado> empregados)
        {
            item = null;
            listaEmpregados = empregados;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(this.NumeroTextBox.Text))
                {
                    item = listaEmpregados.First(em => em.Numero == Int32.Parse(this.NumeroTextBox.Text));

                    item.Nome = (string.IsNullOrWhiteSpace(this.NomeTextBox.Text)) ?
                        item.Nome : this.NomeTextBox.Text;
                }
            }
            catch(Exception ex)
            {
                item = null;
                MessageBox.Show(ex.Message);
            }
            this.Dispose();
        }
    }
}
