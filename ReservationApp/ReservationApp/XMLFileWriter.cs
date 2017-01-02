using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Schema;
using System.Xml.Linq;
using System.Windows.Forms;

namespace ReservationApp
{
    public class XMLFileWriter
    {
        public void WriteFile(List<Aluguer> alugueres, DateTime inicio, DateTime fim)
        {
            XNamespace xsi = "http://www.w3.org/2001/XMLSchema-instance";
            XDocument doc = new XDocument(new XDeclaration("1.0", "utf-16", "yes"));
            List<XElement> alugueresItems = new List<XElement>();

            foreach(Aluguer aluguer in alugueres)
            {
                Nullable<int> cliente = aluguer.CódigoCliente;
                Nullable<int> id = aluguer.NumeroSerie;
                string tipo = aluguer.TipoDuração;
                foreach(EquipamentoAlugado equipamento in aluguer.EquipamentoAlugadoes)
                {
                    alugueresItems.Add(new XElement("aluguer", new XElement("cliente", cliente),
                    new XElement("equipamento", equipamento.CódigoEquipamento), 
                    new XAttribute("id", id), new XAttribute("tipo", tipo)));
                }
                
            }

            XElement alugueresXml = new XElement("alugueres", 
                new XAttribute("dataInicio", inicio.ToString("dd'/'MM'/'yy")),
                new XAttribute("dataFim", fim.ToString("dd'/'MM'/'yy")),alugueresItems);

            XElement xml = new XElement("xml", new XAttribute(XNamespace.Xmlns + "xsi", xsi),
                new XAttribute(xsi + "noNamespaceSchemaLocation", "schema.xsd"), alugueresXml);

            doc.Add(xml);

            doc.Save(inicio.ToString("dd'-'MM'-'yy")+" "+ fim.ToString("dd'-'MM'-'yy") + ".xml");

        }
        

    }
}
