using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.AcederForms
{
    public class AcederForm : Form
    {
        public Nullable<int> choice;
        public CheckedListBox checkedListBox1;

        public void checkedListBox1_ItemCheck(object sender, ItemCheckEventArgs e)
        {
            for (int ix = 0; ix < checkedListBox1.Items.Count; ++ix)
                if (ix != e.Index) checkedListBox1.SetItemChecked(ix, false);
        }

        public void button1_Click(object sender, EventArgs e)
        {
            try
            {
                this.choice = checkedListBox1.CheckedIndices[0];
            }
            catch (System.IndexOutOfRangeException) { }
            this.Dispose();

        }
    }
}
