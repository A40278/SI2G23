﻿using System;
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
    public partial class DatasSemTipo : IntroduzirForm<DataNTipo>
    {

        public DatasSemTipo()
        {
            item = null;
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                item = new DataNTipo()
                    {
                        Inicio = this.formDate(this.InicioAnoTextBox.Text, this.InicioMesTextBox.Text
                            , this.InicioDiaTextBox.Text, this.InicioHoraTextBox.Text, this.InicioMinutoTextBox.Text),
                        Fim = this.formDate(this.FimAnoTextBox.Text, this.FimMesTextBox.Text
                            , this.FimDiaTextBox.Text, this.FimHoraTextBox.Text, this.FimMinutoTextBox.Text),
                    };
            }
            catch (Exception exe)
            {
                MessageBox.Show(exe.Message);
            }

            this.Dispose();
        }

    }
}