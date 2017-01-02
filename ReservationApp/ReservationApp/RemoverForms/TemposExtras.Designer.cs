namespace ReservationApp.RemoverForms
{
    partial class TemposExtras
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
            this.fillTableLayoutTempoExtras(ref this.tableLayoutPanel1, listaTemposExtra);
            // 
            // CodgioLabel
            // 
            this.Label.Text = "Código";
            // 
            // TemposExtras
            // 
            this.Name = "TemposExtras";
            this.Text = "TemposExtras"; 
        }
    }
}