using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ReservationApp
{
    public class ForForms : Form
    {
        private string toForm = "dd'/'MM'/'yy HH:mm";

        private void fillTable<T>(ref TableLayoutPanel tableLayoutPanel1, List<T> list,
            List<Func<T, string>> functions, List<string> headers)
        {
            tableLayoutPanel1.ColumnCount = headers.Count;
            int collumn = 0;
            foreach(string header in headers)
            {
                tableLayoutPanel1.Controls.Add(new Label() { Text = header }, collumn, 0);
                collumn++;
            }
            int line = 0;
            tableLayoutPanel1.RowCount = list.Count;
            foreach (T item in list)
            {
                collumn = 0;
                line++;
                foreach(Func<T,string> func in functions)
                {
                    tableLayoutPanel1.Controls.Add(new Label() { Text = func(item) }
                        , collumn, line);
                    collumn++;
                }
            }

        }


        public void fillTableLayoutClientes(ref TableLayoutPanel tableLayoutPanel1,
            List<Cliente> clientes)
        {
            List<Func<Cliente, string>> funcs = new List<Func<Cliente, string>>()
            {
                cliente=>cliente.Código+"",
                cliente=>(string.IsNullOrWhiteSpace(cliente.Nome)) ? "NULL" : cliente.Nome,
                cliente=>(string.IsNullOrWhiteSpace(cliente.NumeroFiscal + "")) ? "NULL" : cliente.NumeroFiscal + "",
                cliente=>(string.IsNullOrWhiteSpace(cliente.Morada)) ? "NULL" : cliente.Morada
            };

            List<string> headers = new List<string>()
            {
                "Código","Nome","Numero Fiscal","Morada"
            };

            fillTable<Cliente>(ref tableLayoutPanel1, clientes, funcs, headers);

        }

        public void fillTableLayoutDescontos(ref TableLayoutPanel tableLayoutPanel1, 
            List<Desconto> descontos)
        {
            List<Func<Desconto, string>> funcs = new List<Func<Desconto, string>>()
            {
                desconto => desconto.NumeroIdentificadorPromoção + "",
                desconto => desconto.Valor + "",
                desconto => desconto.Promoção.Inicio.ToString(toForm),
                desconto => desconto.Promoção.Fim.ToString(toForm),
                desconto => desconto.Promoção.Descrição
            };

            List<string> headers = new List<string>()
            {
                "Numero","Valor","Inicio","Fim","Descrição"
            };

            fillTable<Desconto>(ref tableLayoutPanel1, descontos, funcs, headers);
        }

        public void fillTableLayoutPanelEmpregados(ref TableLayoutPanel tableLayoutPanel1,
            List<Empregado> empregados)
        {
            List<Func<Empregado, string>> funcs = new List<Func<Empregado, string>>()
            {
                empregado => empregado.Numero + "",
                empregado => (string.IsNullOrWhiteSpace(empregado.Nome)) ? "NULL" : empregado.Nome,
            };

            List<string> headers = new List<string>()
            {
                "Numero","Nome"
            };

            fillTable<Empregado>(ref tableLayoutPanel1, empregados, funcs, headers);
        }
    
        public void fillTableLayoutEquipamento(ref TableLayoutPanel tableLayoutPanel1,
            List<Equipamento> equipamentos)
        {
           
            List<string> headers = new List<string>()
            {
                "Código","Nome do Tipo","Descrição"
            };

            List<Func<Equipamento, string>> funcs = new List<Func<Equipamento, string>>()
            {
                equipamento => equipamento.Código+"",
                equipamento => equipamento.NomeTipo,
                equipamento => equipamento.Descrição
            };

            fillTable<Equipamento>(ref tableLayoutPanel1, equipamentos, funcs, headers);
        }

        public void fillTableLayoutPanelPrecos(ref TableLayoutPanel tableLayoutPanel1,
            List<Preço> precos)
        {
            List<string> headers = new List<string>()
            {
                "NumeroSerie","Código","Tipo Duração","Valor","Inicio","Fim"
            };

            List<Func<Preço, string>> funcs = new List<Func<Preço, string>>()
            {
                preco => preco.NumeroSerie+"",
                preco => preco.CódigoEquipamento + "",
                preco => preco.TipoDuração,
                preco => preco.Valor + "",
                preco => preco.Inicio.ToString(toForm),
                preco => preco.Fim.ToString(toForm)
            };

            fillTable<Preço>(ref tableLayoutPanel1, precos, funcs, headers);
        }

        public void fillTableLayoutTipos(ref TableLayoutPanel tableLayoutPanel1,
            List<Tipo> tipos)
        {
            List<string> headers = new List<string>()
            {
                "Nome","Descrição"
            };

            List<Func<Tipo, string>> funcs = new List<Func<Tipo, string>>()
            {
                tipo => tipo.Nome,
                tipo => (string.IsNullOrWhiteSpace(tipo.Descrição)) ? "NULL" : tipo.Descrição
            };

            fillTable<Tipo>(ref tableLayoutPanel1, tipos, funcs, headers);
        }

        public void fillTableLayoutTempoExtras(ref TableLayoutPanel tableLayoutPanel1,
            List<TempoExtra> temposExtras)
        {
            List<string> headers = new List<string>()
            {
                "Numero","Frações","Periodo","Inicio","Fim","Descrição"
            };

            List<Func<TempoExtra, string>> funcs = new List<Func<TempoExtra, string>>()
            {
                tempoExtra => tempoExtra.NumeroIdentificadorPromoção + "",
                tempoExtra => tempoExtra.FracçãoExtra + "",
                tempoExtra => tempoExtra.TipoDuração,
                tempoExtra => tempoExtra.Promoção.Inicio.ToString(toForm),
                tempoExtra => tempoExtra.Promoção.Fim.ToString(toForm),
                tempoExtra => tempoExtra.Promoção.Descrição
            };

            fillTable<TempoExtra>(ref tableLayoutPanel1, temposExtras, funcs, headers);
        }

        public void fillTableLayoutAluguer(ref TableLayoutPanel tableLayoutPanel1,
           List<Aluguer> alugueres)
        {
            List<string> headers = new List<string>()
            {
                "Código","Cliente","Empregado","Periodo","Inicio","Fim","Preço"
            };

            List<Func<Aluguer, string>> funcs = new List<Func<Aluguer, string>>()
            {
                aluguer => aluguer.NumeroSerie + "",
                aluguer => aluguer.CódigoCliente + "",
                aluguer => aluguer.NumeroEmpregado + "",
                aluguer => aluguer.TipoDuração,
                aluguer => aluguer.Inicio.ToString(toForm),
                aluguer => aluguer.Fim.ToString(toForm),
                aluguer => aluguer.Preço+""
            };

            fillTable<Aluguer>(ref tableLayoutPanel1, alugueres, funcs, headers);
        }

        public DateTime formDate(string ano, string mes, string dia, string hora, string minuto)
        {
            try
            {
                DateTime dt = new DateTime(Int32.Parse(ano),
                    Int32.Parse(mes),
                    Int32.Parse(dia),
                    Int32.Parse(hora),
                    Int32.Parse(minuto),
                    0);
                return dt;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public Boolean checkDate(string ano, string mes, string dia, string hora, string minuto)
        {
            return string.IsNullOrWhiteSpace(ano)
                || string.IsNullOrWhiteSpace(mes) || string.IsNullOrWhiteSpace(dia)
                || string.IsNullOrWhiteSpace(hora) || string.IsNullOrWhiteSpace(minuto);
        }
    }
}
