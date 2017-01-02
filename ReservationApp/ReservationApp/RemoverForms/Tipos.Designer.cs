using System.Windows.Forms;

namespace ReservationApp.RemoverForms
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
            this.button1.Click -= new System.EventHandler(this.button1_Click);
            this.button1.Click += new System.EventHandler(this.button1_Click1);
            // 
            // tableLayoutPanel1
            // 
            this.fillTableLayoutTipos(ref this.tableLayoutPanel1, listaTipos);
            // 
            // NomeLabel
            // 
            this.Label.Text = "Nome Tipo";
            // 
            // Tipos
            // 
            this.Name = "Tipos";
            this.Text = "Tipo";

        }
    }
}