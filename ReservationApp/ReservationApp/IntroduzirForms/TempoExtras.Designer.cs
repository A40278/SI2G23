using System.Windows.Forms;

namespace ReservationApp.IntroduzirForms
{
    partial class TempoExtras
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
            this.button1 = new System.Windows.Forms.Button();
            this.DescricaoLabel = new System.Windows.Forms.Label();
            this.DescricaoTextBox = new System.Windows.Forms.TextBox();
            this.InicioLabel = new System.Windows.Forms.Label();
            this.InicioAnoLabel = new System.Windows.Forms.Label();
            this.InicioAnoTextBox = new System.Windows.Forms.TextBox();
            this.InicioMesLabel = new System.Windows.Forms.Label();
            this.InicioMesTextBox = new System.Windows.Forms.TextBox();
            this.InicioDiaLabel = new System.Windows.Forms.Label();
            this.InicioDiaTextBox = new System.Windows.Forms.TextBox();
            this.InicioHoraLabel = new System.Windows.Forms.Label();
            this.InicioMinutoLabel = new System.Windows.Forms.Label();
            this.FimLabel = new System.Windows.Forms.Label();
            this.FimAnoLabel = new System.Windows.Forms.Label();
            this.FimAnoTextBox = new System.Windows.Forms.TextBox();
            this.FimMesLabel = new System.Windows.Forms.Label();
            this.FimMesTextBox = new System.Windows.Forms.TextBox();
            this.FimDiaLabel = new System.Windows.Forms.Label();
            this.FimDiaTextBox = new System.Windows.Forms.TextBox();
            this.FimHoraLabel = new System.Windows.Forms.Label();
            this.InicioHoraTextBox = new System.Windows.Forms.TextBox();
            this.FimHoraTextBox = new System.Windows.Forms.TextBox();
            this.FimMinutoLabel = new System.Windows.Forms.Label();
            this.InicioMinutoTextBox = new System.Windows.Forms.TextBox();
            this.FimMinutoTextBox = new System.Windows.Forms.TextBox();
            this.FraçõesExtrasLabel = new System.Windows.Forms.Label();
            this.FraçõesExtrasTextBox = new System.Windows.Forms.TextBox();
            this.TipoDuracaoLable = new System.Windows.Forms.Label();
            this.TipoDuracaoTextBox = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(4, 175);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(372, 45);
            this.button1.TabIndex = 30;
            this.button1.Text = "Continuar";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // DescricaoLabel
            // 
            this.DescricaoLabel.AutoSize = true;
            this.DescricaoLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.DescricaoLabel.Location = new System.Drawing.Point(-1, 36);
            this.DescricaoLabel.Name = "DescricaoLabel";
            this.DescricaoLabel.Size = new System.Drawing.Size(108, 27);
            this.DescricaoLabel.TabIndex = 5;
            this.DescricaoLabel.Text = "Descrição";
            // 
            // DescricaoTextBox
            // 
            this.DescricaoTextBox.Location = new System.Drawing.Point(103, 39);
            this.DescricaoTextBox.Name = "DescricaoTextBox";
            this.DescricaoTextBox.Size = new System.Drawing.Size(273, 20);
            this.DescricaoTextBox.TabIndex = 6;
            // 
            // InicioLabel
            // 
            this.InicioLabel.AutoSize = true;
            this.InicioLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.InicioLabel.Location = new System.Drawing.Point(-1, 68);
            this.InicioLabel.Name = "InicioLabel";
            this.InicioLabel.Size = new System.Drawing.Size(119, 27);
            this.InicioLabel.TabIndex = 7;
            this.InicioLabel.Text = "Data Inicio";
            // 
            // InicioAnoLabel
            // 
            this.InicioAnoLabel.AutoSize = true;
            this.InicioAnoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioAnoLabel.Location = new System.Drawing.Point(2, 98);
            this.InicioAnoLabel.Name = "InicioAnoLabel";
            this.InicioAnoLabel.Size = new System.Drawing.Size(42, 21);
            this.InicioAnoLabel.TabIndex = 8;
            this.InicioAnoLabel.Text = "Ano";
            // 
            // InicioAnoTextBox
            // 
            this.InicioAnoTextBox.Location = new System.Drawing.Point(42, 98);
            this.InicioAnoTextBox.MaxLength = 4;
            this.InicioAnoTextBox.Name = "InicioAnoTextBox";
            this.InicioAnoTextBox.Size = new System.Drawing.Size(36, 20);
            this.InicioAnoTextBox.TabIndex = 9;
            // 
            // InicioMesLabel
            // 
            this.InicioMesLabel.AutoSize = true;
            this.InicioMesLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioMesLabel.Location = new System.Drawing.Point(82, 98);
            this.InicioMesLabel.Name = "InicioMesLabel";
            this.InicioMesLabel.Size = new System.Drawing.Size(42, 21);
            this.InicioMesLabel.TabIndex = 10;
            this.InicioMesLabel.Text = "Mês";
            // 
            // InicioMesTextBox
            // 
            this.InicioMesTextBox.Location = new System.Drawing.Point(122, 98);
            this.InicioMesTextBox.MaxLength = 2;
            this.InicioMesTextBox.Name = "InicioMesTextBox";
            this.InicioMesTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioMesTextBox.TabIndex = 11;
            // 
            // InicioDiaLabel
            // 
            this.InicioDiaLabel.AutoSize = true;
            this.InicioDiaLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioDiaLabel.Location = new System.Drawing.Point(152, 98);
            this.InicioDiaLabel.Name = "InicioDiaLabel";
            this.InicioDiaLabel.Size = new System.Drawing.Size(35, 21);
            this.InicioDiaLabel.TabIndex = 12;
            this.InicioDiaLabel.Text = "Dia";
            // 
            // InicioDiaTextBox
            // 
            this.InicioDiaTextBox.Location = new System.Drawing.Point(182, 98);
            this.InicioDiaTextBox.MaxLength = 2;
            this.InicioDiaTextBox.Name = "InicioDiaTextBox";
            this.InicioDiaTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioDiaTextBox.TabIndex = 13;
            // 
            // InicioHoraLabel
            // 
            this.InicioHoraLabel.AutoSize = true;
            this.InicioHoraLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioHoraLabel.Location = new System.Drawing.Point(212, 98);
            this.InicioHoraLabel.Name = "InicioHoraLabel";
            this.InicioHoraLabel.Size = new System.Drawing.Size(47, 21);
            this.InicioHoraLabel.TabIndex = 14;
            this.InicioHoraLabel.Text = "Hora";
            // 
            // InicioMinutoLabel
            // 
            this.InicioMinutoLabel.AutoSize = true;
            this.InicioMinutoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioMinutoLabel.Location = new System.Drawing.Point(287, 98);
            this.InicioMinutoLabel.Name = "InicioMinutoLabel";
            this.InicioMinutoLabel.Size = new System.Drawing.Size(63, 21);
            this.InicioMinutoLabel.TabIndex = 16;
            this.InicioMinutoLabel.Text = "Minuto";
            // 
            // FimLabel
            // 
            this.FimLabel.AutoSize = true;
            this.FimLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.FimLabel.Location = new System.Drawing.Point(-1, 118);
            this.FimLabel.Name = "FimLabel";
            this.FimLabel.Size = new System.Drawing.Size(101, 27);
            this.FimLabel.TabIndex = 19;
            this.FimLabel.Text = "Data Fim";
            // 
            // FimAnoLabel
            // 
            this.FimAnoLabel.AutoSize = true;
            this.FimAnoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimAnoLabel.Location = new System.Drawing.Point(2, 148);
            this.FimAnoLabel.Name = "FimAnoLabel";
            this.FimAnoLabel.Size = new System.Drawing.Size(42, 21);
            this.FimAnoLabel.TabIndex = 20;
            this.FimAnoLabel.Text = "Ano";
            // 
            // FimAnoTextBox
            // 
            this.FimAnoTextBox.Location = new System.Drawing.Point(42, 148);
            this.FimAnoTextBox.MaxLength = 4;
            this.FimAnoTextBox.Name = "FimAnoTextBox";
            this.FimAnoTextBox.Size = new System.Drawing.Size(36, 20);
            this.FimAnoTextBox.TabIndex = 21;
            // 
            // FimMesLabel
            // 
            this.FimMesLabel.AutoSize = true;
            this.FimMesLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimMesLabel.Location = new System.Drawing.Point(82, 148);
            this.FimMesLabel.Name = "FimMesLabel";
            this.FimMesLabel.Size = new System.Drawing.Size(42, 21);
            this.FimMesLabel.TabIndex = 22;
            this.FimMesLabel.Text = "Mês";
            // 
            // FimMesTextBox
            // 
            this.FimMesTextBox.Location = new System.Drawing.Point(122, 148);
            this.FimMesTextBox.MaxLength = 2;
            this.FimMesTextBox.Name = "FimMesTextBox";
            this.FimMesTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimMesTextBox.TabIndex = 23;
            // 
            // FimDiaLabel
            // 
            this.FimDiaLabel.AutoSize = true;
            this.FimDiaLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimDiaLabel.Location = new System.Drawing.Point(152, 148);
            this.FimDiaLabel.Name = "FimDiaLabel";
            this.FimDiaLabel.Size = new System.Drawing.Size(35, 21);
            this.FimDiaLabel.TabIndex = 24;
            this.FimDiaLabel.Text = "Dia";
            // 
            // FimDiaTextBox
            // 
            this.FimDiaTextBox.Location = new System.Drawing.Point(182, 148);
            this.FimDiaTextBox.MaxLength = 2;
            this.FimDiaTextBox.Name = "FimDiaTextBox";
            this.FimDiaTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimDiaTextBox.TabIndex = 25;
            // 
            // FimHoraLabel
            // 
            this.FimHoraLabel.AutoSize = true;
            this.FimHoraLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimHoraLabel.Location = new System.Drawing.Point(212, 148);
            this.FimHoraLabel.Name = "FimHoraLabel";
            this.FimHoraLabel.Size = new System.Drawing.Size(47, 21);
            this.FimHoraLabel.TabIndex = 26;
            this.FimHoraLabel.Text = "Hora";
            // 
            // InicioHoraTextBox
            // 
            this.InicioHoraTextBox.Location = new System.Drawing.Point(257, 98);
            this.InicioHoraTextBox.MaxLength = 2;
            this.InicioHoraTextBox.Name = "InicioHoraTextBox";
            this.InicioHoraTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioHoraTextBox.TabIndex = 15;
            // 
            // FimHoraTextBox
            // 
            this.FimHoraTextBox.Location = new System.Drawing.Point(257, 148);
            this.FimHoraTextBox.MaxLength = 2;
            this.FimHoraTextBox.Name = "FimHoraTextBox";
            this.FimHoraTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimHoraTextBox.TabIndex = 27;
            // 
            // FimMinutoLabel
            // 
            this.FimMinutoLabel.AutoSize = true;
            this.FimMinutoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimMinutoLabel.Location = new System.Drawing.Point(287, 148);
            this.FimMinutoLabel.Name = "FimMinutoLabel";
            this.FimMinutoLabel.Size = new System.Drawing.Size(63, 21);
            this.FimMinutoLabel.TabIndex = 28;
            this.FimMinutoLabel.Text = "Minuto";
            // 
            // InicioMinutoTextBox
            // 
            this.InicioMinutoTextBox.Location = new System.Drawing.Point(347, 98);
            this.InicioMinutoTextBox.MaxLength = 2;
            this.InicioMinutoTextBox.Name = "InicioMinutoTextBox";
            this.InicioMinutoTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioMinutoTextBox.TabIndex = 18;
            // 
            // FimMinutoTextBox
            // 
            this.FimMinutoTextBox.Location = new System.Drawing.Point(347, 148);
            this.FimMinutoTextBox.MaxLength = 2;
            this.FimMinutoTextBox.Name = "FimMinutoTextBox";
            this.FimMinutoTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimMinutoTextBox.TabIndex = 29;
            // 
            // FraçõesExtrasLabel
            // 
            this.FraçõesExtrasLabel.AutoSize = true;
            this.FraçõesExtrasLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.FraçõesExtrasLabel.Location = new System.Drawing.Point(1, 9);
            this.FraçõesExtrasLabel.Name = "FraçõesExtrasLabel";
            this.FraçõesExtrasLabel.Size = new System.Drawing.Size(65, 27);
            this.FraçõesExtrasLabel.TabIndex = 1;
            this.FraçõesExtrasLabel.Text = "Extra";
            // 
            // FraçõesExtrasTextBox
            // 
            this.FraçõesExtrasTextBox.Location = new System.Drawing.Point(72, 12);
            this.FraçõesExtrasTextBox.Name = "FraçõesExtrasTextBox";
            this.FraçõesExtrasTextBox.Size = new System.Drawing.Size(47, 20);
            this.FraçõesExtrasTextBox.TabIndex = 2;
            // 
            // TipoDuracaoLable
            // 
            this.TipoDuracaoLable.AutoSize = true;
            this.TipoDuracaoLable.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.TipoDuracaoLable.Location = new System.Drawing.Point(125, 9);
            this.TipoDuracaoLable.Name = "TipoDuracaoLable";
            this.TipoDuracaoLable.Size = new System.Drawing.Size(87, 27);
            this.TipoDuracaoLable.TabIndex = 3;
            this.TipoDuracaoLable.Text = "Periodo";
            // 
            // TipoDuracaoTextBox
            // 
            this.TipoDuracaoTextBox.Location = new System.Drawing.Point(209, 12);
            this.TipoDuracaoTextBox.MaxLength = 2;
            this.TipoDuracaoTextBox.Name = "TipoDuracaoTextBox";
            this.TipoDuracaoTextBox.Size = new System.Drawing.Size(47, 20);
            this.TipoDuracaoTextBox.TabIndex = 4;
            // 
            // TempoExtras
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(391, 228);
            this.Controls.Add(this.TipoDuracaoTextBox);
            this.Controls.Add(this.TipoDuracaoLable);
            this.Controls.Add(this.FraçõesExtrasTextBox);
            this.Controls.Add(this.FraçõesExtrasLabel);
            this.Controls.Add(this.FimMinutoTextBox);
            this.Controls.Add(this.FimMinutoLabel);
            this.Controls.Add(this.FimHoraTextBox);
            this.Controls.Add(this.FimHoraLabel);
            this.Controls.Add(this.FimDiaTextBox);
            this.Controls.Add(this.FimDiaLabel);
            this.Controls.Add(this.FimAnoTextBox);
            this.Controls.Add(this.FimAnoLabel);
            this.Controls.Add(this.FimLabel);
            this.Controls.Add(this.FimMesTextBox);
            this.Controls.Add(this.FimMesLabel);
            this.Controls.Add(this.InicioMinutoTextBox);
            this.Controls.Add(this.InicioMinutoLabel);
            this.Controls.Add(this.InicioHoraTextBox);
            this.Controls.Add(this.InicioHoraLabel);
            this.Controls.Add(this.InicioDiaTextBox);
            this.Controls.Add(this.InicioDiaLabel);
            this.Controls.Add(this.InicioMesTextBox);
            this.Controls.Add(this.InicioMesLabel);
            this.Controls.Add(this.InicioAnoTextBox);
            this.Controls.Add(this.InicioAnoLabel);
            this.Controls.Add(this.InicioLabel);
            this.Controls.Add(this.DescricaoTextBox);
            this.Controls.Add(this.DescricaoLabel);
            this.Controls.Add(this.button1);
            this.Name = "TempoExtras";
            this.Text = "Verificar Tipos";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion


        private System.Windows.Forms.Button button1;
        private Label DescricaoLabel;
        private TextBox DescricaoTextBox;
        private Label InicioLabel;
        private Label InicioAnoLabel;
        private TextBox InicioAnoTextBox;
        private Label InicioMesLabel;
        private TextBox InicioMesTextBox;
        private Label InicioDiaLabel;
        private TextBox InicioDiaTextBox;
        private Label InicioHoraLabel;
        private TextBox InicioHoraTextBox;
        private Label InicioMinutoLabel;
        private TextBox InicioMinutoTextBox;
        private Label FimLabel;
        private Label FimAnoLabel;
        private TextBox FimAnoTextBox;
        private Label FimMesLabel;
        private TextBox FimMesTextBox;
        private Label FimDiaLabel;
        private TextBox FimDiaTextBox;
        private Label FimHoraLabel;
        private TextBox FimHoraTextBox;
        private Label FimMinutoLabel;
        private TextBox FimMinutoTextBox;
        private Label FraçõesExtrasLabel;
        private TextBox FraçõesExtrasTextBox;
        private Label TipoDuracaoLable;
        private TextBox TipoDuracaoTextBox;
    }
}