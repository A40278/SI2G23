using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.IntroduzirForms
{
    public partial class Alugueres : IntroduzirForm<Aluguer>
    {
        List<Cliente> listaClientes;

        public Alugueres(List<Cliente> clientes)
        {
            item = null;
            this.listaClientes = clientes;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string cl = this.ClienteTextBox.Text;
            string em = this.EmpregadoTextBox.Text;

            try
            {
                item = (string.IsNullOrWhiteSpace(cl) || string.IsNullOrWhiteSpace(em))
                    ? null : 
                    new Aluguer()
                    {
                        CódigoCliente = Int32.Parse(cl),
                        NumeroEmpregado = Int32.Parse(em),
                        Inicio = this.formDate(this.InicioAnoTextBox.Text, this.InicioMesTextBox.Text
                            , this.InicioDiaTextBox.Text, this.InicioHoraTextBox.Text, this.InicioMinutoTextBox.Text),
                        Fim = this.formDate(this.FimAnoTextBox.Text, this.FimMesTextBox.Text
                            , this.FimDiaTextBox.Text, this.FimHoraTextBox.Text, this.FimMinutoTextBox.Text),
                        TipoDuração = this.PeriodoTextBox.Text
                    };
            }catch(Exception exe)
            {
                MessageBox.Show(exe.Message);
            }

            this.Dispose();
        }

    }
}
