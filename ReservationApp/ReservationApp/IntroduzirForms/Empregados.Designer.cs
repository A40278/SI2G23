namespace ReservationApp.IntroduzirForms
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.NomeLabel = new System.Windows.Forms.Label();
            this.NomeTextoBox = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // NomeLabel
            // 
            this.NomeLabel.AutoSize = true;
            this.NomeLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.NomeLabel.Location = new System.Drawing.Point(12, 9);
            this.NomeLabel.Name = "NomeLabel";
            this.NomeLabel.Size = new System.Drawing.Size(70, 27);
            this.NomeLabel.TabIndex = 0;
            this.NomeLabel.Text = "Nome";
            // 
            // NomeTextoBox
            // 
            this.NomeTextoBox.Location = new System.Drawing.Point(12, 36);
            this.NomeTextoBox.Name = "NomeTextoBox";
            this.NomeTextoBox.Size = new System.Drawing.Size(100, 20);
            this.NomeTextoBox.TabIndex = 1;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(12, 62);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(260, 44);
            this.button1.TabIndex = 2;
            this.button1.Text = "Introduzir Empregado";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Empregados
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 111);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.NomeTextoBox);
            this.Controls.Add(this.NomeLabel);
            this.Name = "Empregados";
            this.Text = "Empregado";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label NomeLabel;
        private System.Windows.Forms.TextBox NomeTextoBox;
        private System.Windows.Forms.Button button1;
    }
}