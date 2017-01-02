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
    
    public partial class Aluguer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Aluguer()
        {
            this.EquipamentoAlugadoes = new HashSet<EquipamentoAlugado>();
        }
    
        public int NumeroSerie { get; set; }
        public Nullable<int> CódigoCliente { get; set; }
        public Nullable<int> NumeroEmpregado { get; set; }
        public string TipoDuração { get; set; }
        public System.DateTime Inicio { get; set; }
        public System.DateTime Fim { get; set; }
        public Nullable<System.DateTime> FimComExtra { get; set; }
        public Nullable<decimal> Preço { get; set; }
    
        public virtual Cliente Cliente { get; set; }
        public virtual Empregado Empregado { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<EquipamentoAlugado> EquipamentoAlugadoes { get; set; }
    }
}