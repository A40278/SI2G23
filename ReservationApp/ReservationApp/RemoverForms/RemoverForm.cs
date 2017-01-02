using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.RemoverForms
{
    public class RemoverForm : ForForms
    {
        public Nullable<int> numero;

        public TableLayoutPanel tableLayoutPanel1;
        public Label Label;
        public TextBox TextBox;
        public Button button1;

        public void InitializeComponent()
        {
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.button1 = new System.Windows.Forms.Button();
            this.Label = new System.Windows.Forms.Label();
            this.TextBox = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.AutoScroll = true;
            this.tableLayoutPanel1.CellBorderStyle = System.Windows.Forms.TableLayoutPanelCellBorderStyle.Outset;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(12, 12);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.Size = new System.Drawing.Size(673, 380);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(12, 422);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(673, 63);
            this.button1.TabIndex = 1;
            this.button1.Text = "Continuar";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // Label
            // 
            this.Label.AutoSize = true;
            this.Label.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.Label.Location = new System.Drawing.Point(12, 395);
            this.Label.Name = "Label";
            this.Label.Size = new System.Drawing.Size(144, 27);
            this.Label.TabIndex = 2;
            this.Label.Text = "Numero Serie";
            // 
            // TextBox
            // 
            this.TextBox.Location = new System.Drawing.Point(162, 398);
            this.TextBox.Name = "TextBox";
            this.TextBox.Size = new System.Drawing.Size(137, 20);
            this.TextBox.TabIndex = 3;
            // 
            // RemoverForm
            // 
            this.ClientSize = new System.Drawing.Size(697, 497);
            this.Controls.Add(this.TextBox);
            this.Controls.Add(this.Label);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Name = "RemoverForm";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        public void button1_Click(object sender, EventArgs e)
        {
            try
            {
                numero = (string.IsNullOrWhiteSpace(this.TextBox.Text)) ?
                    null : (Nullable<int>)Int32.Parse(this.TextBox.Text);
            }
            catch (Exception ex)
            {
                numero = null;
                MessageBox.Show(ex.Message);
            }
            this.Dispose();
        }
    }
}
