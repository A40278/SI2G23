﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.RemoverForms
{
    public partial class Precos : RemoverForm
    {
        List<Preço> listaPrecos;

        public Precos(List<Preço> precos)
        {
            listaPrecos = precos;
            InitializeComponent();
            addToComponent();
        }
    }
}