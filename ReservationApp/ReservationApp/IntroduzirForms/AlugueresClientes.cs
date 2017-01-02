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
    public partial class AlugueresClientes : IntroduzirForm<Aluguer>
    {

        public AlugueresClientes()
        {
            item = null;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string em = this.EmpregadoTextBox.Text;

            string n = this.NomeTextBox.Text;
            string m = this.MoradaTextBox.Text;
            string nf = this.NumeroFiscalTextBox.Text;
                
            try
            {
                this.item = (string.IsNullOrWhiteSpace(em))
                    ? null : 
                    new Aluguer()
                    {
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

            if (item == null)
            {
                this.Dispose();
                return;
            }

            try
            {
                this.item.Cliente = new Cliente()
                {
                    Nome = (string.IsNullOrWhiteSpace(n)) ? null : n,
                    Morada = (string.IsNullOrWhiteSpace(m)) ? null : m,
                    NumeroFiscal = (string.IsNullOrWhiteSpace(nf)) ? (int?)null :
                            (Nullable<int>)Int32.Parse(nf)
                };
            }
            catch (FormatException)
            {
                MessageBox.Show("Numero Fiscal têm de ser um numero");
            }

            this.Dispose();
        }

    }
}
