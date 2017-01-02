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
    public partial class TempoExtras : IntroduzirForm<TempoExtra>
    {

        public TempoExtras()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            try
            {
                item = new TempoExtra()
                {
                    FracçãoExtra = Int32.Parse(this.FraçõesExtrasTextBox.Text),
                    TipoDuração = this.TipoDuracaoTextBox.Text,
                    Promoção = new Promoção()
                    {
                        Inicio = formDate(this.InicioAnoTextBox.Text, this.InicioMesTextBox.Text
                                , this.InicioDiaTextBox.Text, this.InicioHoraTextBox.Text, this.InicioMinutoTextBox.Text),
                        Fim = formDate(this.FimAnoTextBox.Text, this.FimMesTextBox.Text
                                , this.FimDiaTextBox.Text, this.FimHoraTextBox.Text, this.FimMinutoTextBox.Text),
                        Descrição = this.DescricaoTextBox.Text
                    },
                };
            }
            catch (Exception)
            {
                MessageBox.Show("Informação errada");
            }
            this.Dispose();
        }
    }
}
