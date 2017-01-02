namespace ReservationApp.IntroduzirForms
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.NomeLabel = new System.Windows.Forms.Label();
            this.NomeTextBox = new System.Windows.Forms.TextBox();
            this.DescricaoLabel = new System.Windows.Forms.Label();
            this.DescricaoTextBox = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // NomeLabel
            // 
            this.NomeLabel.AutoSize = true;
            this.NomeLabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.NomeLabel.Location = new System.Drawing.Point(3, 9);
            this.NomeLabel.Name = "NomeLabel";
            this.NomeLabel.Size = new System.Drawing.Size(79, 31);
            this.NomeLabel.TabIndex = 0;
            this.NomeLabel.Text = "Nome";
            // 
            // NomeTextBox
            // 
            this.NomeTextBox.Location = new System.Drawing.Point(9, 44);
            this.NomeTextBox.Name = "NomeTextBox";
            this.NomeTextBox.Size = new System.Drawing.Size(263, 20);
            this.NomeTextBox.TabIndex = 1;
            // 
            // DescricaoLabel
            // 
            this.DescricaoLabel.AutoSize = true;
            this.DescricaoLabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.DescricaoLabel.Location = new System.Drawing.Point(3, 67);
            this.DescricaoLabel.Name = "DescricaoLabel";
            this.DescricaoLabel.Size = new System.Drawing.Size(121, 31);
            this.DescricaoLabel.TabIndex = 2;
            this.DescricaoLabel.Text = "Descrição";
            // 
            // DescricaoTextBox
            // 
            this.DescricaoTextBox.Location = new System.Drawing.Point(9, 101);
            this.DescricaoTextBox.Name = "DescricaoTextBox";
            this.DescricaoTextBox.Size = new System.Drawing.Size(263, 20);
            this.DescricaoTextBox.TabIndex = 3;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(9, 137);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(263, 42);
            this.button1.TabIndex = 4;
            this.button1.Text = "Introduzir Tipo";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Tipos
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(284, 200);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.DescricaoTextBox);
            this.Controls.Add(this.DescricaoLabel);
            this.Controls.Add(this.NomeTextBox);
            this.Controls.Add(this.NomeLabel);
            this.Name = "Tipos";
            this.Text = "Introduzir Tipos";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label NomeLabel;
        private System.Windows.Forms.TextBox NomeTextBox;
        private System.Windows.Forms.Label DescricaoLabel;
        private System.Windows.Forms.TextBox DescricaoTextBox;
        private System.Windows.Forms.Button button1;
    }
}