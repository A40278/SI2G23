using System.Windows.Forms;

namespace ReservationApp.RemoverForms
{
    partial class Empregados
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void addToComponent()
        {
            // 
            // tableLayoutPanel1
            // 
            this.fillTableLayoutPanelEmpregados(ref this.tableLayoutPanel1, listaEmpregados);
            // 
            // NumeroLabel
            // 
            this.Label.Text = "Numero";
            // 
            // Empregados
            //            
            this.Name = "Empregados";
            this.Text = "Empregados";
        }


    }
}