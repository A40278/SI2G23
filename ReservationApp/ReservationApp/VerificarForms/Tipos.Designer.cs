using System.Windows.Forms;

namespace ReservationApp.VerificarForms
{
    partial class Tipos
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
            this.fillTableLayoutTipos(ref this.tableLayoutPanel1,
                this.listaTipo);
            // 
            // Tipos
            // 
            this.Name = "Tipos";
            this.Text = "Verificar Tipos";
        }
    }
}