﻿using System.Windows.Forms;

namespace ReservationApp.IntroduzirForms
{
    partial class Precos
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
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.button1 = new System.Windows.Forms.Button();
            this.CodigoLabel = new System.Windows.Forms.Label();
            this.CodigoTextBox = new System.Windows.Forms.TextBox();
            this.TipoDLabel = new System.Windows.Forms.Label();
            this.TipoDTextBox = new System.Windows.Forms.TextBox();
            this.ValorLabel = new System.Windows.Forms.Label();
            this.ValorTextBox = new System.Windows.Forms.TextBox();
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
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.AutoScroll = true;
            this.tableLayoutPanel1.CellBorderStyle = System.Windows.Forms.TableLayoutPanelCellBorderStyle.Outset;
            this.tableLayoutPanel1.ColumnCount = 3;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 15F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 60F));
            this.tableLayoutPanel1.Location = new System.Drawing.Point(12, 12);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = this.listaEquipamentos.Count;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(400, 190);
            this.tableLayoutPanel1.TabIndex = 0;
            this.fillTableLayoutEquipamento(ref this.tableLayoutPanel1, listaEquipamentos);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(43, 372);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(300, 40);
            this.button1.TabIndex = 1;
            this.button1.Text = "Introduzir Preço";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // CodigoLabel
            // 
            this.CodigoLabel.AutoSize = true;
            this.CodigoLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.CodigoLabel.Location = new System.Drawing.Point(7, 205);
            this.CodigoLabel.Name = "CodigoLabel";
            this.CodigoLabel.Size = new System.Drawing.Size(81, 27);
            this.CodigoLabel.TabIndex = 2;
            this.CodigoLabel.Text = "Código";
            // 
            // CodigoTextBox
            // 
            this.CodigoTextBox.Location = new System.Drawing.Point(88, 208);
            this.CodigoTextBox.Name = "CodigoTextBox";
            this.CodigoTextBox.Size = new System.Drawing.Size(85, 20);
            this.CodigoTextBox.TabIndex = 3;
            // 
            // TipoDLabel
            // 
            this.TipoDLabel.AutoSize = true;
            this.TipoDLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.TipoDLabel.Location = new System.Drawing.Point(179, 205);
            this.TipoDLabel.Name = "TipoDLabel";
            this.TipoDLabel.Size = new System.Drawing.Size(143, 27);
            this.TipoDLabel.TabIndex = 4;
            this.TipoDLabel.Text = "Tipo Duração";
            // 
            // TipoDTextBox
            // 
            this.TipoDTextBox.Location = new System.Drawing.Point(319, 208);
            this.TipoDTextBox.MaxLength = 2;
            this.TipoDTextBox.Name = "TipoDTextBox";
            this.TipoDTextBox.Size = new System.Drawing.Size(65, 20);
            this.TipoDTextBox.TabIndex = 5;
            // 
            // ValorLabel
            // 
            this.ValorLabel.AutoSize = true;
            this.ValorLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.ValorLabel.Location = new System.Drawing.Point(7, 232);
            this.ValorLabel.Name = "ValorLabel";
            this.ValorLabel.Size = new System.Drawing.Size(62, 27);
            this.ValorLabel.TabIndex = 6;
            this.ValorLabel.Text = "Valor";
            // 
            // ValorTextBox
            // 
            this.ValorTextBox.Location = new System.Drawing.Point(88, 235);
            this.ValorTextBox.Name = "ValorTextBox";
            this.ValorTextBox.Size = new System.Drawing.Size(100, 20);
            this.ValorTextBox.TabIndex = 7;
            // 
            // InicioLabel
            // 
            this.InicioLabel.AutoSize = true;
            this.InicioLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.InicioLabel.Location = new System.Drawing.Point(7, 258);
            this.InicioLabel.Name = "InicioLabel";
            this.InicioLabel.Size = new System.Drawing.Size(119, 27);
            this.InicioLabel.TabIndex = 8;
            this.InicioLabel.Text = "Data Inicio";
            // 
            // InicioAnoLabel
            // 
            this.InicioAnoLabel.AutoSize = true;
            this.InicioAnoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioAnoLabel.Location = new System.Drawing.Point(10, 285);
            this.InicioAnoLabel.Name = "InicioAnoLabel";
            this.InicioAnoLabel.Size = new System.Drawing.Size(42, 21);
            this.InicioAnoLabel.TabIndex = 9;
            this.InicioAnoLabel.Text = "Ano";
            // 
            // InicioAnoTextBox
            // 
            this.InicioAnoTextBox.Location = new System.Drawing.Point(50, 285);
            this.InicioAnoTextBox.MaxLength = 4;
            this.InicioAnoTextBox.Name = "InicioAnoTextBox";
            this.InicioAnoTextBox.Size = new System.Drawing.Size(36, 20);
            this.InicioAnoTextBox.TabIndex = 10;
            // 
            // InicioMesLabel
            // 
            this.InicioMesLabel.AutoSize = true;
            this.InicioMesLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioMesLabel.Location = new System.Drawing.Point(90, 285);
            this.InicioMesLabel.Name = "InicioMesLabel";
            this.InicioMesLabel.Size = new System.Drawing.Size(42, 21);
            this.InicioMesLabel.TabIndex = 11;
            this.InicioMesLabel.Text = "Mês";
            // 
            // InicioMesTextBox
            // 
            this.InicioMesTextBox.Location = new System.Drawing.Point(130, 285);
            this.InicioMesTextBox.MaxLength = 2;
            this.InicioMesTextBox.Name = "InicioMesTextBox";
            this.InicioMesTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioMesTextBox.TabIndex = 12;
            // 
            // InicioDiaLabel
            // 
            this.InicioDiaLabel.AutoSize = true;
            this.InicioDiaLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioDiaLabel.Location = new System.Drawing.Point(160, 285);
            this.InicioDiaLabel.Name = "InicioDiaLabel";
            this.InicioDiaLabel.Size = new System.Drawing.Size(35, 21);
            this.InicioDiaLabel.TabIndex = 13;
            this.InicioDiaLabel.Text = "Dia";
            // 
            // InicioDiaTextBox
            // 
            this.InicioDiaTextBox.Location = new System.Drawing.Point(190, 285);
            this.InicioDiaTextBox.MaxLength = 2;
            this.InicioDiaTextBox.Name = "InicioDiaTextBox";
            this.InicioDiaTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioDiaTextBox.TabIndex = 14;
            // 
            // InicioHoraLabel
            // 
            this.InicioHoraLabel.AutoSize = true;
            this.InicioHoraLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioHoraLabel.Location = new System.Drawing.Point(220, 285);
            this.InicioHoraLabel.Name = "InicioHoraLabel";
            this.InicioHoraLabel.Size = new System.Drawing.Size(47, 21);
            this.InicioHoraLabel.TabIndex = 15;
            this.InicioHoraLabel.Text = "Hora";
            // 
            // InicioHoraTextBox
            // 
            this.InicioHoraTextBox.Location = new System.Drawing.Point(265, 285);
            this.InicioHoraTextBox.MaxLength = 2;
            this.InicioHoraTextBox.Name = "InicioHoraTextBox";
            this.InicioHoraTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioHoraTextBox.TabIndex = 16; 
            // 
            // InicioMinutoLabel
            // 
            this.InicioMinutoLabel.AutoSize = true;
            this.InicioMinutoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.InicioMinutoLabel.Location = new System.Drawing.Point(295, 285);
            this.InicioMinutoLabel.Name = "InicioMinutoLabel";
            this.InicioMinutoLabel.Size = new System.Drawing.Size(63, 21);
            this.InicioMinutoLabel.TabIndex = 17;
            this.InicioMinutoLabel.Text = "Minuto";
            // 
            // InicioMinutoTextBox
            // 
            this.InicioMinutoTextBox.Location = new System.Drawing.Point(355, 285);
            this.InicioMinutoTextBox.MaxLength = 2;
            this.InicioMinutoTextBox.Name = "InicioMinutoTextBox";
            this.InicioMinutoTextBox.Size = new System.Drawing.Size(29, 20);
            this.InicioMinutoTextBox.TabIndex = 18;
            // 
            // FimLabel
            // 
            this.FimLabel.AutoSize = true;
            this.FimLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.FimLabel.Location = new System.Drawing.Point(7, 309);
            this.FimLabel.Name = "FimLabel";
            this.FimLabel.Size = new System.Drawing.Size(101, 27);
            this.FimLabel.TabIndex = 19;
            this.FimLabel.Text = "Data Fim";
            // 
            // FimAnoLabel
            // 
            this.FimAnoLabel.AutoSize = true;
            this.FimAnoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimAnoLabel.Location = new System.Drawing.Point(10, 335);
            this.FimAnoLabel.Name = "FimAnoLabel";
            this.FimAnoLabel.Size = new System.Drawing.Size(42, 21);
            this.FimAnoLabel.TabIndex = 20;
            this.FimAnoLabel.Text = "Ano";
            // 
            // FimAnoTextBox
            // 
            this.FimAnoTextBox.Location = new System.Drawing.Point(50, 335);
            this.FimAnoTextBox.MaxLength = 4;
            this.FimAnoTextBox.Name = "FimAnoTextBox";
            this.FimAnoTextBox.Size = new System.Drawing.Size(36, 20);
            this.FimAnoTextBox.TabIndex = 21;
            // 
            // FimMesLabel
            // 
            this.FimMesLabel.AutoSize = true;
            this.FimMesLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimMesLabel.Location = new System.Drawing.Point(90, 335);
            this.FimMesLabel.Name = "FimMesLabel";
            this.FimMesLabel.Size = new System.Drawing.Size(42, 21);
            this.FimMesLabel.TabIndex = 11;
            this.FimMesLabel.Text = "Mês";
            // 
            // FimMesTextBox
            // 
            this.FimMesTextBox.Location = new System.Drawing.Point(130, 335);
            this.FimMesTextBox.MaxLength = 2;
            this.FimMesTextBox.Name = "FimMesTextBox";
            this.FimMesTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimMesTextBox.TabIndex = 12;
            // 
            // FimDiaLabel
            // 
            this.FimDiaLabel.AutoSize = true;
            this.FimDiaLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimDiaLabel.Location = new System.Drawing.Point(160, 335);
            this.FimDiaLabel.Name = "FimDiaLabel";
            this.FimDiaLabel.Size = new System.Drawing.Size(35, 21);
            this.FimDiaLabel.TabIndex = 22;
            this.FimDiaLabel.Text = "Dia";
            // 
            // FimDiaTextBox
            // 
            this.FimDiaTextBox.Location = new System.Drawing.Point(190, 335);
            this.FimDiaTextBox.MaxLength = 2;
            this.FimDiaTextBox.Name = "FimDiaTextBox";
            this.FimDiaTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimDiaTextBox.TabIndex = 23;
            // 
            // FimHoraLabel
            // 
            this.FimHoraLabel.AutoSize = true;
            this.FimHoraLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimHoraLabel.Location = new System.Drawing.Point(220, 335);
            this.FimHoraLabel.Name = "FimHoraLabel";
            this.FimHoraLabel.Size = new System.Drawing.Size(47, 21);
            this.FimHoraLabel.TabIndex = 24;
            this.FimHoraLabel.Text = "Hora";
            
            // 
            // FimHoraTextBox
            // 
            this.FimHoraTextBox.Location = new System.Drawing.Point(265, 335);
            this.FimHoraTextBox.MaxLength = 2;
            this.FimHoraTextBox.Name = "FimHoraTextBox";
            this.FimHoraTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimHoraTextBox.TabIndex = 25;
            // 
            // FimMinutoLabel
            // 
            this.FimMinutoLabel.AutoSize = true;
            this.FimMinutoLabel.Font = new System.Drawing.Font("Times New Roman", 14F);
            this.FimMinutoLabel.Location = new System.Drawing.Point(295, 335);
            this.FimMinutoLabel.Name = "FimMinutoLabel";
            this.FimMinutoLabel.Size = new System.Drawing.Size(63, 21);
            this.FimMinutoLabel.TabIndex = 26;
            this.FimMinutoLabel.Text = "Minuto";
            // 
            // FimMinutoTextBox
            // 
            this.FimMinutoTextBox.Location = new System.Drawing.Point(355, 335);
            this.FimMinutoTextBox.MaxLength = 2;
            this.FimMinutoTextBox.Name = "FimMinutoTextBox";
            this.FimMinutoTextBox.Size = new System.Drawing.Size(29, 20);
            this.FimMinutoTextBox.TabIndex = 27;
            // 
            // Precos
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(420, 424);
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
            this.Controls.Add(this.ValorTextBox);
            this.Controls.Add(this.ValorLabel);
            this.Controls.Add(this.TipoDTextBox);
            this.Controls.Add(this.TipoDLabel);
            this.Controls.Add(this.CodigoTextBox);
            this.Controls.Add(this.CodigoLabel);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Controls.Add(this.button1);
            this.Name = "Precos";
            this.Text = "Introduzir Preço";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Button button1;
        private Label CodigoLabel;
        private TextBox CodigoTextBox;
        private Label TipoDLabel;
        private TextBox TipoDTextBox;
        private Label ValorLabel;
        private TextBox ValorTextBox;
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
    }
}