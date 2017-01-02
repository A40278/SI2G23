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
    public partial class Precos : IntroduzirForm<Preço>
    {
        List<Equipamento> listaEquipamentos;

        public Precos(List<Equipamento> equipamentos)
        {
            item = null;
            this.listaEquipamentos = equipamentos;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string c = this.CodigoTextBox.Text;
            string v = this.ValorTextBox.Text;
            string td = this.TipoDTextBox.Text;

            try
            {
                this.item = ((string.IsNullOrWhiteSpace(c))) ? null :
                    new Preço()
                    {
                        CódigoEquipamento = Int32.Parse(c),
                        Valor = Convert.ToDecimal(v),
                        TipoDuração = td,
                        Inicio = formDate(this.InicioAnoTextBox.Text,this.InicioMesTextBox.Text
                            ,this.InicioDiaTextBox.Text, this.InicioHoraTextBox.Text, this.InicioMinutoTextBox.Text),
                        Fim = formDate(this.FimAnoTextBox.Text, this.FimMesTextBox.Text
                            , this.FimDiaTextBox.Text, this.FimHoraTextBox.Text, this.FimMinutoTextBox.Text),
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
