using System.Windows.Forms;

namespace ReservationApp.IntroduzirForms
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.NomeTipoLabel = new System.Windows.Forms.Label();
            this.NomeTipoTextBox = new System.Windows.Forms.TextBox();
            this.DescricaoLabel = new System.Windows.Forms.Label();
            this.DescricaoTextBox = new System.Windows.Forms.TextBox();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.button1 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // NomeTipoLabel
            // 
            this.NomeTipoLabel.AutoSize = true;
            this.NomeTipoLabel.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.NomeTipoLabel.Location = new System.Drawing.Point(6, 211);
            this.NomeTipoLabel.Name = "NomeTipoLabel";
            this.NomeTipoLabel.Size = new System.Drawing.Size(136, 31);
            this.NomeTipoLabel.TabIndex = 0;
            this.NomeTipoLabel.Text = "Nome Tipo";
            // 
            // NomeTipoTextBox
            // 
            this.NomeTipoTextBox.Location = new System.Drawing.Point(9, 245);
            this.NomeTipoTextBox.Name = "NomeTipoTextBox";
            this.NomeTipoTextBox.Size = new System.Drawing.Size(263, 20);
            this.NomeTipoTextBox.TabIndex = 1;
            // 
            // DescricaoLabel
            // 
            this.DescricaoLabel.AutoSize = true;
            this.DescricaoLabel.Font = new System.Drawing.Font("Times New Roman", 20F);
            this.DescricaoLabel.Location = new System.Drawing.Point(3, 268);
            this.DescricaoLabel.Name = "DescricaoLabel";
            this.DescricaoLabel.Size = new System.Drawing.Size(121, 31);
            this.DescricaoLabel.TabIndex = 2;
            this.DescricaoLabel.Text = "Descrição";
            // 
            // DescricaoTextBox
            // 
            this.DescricaoTextBox.Location = new System.Drawing.Point(9, 302);
            this.DescricaoTextBox.Name = "DescricaoTextBox";
            this.DescricaoTextBox.Size = new System.Drawing.Size(263, 20);
            this.DescricaoTextBox.TabIndex = 3;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.AutoScroll = true;
            this.tableLayoutPanel1.CellBorderStyle = System.Windows.Forms.TableLayoutPanelCellBorderStyle.Outset;
            this.tableLayoutPanel1.ColumnCount = 2;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 32F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 68F));
            this.tableLayoutPanel1.Location = new System.Drawing.Point(12, 12);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = this.listaTipos.Count;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(310, 196);
            this.tableLayoutPanel1.TabIndex = 0;
            this.fillTableLayoutTipos(ref this.tableLayoutPanel1, listaTipos);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(12, 328);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(310, 36);
            this.button1.TabIndex = 4;
            this.button1.Text = "Introduzir Equipamento";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Equipamentos
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(336, 376);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Controls.Add(this.DescricaoTextBox);
            this.Controls.Add(this.DescricaoLabel);
            this.Controls.Add(this.NomeTipoTextBox);
            this.Controls.Add(this.NomeTipoLabel);
            this.Name = "Equipamentos";
            this.Text = "Introduzir Equipamentos";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Label NomeTipoLabel;
        private System.Windows.Forms.TextBox NomeTipoTextBox;
        private System.Windows.Forms.Label DescricaoLabel;
        private System.Windows.Forms.TextBox DescricaoTextBox;
        private System.Windows.Forms.Button button1;
    }
}