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
    public partial class Precos : AlterarForm<Preço>
    {
        List<Preço> listaPrecos;

        public Precos(List<Preço> precos)
        {
            item = null;
            this.listaPrecos = precos;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            bool checkFim = this.checkDate(this.FimAnoTextBox.Text, this.FimMesTextBox.Text,
                this.FimDiaTextBox.Text, this.FimHoraTextBox.Text, this.FimMinutoTextBox.Text);
            bool checkInicio = this.checkDate(this.InicioAnoTextBox.Text, this.InicioMesTextBox.Text,
                this.InicioDiaTextBox.Text, this.InicioHoraTextBox.Text, this.InicioMinutoTextBox.Text);

            try
            {
                if (!(string.IsNullOrWhiteSpace(this.NumeroSerieTextBox.Text)))
                {
                    item = listaPrecos.First(p => p.NumeroSerie == Int32.Parse(this.NumeroSerieTextBox.Text));

                    item.TipoDuração = (string.IsNullOrWhiteSpace(this.TipoDTextBox.Text)) ?
                        item.TipoDuração : this.TipoDTextBox.Text;

                    item.Valor = (string.IsNullOrWhiteSpace(this.ValorTextBox.Text)) ? 
                        item.Valor : Convert.ToDecimal(this.ValorTextBox.Text);


                    item.Inicio = (checkInicio) ? item.Inicio :
                               this.formDate(this.InicioAnoTextBox.Text, this.InicioMesTextBox.Text
                               , this.InicioDiaTextBox.Text, this.InicioHoraTextBox.Text, this.InicioMinutoTextBox.Text);

                    item.Fim = (checkFim) ? item.Fim :
                                this.formDate(this.FimAnoTextBox.Text, this.FimMesTextBox.Text
                                , this.FimDiaTextBox.Text, this.FimHoraTextBox.Text, this.FimMinutoTextBox.Text);
                }
            }
            catch (Exception ex)
            {
                item = null;
                MessageBox.Show(ex.Message);
            }
            this.Dispose();
        }
    }
}
