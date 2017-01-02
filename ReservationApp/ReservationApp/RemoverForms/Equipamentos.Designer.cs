using System.Windows.Forms;

namespace ReservationApp.RemoverForms
{
    partial class Equipamentos
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
            this.fillTableLayoutEquipamento(ref this.tableLayoutPanel1, listaEquipamentos);
            // 
            // CodigoLabel
            // 
            this.Label.Text = "Codigo";
            // 
            // Equipamentos
            // 
            this.Name = "Equipamentos";
            this.Text = "Remover Equipamentos";

        }
    }
}