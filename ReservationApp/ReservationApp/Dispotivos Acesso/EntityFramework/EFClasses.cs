using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp.Dispotivos_Acesso.EntityFramework
{
    public partial class EntityFramework
    {
        public List<T> obterLista<T>(Func<DBModel, List<T>> func)
        {
            using(DBModel dbm = new DBModel())
            {
                return func(dbm);
            }
        }


        public void alterarElemento(Action<DBModel> addAction)
        {
            using (DBModel dbm = new DBModel())
            {
                addAction(dbm);
                try
                {
                    dbm.SaveChanges();
                }
                catch (DbUpdateException e)
                {
                    MessageBox.Show(e.Message);
                }
            }
        }
    }
}
