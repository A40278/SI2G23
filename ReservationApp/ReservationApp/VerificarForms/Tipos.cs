﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.VerificarForms
{
    public partial class Tipos : VerificarForm
    {
        List<Tipo> listaTipo;

        public Tipos(List<Tipo> tipos)
        {
            this.listaTipo = tipos;
            InitializeComponent();
            addToComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }
    }
}
