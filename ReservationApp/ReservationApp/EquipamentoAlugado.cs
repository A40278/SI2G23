//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ReservationApp
{
    using System;
    using System.Collections.Generic;
    
    public partial class EquipamentoAlugado
    {
        public int NumeroSerieAluguer { get; set; }
        public int CódigoEquipamento { get; set; }
        public Nullable<decimal> PreçoOriginal { get; set; }
        public Nullable<decimal> Desconto { get; set; }
        public Nullable<decimal> PreçoFinal { get; set; }
    
        public virtual Aluguer Aluguer { get; set; }
        public virtual Equipamento Equipamento { get; set; }
    }
}
