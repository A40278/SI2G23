using System.Windows.Forms;

namespace ReservationApp.IntroduzirForms
{
    partial class AlugueresClientes
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
            this.EmpregadoLabel = new System.Windows.Forms.Label();
            this.EmpregadoTextBox = new System.Windows.Forms.TextBox();
            this.PeriodoTextBox = new System.Windows.Forms.TextBox();
            this.PeriodoLabel = new System.Windows.Forms.Label();
            this.FimMinutoTextBox = new System.Windows.Forms.TextBox();
            this.FimMinutoLabel = new System.Windows.Forms.Label();
            this.FimHoraTextBox = new System.Windows.Forms.TextBox();
            this.FimHoraLabel = new System.Windows.Forms.Label();
            this.FimDiaTextBox = new System.Windows.Forms.TextBox();
            this.FimDiaLabel = new System.Windows.Forms.Label();
            this.FimAnoTextBox = new System.Windows.Forms.TextBox();
            this.FimAnoLabel = new System.Windows.Forms.Label();
            this.FimLabel = new System.Windows.Forms.Label();
            this.FimMesTextBox = new System.Windows.Forms.TextBox();
            this.FimMesLabel = new System.Windows.Forms.Label();
            this.InicioMinutoTextBox = new System.Windows.Forms.TextBox();
            this.InicioMinutoLabel = new System.Windows.Forms.Label();
            this.InicioHoraTextBox = new System.Windows.Forms.TextBox();
            this.InicioHoraLabel = new System.Windows.Forms.Label();
            this.InicioDiaTextBox = new System.Windows.Forms.TextBox();
            this.InicioDiaLabel = new System.Windows.Forms.Label();
            this.InicioMesTextBox = new System.Windows.Forms.TextBox();
            this.InicioMesLabel = new System.Windows.Forms.Label();
            this.InicioAnoTextBox = new System.Windows.Forms.TextBox();
            this.InicioAnoLabel = new System.Windows.Forms.Label();
            this.InicioLabel = new System.Windows.Forms.Label();
            this.AluguerLabel = new System.Windows.Forms.Label();
            this.Clientelabel = new System.Windows.Forms.Label();
            this.MoradaTextBox = new System.Windows.Forms.TextBox();
            this.MoradaLabel = new System.Windows.Forms.Label();
            this.NumeroFiscalTextBox = new System.Windows.Forms.TextBox();
            this.NumeroFiscalLabel = new System.Windows.Forms.Label();
            this.NomeTextBox = new System.Windows.Forms.TextBox();
            this.NomeLabel = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(12, 374);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(377, 40);
            this.button1.TabIndex = 32;
            this.button1.Text = "Continuar";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // EmpregadoLabel
            // 
            this.EmpregadoLabel.AutoSize = true;
            this.EmpregadoLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.EmpregadoLabel.Location = new System.Drawing.Point(9, 242);
            this.EmpregadoLabel.Name = "EmpregadoLabel";
            this.EmpregadoLabel.Size = new System.Drawing.Size(122, 27);
            this.EmpregadoLabel.TabIndex = 7;
            this.EmpregadoLabel.Text = "Empregado";
            // 
            // EmpregadoTextBox
            // 
            this.EmpregadoTextBox.Location = new System.Drawing.Point(136, 245);
            this.EmpregadoTextBox.MaxLength = 2;
            this.EmpregadoTextBox.Name = "EmpregadoTextBox";
            this.EmpregadoTextBox.Size = new System.Drawing.Size(47, 20);
            this.EmpregadoTextBox.TabIndex = 8;
            // 
            // PeriodoTextBox
            // 
            this.PeriodoTextBox.Location = new System.Drawing.Point(282, 245);
            this.PeriodoTextBox.MaxLength = 2;
            this.PeriodoTextBox.Name = "PeriodoTextBox";
            this.PeriodoTextBox.Size = new System.Drawing.Size(47, 20);
            this.PeriodoTextBox.TabIndex = 10;
            // 
            // PeriodoLabel
            // 
            this.PeriodoLabel.AutoSize = true;
            this.PeriodoLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.PeriodoLabel.Location = new System.Drawing.Point(189, 242);
            this.PeriodoLabel.Name = "PeriodoLabel";
            this.PeriodoLabel.Size = new System.Drawing.Size(87, 27);
            this.PeriodoLabel.TabIndex = 9;
            this.PeriodoLabel.Text = "Periodo";
            // 
            // FimMinutoTextBox
            // 
            this.FimMinutoTextBox.Location = new System.Drawing.Point(360, 349);
            this.FimMinutoTextBox.MaxLength = 2;
            this.FimMinutoTextBox.Name = "FimMinutoTextBox";
            this.FimMinutoTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimMinutoTextBox.TabIndex = 31;
            // 
            // FimMinutoLabel
            // 
            this.FimMinutoLabel.AutoSize = true;
            this.FimMinutoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimMinutoLabel.Location = new System.Drawing.Point(300, 349);
            this.FimMinutoLabel.Name = "FimMinutoLabel";
            this.FimMinutoLabel.Size = new System.Drawing.Size(63, 21);
            this.FimMinutoLabel.TabIndex = 30;
            this.FimMinutoLabel.Text = "Minuto";
            // 
            // FimHoraTextBox
            // 
            this.FimHoraTextBox.Location = new System.Drawing.Point(270, 349);
            this.FimHoraTextBox.MaxLength = 2;
            this.FimHoraTextBox.Name = "FimHoraTextBox";
            this.FimHoraTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimHoraTextBox.TabIndex = 29;
            // 
            // FimHoraLabel
            // 
            this.FimHoraLabel.AutoSize = true;
            this.FimHoraLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimHoraLabel.Location = new System.Drawing.Point(225, 349);
            this.FimHoraLabel.Name = "FimHoraLabel";
            this.FimHoraLabel.Size = new System.Drawing.Size(47, 21);
            this.FimHoraLabel.TabIndex = 28;
            this.FimHoraLabel.Text = "Hora";
            // 
            // FimDiaTextBox
            // 
            this.FimDiaTextBox.Location = new System.Drawing.Point(195, 349);
            this.FimDiaTextBox.MaxLength = 2;
            this.FimDiaTextBox.Name = "FimDiaTextBox";
            this.FimDiaTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimDiaTextBox.TabIndex = 27;
            // 
            // FimDiaLabel
            // 
            this.FimDiaLabel.AutoSize = true;
            this.FimDiaLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimDiaLabel.Location = new System.Drawing.Point(165, 349);
            this.FimDiaLabel.Name = "FimDiaLabel";
            this.FimDiaLabel.Size = new System.Drawing.Size(35, 21);
            this.FimDiaLabel.TabIndex = 26;
            this.FimDiaLabel.Text = "Dia";
            // 
            // FimAnoTextBox
            // 
            this.FimAnoTextBox.Location = new System.Drawing.Point(55, 349);
            this.FimAnoTextBox.MaxLength = 4;
            this.FimAnoTextBox.Name = "FimAnoTextBox";
            this.FimAnoTextBox.Size = new System.Drawing.Size(36, 20);
            this.FimAnoTextBox.TabIndex = 23;
            // 
            // FimAnoLabel
            // 
            this.FimAnoLabel.AutoSize = true;
            this.FimAnoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimAnoLabel.Location = new System.Drawing.Point(15, 349);
            this.FimAnoLabel.Name = "FimAnoLabel";
            this.FimAnoLabel.Size = new System.Drawing.Size(42, 21);
            this.FimAnoLabel.TabIndex = 22;
            this.FimAnoLabel.Text = "Ano";
            // 
            // FimLabel
            // 
            this.FimLabel.AutoSize = true;
            this.FimLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.FimLabel.Location = new System.Drawing.Point(12, 319);
            this.FimLabel.Name = "FimLabel";
            this.FimLabel.Size = new System.Drawing.Size(101, 27);
            this.FimLabel.TabIndex = 21;
            this.FimLabel.Text = "Data Fim";
            // 
            // FimMesTextBox
            // 
            this.FimMesTextBox.Location = new System.Drawing.Point(135, 349);
            this.FimMesTextBox.MaxLength = 2;
            this.FimMesTextBox.Name = "FimMesTextBox";
            this.FimMesTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimMesTextBox.TabIndex = 25;
            // 
            // FimMesLabel
            // 
            this.FimMesLabel.AutoSize = true;
            this.FimMesLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimMesLabel.Location = new System.Drawing.Point(95, 349);
            this.FimMesLabel.Name = "FimMesLabel";
            this.FimMesLabel.Size = new System.Drawing.Size(42, 21);
            this.FimMesLabel.TabIndex = 24;
            this.FimMesLabel.Text = "Mês";
            // 
            // InicioMinutoTextBox
            // 
            this.InicioMinutoTextBox.Location = new System.Drawing.Point(360, 299);
            this.InicioMinutoTextBox.MaxLength = 2;
            this.InicioMinutoTextBox.Name = "InicioMinutoTextBox";
            this.InicioMinutoTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioMinutoTextBox.TabIndex = 20;
            // 
            // InicioMinutoLabel
            // 
            this.InicioMinutoLabel.AutoSize = true;
            this.InicioMinutoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioMinutoLabel.Location = new System.Drawing.Point(300, 299);
            this.InicioMinutoLabel.Name = "InicioMinutoLabel";
            this.InicioMinutoLabel.Size = new System.Drawing.Size(63, 21);
            this.InicioMinutoLabel.TabIndex = 19;
            this.InicioMinutoLabel.Text = "Minuto";
            // 
            // InicioHoraTextBox
            // 
            this.InicioHoraTextBox.Location = new System.Drawing.Point(270, 299);
            this.InicioHoraTextBox.MaxLength = 2;
            this.InicioHoraTextBox.Name = "InicioHoraTextBox";
            this.InicioHoraTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioHoraTextBox.TabIndex = 18;
            // 
            // InicioHoraLabel
            // 
            this.InicioHoraLabel.AutoSize = true;
            this.InicioHoraLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioHoraLabel.Location = new System.Drawing.Point(225, 299);
            this.InicioHoraLabel.Name = "InicioHoraLabel";
            this.InicioHoraLabel.Size = new System.Drawing.Size(47, 21);
            this.InicioHoraLabel.TabIndex = 17;
            this.InicioHoraLabel.Text = "Hora";
            // 
            // InicioDiaTextBox
            // 
            this.InicioDiaTextBox.Location = new System.Drawing.Point(195, 299);
            this.InicioDiaTextBox.MaxLength = 2;
            this.InicioDiaTextBox.Name = "InicioDiaTextBox";
            this.InicioDiaTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioDiaTextBox.TabIndex = 16;
            // 
            // InicioDiaLabel
            // 
            this.InicioDiaLabel.AutoSize = true;
            this.InicioDiaLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioDiaLabel.Location = new System.Drawing.Point(165, 299);
            this.InicioDiaLabel.Name = "InicioDiaLabel";
            this.InicioDiaLabel.Size = new System.Drawing.Size(35, 21);
            this.InicioDiaLabel.TabIndex = 35;
            this.InicioDiaLabel.Text = "Dia";
            // 
            // InicioMesTextBox
            // 
            this.InicioMesTextBox.Location = new System.Drawing.Point(135, 299);
            this.InicioMesTextBox.MaxLength = 2;
            this.InicioMesTextBox.Name = "InicioMesTextBox";
            this.InicioMesTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioMesTextBox.TabIndex = 15;
            // 
            // InicioMesLabel
            // 
            this.InicioMesLabel.AutoSize = true;
            this.InicioMesLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioMesLabel.Location = new System.Drawing.Point(95, 299);
            this.InicioMesLabel.Name = "InicioMesLabel";
            this.InicioMesLabel.Size = new System.Drawing.Size(42, 21);
            this.InicioMesLabel.TabIndex = 14;
            this.InicioMesLabel.Text = "Mês";
            // 
            // InicioAnoTextBox
            // 
            this.InicioAnoTextBox.Location = new System.Drawing.Point(55, 299);
            this.InicioAnoTextBox.MaxLength = 4;
            this.InicioAnoTextBox.Name = "InicioAnoTextBox";
            this.InicioAnoTextBox.Size = new System.Drawing.Size(36, 20);
            this.InicioAnoTextBox.TabIndex = 13;
            // 
            // InicioAnoLabel
            // 
            this.InicioAnoLabel.AutoSize = true;
            this.InicioAnoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioAnoLabel.Location = new System.Drawing.Point(15, 299);
            this.InicioAnoLabel.Name = "InicioAnoLabel";
            this.InicioAnoLabel.Size = new System.Drawing.Size(42, 21);
            this.InicioAnoLabel.TabIndex = 12;
            this.InicioAnoLabel.Text = "Ano";
            // 
            // InicioLabel
            // 
            this.InicioLabel.AutoSize = true;
            this.InicioLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.InicioLabel.Location = new System.Drawing.Point(12, 269);
            this.InicioLabel.Name = "InicioLabel";
            this.InicioLabel.Size = new System.Drawing.Size(119, 27);
            this.InicioLabel.TabIndex = 11;
            this.InicioLabel.Text = "Data Inicio";
            // 
            // AluguerLabel
            // 
            this.AluguerLabel.AutoSize = true;
            this.AluguerLabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.AluguerLabel.Location = new System.Drawing.Point(6, 202);
            this.AluguerLabel.Name = "AluguerLabel";
            this.AluguerLabel.Size = new System.Drawing.Size(102, 31);
            this.AluguerLabel.TabIndex = 36;
            this.AluguerLabel.Text = "Aluguer";
            // 
            // Clientelabel
            // 
            this.Clientelabel.AutoSize = true;
            this.Clientelabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.Clientelabel.Location = new System.Drawing.Point(6, 9);
            this.Clientelabel.Name = "Clientelabel";
            this.Clientelabel.Size = new System.Drawing.Size(93, 31);
            this.Clientelabel.TabIndex = 37;
            this.Clientelabel.Text = "Cliente";
            // 
            // MoradaTextBox
            // 
            this.MoradaTextBox.Location = new System.Drawing.Point(14, 183);
            this.MoradaTextBox.Name = "MoradaTextBox";
            this.MoradaTextBox.Size = new System.Drawing.Size(254, 20);
            this.MoradaTextBox.TabIndex = 43;
            // 
            // MoradaLabel
            // 
            this.MoradaLabel.AutoSize = true;
            this.MoradaLabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.MoradaLabel.Location = new System.Drawing.Point(8, 149);
            this.MoradaLabel.Name = "MoradaLabel";
            this.MoradaLabel.Size = new System.Drawing.Size(99, 31);
            this.MoradaLabel.TabIndex = 42;
            this.MoradaLabel.Text = "Morada";
            // 
            // NumeroFiscalTextBox
            // 
            this.NumeroFiscalTextBox.Location = new System.Drawing.Point(14, 126);
            this.NumeroFiscalTextBox.Name = "NumeroFiscalTextBox";
            this.NumeroFiscalTextBox.Size = new System.Drawing.Size(254, 20);
            this.NumeroFiscalTextBox.TabIndex = 41;
            // 
            // NumeroFiscalLabel
            // 
            this.NumeroFiscalLabel.AutoSize = true;
            this.NumeroFiscalLabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.NumeroFiscalLabel.Location = new System.Drawing.Point(8, 92);
            this.NumeroFiscalLabel.Name = "NumeroFiscalLabel";
            this.NumeroFiscalLabel.Size = new System.Drawing.Size(166, 31);
            this.NumeroFiscalLabel.TabIndex = 40;
            this.NumeroFiscalLabel.Text = "NumeroFiscal";
            // 
            // NomeTextBox
            // 
            this.NomeTextBox.Location = new System.Drawing.Point(14, 69);
            this.NomeTextBox.Name = "NomeTextBox";
            this.NomeTextBox.Size = new System.Drawing.Size(254, 20);
            this.NomeTextBox.TabIndex = 39;
            // 
            // NomeLabel
            // 
            this.NomeLabel.AutoSize = true;
            this.NomeLabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.NomeLabel.Location = new System.Drawing.Point(8, 35);
            this.NomeLabel.Name = "NomeLabel";
            this.NomeLabel.Size = new System.Drawing.Size(79, 31);
            this.NomeLabel.TabIndex = 38;
            this.NomeLabel.Text = "Nome";
            // 
            // AlugueresClientes
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(407, 419);
            this.Controls.Add(this.MoradaTextBox);
            this.Controls.Add(this.MoradaLabel);
            this.Controls.Add(this.NumeroFiscalTextBox);
            this.Controls.Add(this.NumeroFiscalLabel);
            this.Controls.Add(this.NomeTextBox);
            this.Controls.Add(this.NomeLabel);
            this.Controls.Add(this.Clientelabel);
            this.Controls.Add(this.AluguerLabel);
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
            this.Controls.Add(this.PeriodoTextBox);
            this.Controls.Add(this.PeriodoLabel);
            this.Controls.Add(this.EmpregadoTextBox);
            this.Controls.Add(this.EmpregadoLabel);
            this.Controls.Add(this.button1);
            this.Name = "AlugueresClientes";
            this.Text = "Verificar Clientes";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private Button button1;
        private Label EmpregadoLabel;
        private TextBox EmpregadoTextBox;
        private TextBox PeriodoTextBox;
        private Label PeriodoLabel;
        private TextBox FimMinutoTextBox;
        private Label FimMinutoLabel;
        private TextBox FimHoraTextBox;
        private Label FimHoraLabel;
        private TextBox FimDiaTextBox;
        private Label FimDiaLabel;
        private TextBox FimAnoTextBox;
        private Label FimAnoLabel;
        private Label FimLabel;
        private TextBox FimMesTextBox;
        private Label FimMesLabel;
        private TextBox InicioMinutoTextBox;
        private Label InicioMinutoLabel;
        private TextBox InicioHoraTextBox;
        private Label InicioHoraLabel;
        private TextBox InicioDiaTextBox;
        private Label InicioDiaLabel;
        private TextBox InicioMesTextBox;
        private Label InicioMesLabel;
        private TextBox InicioAnoTextBox;
        private Label InicioAnoLabel;
        private Label InicioLabel;
        private Label AluguerLabel;
        private Label Clientelabel;
        private TextBox MoradaTextBox;
        private Label MoradaLabel;
        private TextBox NumeroFiscalTextBox;
        private Label NumeroFiscalLabel;
        private TextBox NomeTextBox;
        private Label NomeLabel;
    }
}