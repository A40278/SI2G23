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
    public partial class TemposExtras : AlterarForm<TempoExtra>
    {
        List<TempoExtra> listaTemposExtra;

        public TemposExtras(List<TempoExtra>temposExtras)
        {
            listaTemposExtra = temposExtras;
            item = null;
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
                if (!string.IsNullOrWhiteSpace(this.CodgioTextBox.Text))
                {
                    item = listaTemposExtra.First(te => te.NumeroIdentificadorPromoção == Int32.Parse(this.CodgioTextBox.Text));

                    item.FracçãoExtra = (string.IsNullOrWhiteSpace(this.FraçõesExtrasTextBox.Text)) ?
                        item.FracçãoExtra : Int32.Parse(this.FraçõesExtrasTextBox.Text);

                    item.TipoDuração = (string.IsNullOrWhiteSpace(this.TipoDuracaoTextBox.Text)) ?
                        item.TipoDuração : this.TipoDuracaoTextBox.Text;

                    item.Promoção.Inicio = (checkInicio) ?
                        item.Promoção.Inicio :
                        this.formDate(this.InicioAnoTextBox.Text, this.InicioMesTextBox.Text
                        , this.InicioDiaTextBox.Text, this.InicioHoraTextBox.Text, this.InicioMinutoTextBox.Text);

                    item.Promoção.Fim = (checkFim) ?
                        item.Promoção.Fim :
                        this.formDate(this.FimAnoTextBox.Text, this.FimMesTextBox.Text
                        , this.FimDiaTextBox.Text, this.FimHoraTextBox.Text, this.FimMinutoTextBox.Text);

                    item.Promoção.Descrição = (string.IsNullOrWhiteSpace(this.DescricaoTextBox.Text)) ?
                        item.Promoção.Descrição : this.DescricaoTextBox.Text;
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
