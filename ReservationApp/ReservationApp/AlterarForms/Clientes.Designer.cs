using System.Windows.Forms;

namespace ReservationApp.AlterarForms
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
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.CódigoLabel = new System.Windows.Forms.Label();
            this.CódigoTextBox = new System.Windows.Forms.TextBox();
            this.MoradaLabel = new System.Windows.Forms.Label();
            this.MoradaTextBox = new System.Windows.Forms.TextBox();
            this.NomeLabel = new System.Windows.Forms.Label();
            this.NomeTextBox = new System.Windows.Forms.TextBox();
            this.NumeroFiscalLabel = new System.Windows.Forms.Label();
            this.NumeroFiscalTextBox = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.AutoScroll = true;
            this.tableLayoutPanel1.CellBorderStyle = System.Windows.Forms.TableLayoutPanelCellBorderStyle.Outset; 
            this.tableLayoutPanel1.Location = new System.Drawing.Point(12, 12);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.Size = new System.Drawing.Size(645, 359);
            this.tableLayoutPanel1.TabIndex = 1;
            this.fillTableLayoutClientes(ref this.tableLayoutPanel1, listaClientes);
            // 
            // CódigoLabel
            // 
            this.CódigoLabel.AutoSize = true;
            this.CódigoLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.CódigoLabel.Location = new System.Drawing.Point(7, 374);
            this.CódigoLabel.Name = "CódigoLabel";
            this.CódigoLabel.Size = new System.Drawing.Size(81, 27);
            this.CódigoLabel.TabIndex = 2;
            this.CódigoLabel.Text = "Código";
            // 
            // CódigoTextBox
            // 
            this.CódigoTextBox.Location = new System.Drawing.Point(89, 381);
            this.CódigoTextBox.Name = "CódigoTextBox";
            this.CódigoTextBox.Size = new System.Drawing.Size(176, 20);
            this.CódigoTextBox.TabIndex = 3;
            // 
            // MoradaLabel
            // 
            this.MoradaLabel.AutoSize = true;
            this.MoradaLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.MoradaLabel.Location = new System.Drawing.Point(271, 405);
            this.MoradaLabel.Name = "MoradaLabel";
            this.MoradaLabel.Size = new System.Drawing.Size(87, 27);
            this.MoradaLabel.TabIndex = 8;
            this.MoradaLabel.Text = "Morada";
            // 
            // MoradaTextBox
            // 
            this.MoradaTextBox.Location = new System.Drawing.Point(357, 409);
            this.MoradaTextBox.Name = "MoradaTextBox";
            this.MoradaTextBox.Size = new System.Drawing.Size(299, 20);
            this.MoradaTextBox.TabIndex = 9;
            // 
            // NomeLabel
            // 
            this.NomeLabel.AutoSize = true;
            this.NomeLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.NomeLabel.Location = new System.Drawing.Point(271, 374);
            this.NomeLabel.Name = "NomeLabel";
            this.NomeLabel.Size = new System.Drawing.Size(70, 27);
            this.NomeLabel.TabIndex = 4;
            this.NomeLabel.Text = "Nome";
            // 
            // NomeTextBox
            // 
            this.NomeTextBox.Location = new System.Drawing.Point(358, 381);
            this.NomeTextBox.Name = "NomeTextBox";
            this.NomeTextBox.Size = new System.Drawing.Size(299, 20);
            this.NomeTextBox.TabIndex = 5;
            // 
            // NumeroFiscalLabel
            // 
            this.NumeroFiscalLabel.AutoSize = true;
            this.NumeroFiscalLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.NumeroFiscalLabel.Location = new System.Drawing.Point(7, 405);
            this.NumeroFiscalLabel.Name = "NumeroFiscalLabel";
            this.NumeroFiscalLabel.Size = new System.Drawing.Size(146, 27);
            this.NumeroFiscalLabel.TabIndex = 6;
            this.NumeroFiscalLabel.Text = "NumeroFiscal";
            // 
            // NumeroFiscalTextBox
            // 
            this.NumeroFiscalTextBox.Location = new System.Drawing.Point(149, 407);
            this.NumeroFiscalTextBox.Name = "NumeroFiscalTextBox";
            this.NumeroFiscalTextBox.Size = new System.Drawing.Size(116, 20);
            this.NumeroFiscalTextBox.TabIndex = 7;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(11, 436);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(646, 45);
            this.button1.TabIndex = 10;
            this.button1.Text = "Alterar Cliente";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Clientes
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(669, 493);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.NumeroFiscalTextBox);
            this.Controls.Add(this.NumeroFiscalLabel);
            this.Controls.Add(this.NomeTextBox);
            this.Controls.Add(this.NomeLabel);
            this.Controls.Add(this.MoradaTextBox);
            this.Controls.Add(this.MoradaLabel);
            this.Controls.Add(this.CódigoTextBox);
            this.Controls.Add(this.CódigoLabel);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Name = "Clientes";
            this.Text = "Alterar Cliente";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

       

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Label CódigoLabel;
        private System.Windows.Forms.TextBox CódigoTextBox;
        private System.Windows.Forms.Label MoradaLabel;
        private System.Windows.Forms.TextBox MoradaTextBox;
        private System.Windows.Forms.Label NomeLabel;
        private System.Windows.Forms.TextBox NomeTextBox;
        private System.Windows.Forms.Label NumeroFiscalLabel;
        private System.Windows.Forms.TextBox NumeroFiscalTextBox;
        private System.Windows.Forms.Button button1;
    }
}