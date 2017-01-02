

namespace ReservationApp.IntroduzirForms
{
    partial class Clientes
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.NomeLabel = new System.Windows.Forms.Label();
            this.NomeTextBox = new System.Windows.Forms.TextBox();
            this.NumeroFiscalLabel = new System.Windows.Forms.Label();
            this.NumeroFiscalTextBox = new System.Windows.Forms.TextBox();
            this.MoradaLabel = new System.Windows.Forms.Label();
            this.MoradaTextBox = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // NomeLabel
            // 
            this.NomeLabel.AutoSize = true;
            this.NomeLabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.NomeLabel.Location = new System.Drawing.Point(12, 18);
            this.NomeLabel.Name = "NomeLabel";
            this.NomeLabel.Size = new System.Drawing.Size(79, 31);
            this.NomeLabel.TabIndex = 0;
            this.NomeLabel.Text = "Nome";
            // 
            // NomeTextBox
            // 
            this.NomeTextBox.Location = new System.Drawing.Point(18, 52);
            this.NomeTextBox.Name = "NomeTextBox";
            this.NomeTextBox.Size = new System.Drawing.Size(254, 20);
            this.NomeTextBox.TabIndex = 1;
            // 
            // NumeroFiscalLabel
            // 
            this.NumeroFiscalLabel.AutoSize = true;
            this.NumeroFiscalLabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.NumeroFiscalLabel.Location = new System.Drawing.Point(12, 75);
            this.NumeroFiscalLabel.Name = "NumeroFiscalLabel";
            this.NumeroFiscalLabel.Size = new System.Drawing.Size(228, 31);
            this.NumeroFiscalLabel.TabIndex = 2;
            this.NumeroFiscalLabel.Text = "NumeroFiscal";
            // 
            // NumeroFiscalTextBox
            // 
            this.NumeroFiscalTextBox.Location = new System.Drawing.Point(18, 109);
            this.NumeroFiscalTextBox.Name = "NumeroFiscalTextBox";
            this.NumeroFiscalTextBox.Size = new System.Drawing.Size(254, 20);
            this.NumeroFiscalTextBox.TabIndex = 3;
            // 
            // MoradaLabel
            // 
            this.MoradaLabel.AutoSize = true;
            this.MoradaLabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.MoradaLabel.Location = new System.Drawing.Point(12, 132);
            this.MoradaLabel.Name = "MoradaLabel";
            this.MoradaLabel.Size = new System.Drawing.Size(161, 31);
            this.MoradaLabel.TabIndex = 4;
            this.MoradaLabel.Text = "Morada";
            // 
            // MoradaTextBox
            // 
            this.MoradaTextBox.Location = new System.Drawing.Point(18, 166);
            this.MoradaTextBox.Name = "MoradaTextBox";
            this.MoradaTextBox.Size = new System.Drawing.Size(254, 20);
            this.MoradaTextBox.TabIndex = 5;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(18, 192);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(254, 57);
            this.button1.TabIndex = 6;
            this.button1.Text = "Introduzir Cliente";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // IntroduzirClienteForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 261);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.MoradaTextBox);
            this.Controls.Add(this.MoradaLabel);
            this.Controls.Add(this.NumeroFiscalTextBox);
            this.Controls.Add(this.NumeroFiscalLabel);
            this.Controls.Add(this.NomeTextBox);
            this.Controls.Add(this.NomeLabel);
            this.Name = "Introduzir Cliente";
            this.Text = "Introduzir Cliente";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label NomeLabel;
        private System.Windows.Forms.TextBox NomeTextBox;
        private System.Windows.Forms.Label NumeroFiscalLabel;
        private System.Windows.Forms.TextBox NumeroFiscalTextBox;
        private System.Windows.Forms.Label MoradaLabel;
        private System.Windows.Forms.TextBox MoradaTextBox;
        private System.Windows.Forms.Button button1;
    }
}