using System;
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
    public partial class Equipamentos : RemoverForm
    {
        List<Equipamento> listaEquipamentos;

        public Equipamentos(List<Equipamento> equipamentos)
        {
            numero = null;
            listaEquipamentos = equipamentos;
            InitializeComponent();
            addToComponent();
        }
    }
}
