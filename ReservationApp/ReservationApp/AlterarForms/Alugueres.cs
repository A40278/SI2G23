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
    public partial class Alugueres : AlterarForm<Aluguer>
    {
        List<Aluguer> listaAlugueres;

        public Alugueres(List<Aluguer>alugueres)
        {
            item = null;
            listaAlugueres = alugueres;
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
                if (!(string.IsNullOrWhiteSpace(this.CodigoTextBox.Text))){
                    item = listaAlugueres.First(a => a.NumeroSerie == Int32.Parse(this.CodigoTextBox.Text));

                    item.Fim = (checkFim)? item.Fim : 
                                this.formDate(this.FimAnoTextBox.Text, this.FimMesTextBox.Text
                                , this.FimDiaTextBox.Text, this.FimHoraTextBox.Text,
                                this.FimMinutoTextBox.Text);

                    item.Inicio = (checkInicio) ? item.Inicio :
                               this.formDate(this.InicioAnoTextBox.Text, this.InicioMesTextBox.Text
                               , this.InicioDiaTextBox.Text, this.InicioHoraTextBox.Text,
                               this.InicioMinutoTextBox.Text);

                    item.TipoDuração = (string.IsNullOrWhiteSpace(this.PeriodoTextBox.Text)) ?
                        item.TipoDuração : this.PeriodoTextBox.Text;

                    item.NumeroEmpregado = (string.IsNullOrWhiteSpace(this.EmpregadoTextBox.Text)) ?
                        item.NumeroEmpregado : Int32.Parse(this.EmpregadoTextBox.Text);

                    item.CódigoCliente = (string.IsNullOrWhiteSpace(this.ClienteTextBox.Text)) ?
                         item.CódigoCliente : Int32.Parse(this.ClienteTextBox.Text);
                    
                   
                }
            }
            catch (Exception ex)
            {
                item = null;
                MessageBox.Show(ex.Message);
            }

            this.Dispose();
        }

        private void EmpregadoTextBox_TextChanged(object sender, EventArgs e)
        {

        }

        private void Alugueres_Load(object sender, EventArgs e)
        {

        }
    }
}
