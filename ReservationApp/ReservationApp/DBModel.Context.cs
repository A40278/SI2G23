﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class DBModel : DbContext
    {
        public DBModel()
            : base("name=DBModel")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Aluguer> Aluguers { get; set; }
        public virtual DbSet<Cliente> Clientes { get; set; }
        public virtual DbSet<Desconto> Descontoes { get; set; }
        public virtual DbSet<Empregado> Empregadoes { get; set; }
        public virtual DbSet<Equipamento> Equipamentoes { get; set; }
        public virtual DbSet<EquipamentoAlugado> EquipamentoAlugadoes { get; set; }
        public virtual DbSet<Preço> Preço { get; set; }
        public virtual DbSet<Promoção> Promoção { get; set; }
        public virtual DbSet<TempoExtra> TempoExtras { get; set; }
        public virtual DbSet<Tipo> Tipoes { get; set; }
    
        public virtual int Alterar_Desconto(string descrição, Nullable<System.DateTime> inicio, Nullable<System.DateTime> fim, Nullable<decimal> valor, Nullable<int> numero)
        {
            var descriçãoParameter = descrição != null ?
                new ObjectParameter("descrição", descrição) :
                new ObjectParameter("descrição", typeof(string));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            var valorParameter = valor.HasValue ?
                new ObjectParameter("valor", valor) :
                new ObjectParameter("valor", typeof(decimal));
    
            var numeroParameter = numero.HasValue ?
                new ObjectParameter("numero", numero) :
                new ObjectParameter("numero", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Alterar_Desconto", descriçãoParameter, inicioParameter, fimParameter, valorParameter, numeroParameter);
        }
    
        public virtual int Alterar_TempoExtra(string descrição, Nullable<System.DateTime> inicio, Nullable<System.DateTime> fim, Nullable<int> extra, string tipoDuracao, Nullable<int> numero)
        {
            var descriçãoParameter = descrição != null ?
                new ObjectParameter("descrição", descrição) :
                new ObjectParameter("descrição", typeof(string));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            var extraParameter = extra.HasValue ?
                new ObjectParameter("extra", extra) :
                new ObjectParameter("extra", typeof(int));
    
            var tipoDuracaoParameter = tipoDuracao != null ?
                new ObjectParameter("tipoDuracao", tipoDuracao) :
                new ObjectParameter("tipoDuracao", typeof(string));
    
            var numeroParameter = numero.HasValue ?
                new ObjectParameter("numero", numero) :
                new ObjectParameter("numero", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Alterar_TempoExtra", descriçãoParameter, inicioParameter, fimParameter, extraParameter, tipoDuracaoParameter, numeroParameter);
        }
    
        public virtual ObjectResult<AlugueresDatas_Result> AlugueresDatas(Nullable<System.DateTime> inicioPeriodo, Nullable<System.DateTime> fimPeriodo)
        {
            var inicioPeriodoParameter = inicioPeriodo.HasValue ?
                new ObjectParameter("inicioPeriodo", inicioPeriodo) :
                new ObjectParameter("inicioPeriodo", typeof(System.DateTime));
    
            var fimPeriodoParameter = fimPeriodo.HasValue ?
                new ObjectParameter("fimPeriodo", fimPeriodo) :
                new ObjectParameter("fimPeriodo", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<AlugueresDatas_Result>("AlugueresDatas", inicioPeriodoParameter, fimPeriodoParameter);
        }
    
        public virtual int Calcular_Preço_De_Aluguer(Nullable<int> códigoEquipamento, string tipoDuração, Nullable<System.DateTime> inicio, Nullable<System.DateTime> fim, ObjectParameter preço, ObjectParameter desconto, ObjectParameter preçoAluguer)
        {
            var códigoEquipamentoParameter = códigoEquipamento.HasValue ?
                new ObjectParameter("códigoEquipamento", códigoEquipamento) :
                new ObjectParameter("códigoEquipamento", typeof(int));
    
            var tipoDuraçãoParameter = tipoDuração != null ?
                new ObjectParameter("tipoDuração", tipoDuração) :
                new ObjectParameter("tipoDuração", typeof(string));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Calcular_Preço_De_Aluguer", códigoEquipamentoParameter, tipoDuraçãoParameter, inicioParameter, fimParameter, preço, desconto, preçoAluguer);
        }
    
        public virtual int Calcular_Preço_De_Aluguer_Sem_Desconto(Nullable<int> códigoEquipamento, string tipoDuração, Nullable<System.DateTime> inicio, Nullable<System.DateTime> fim, Nullable<decimal> desconto, ObjectParameter preço, ObjectParameter preçoAluguer)
        {
            var códigoEquipamentoParameter = códigoEquipamento.HasValue ?
                new ObjectParameter("códigoEquipamento", códigoEquipamento) :
                new ObjectParameter("códigoEquipamento", typeof(int));
    
            var tipoDuraçãoParameter = tipoDuração != null ?
                new ObjectParameter("tipoDuração", tipoDuração) :
                new ObjectParameter("tipoDuração", typeof(string));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            var descontoParameter = desconto.HasValue ?
                new ObjectParameter("desconto", desconto) :
                new ObjectParameter("desconto", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Calcular_Preço_De_Aluguer_Sem_Desconto", códigoEquipamentoParameter, tipoDuraçãoParameter, inicioParameter, fimParameter, descontoParameter, preço, preçoAluguer);
        }
    
        public virtual int Equipamento_Alugado_Desconto(Nullable<int> codigo, Nullable<System.DateTime> inicio, ObjectParameter decontoTotal)
        {
            var codigoParameter = codigo.HasValue ?
                new ObjectParameter("codigo", codigo) :
                new ObjectParameter("codigo", typeof(int));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Equipamento_Alugado_Desconto", codigoParameter, inicioParameter, decontoTotal);
        }
    
        public virtual int Equipamento_Alugado_Preço(Nullable<int> codigo, string tipoDuração, Nullable<System.DateTime> inicio, Nullable<System.DateTime> fim, ObjectParameter preço)
        {
            var codigoParameter = codigo.HasValue ?
                new ObjectParameter("codigo", codigo) :
                new ObjectParameter("codigo", typeof(int));
    
            var tipoDuraçãoParameter = tipoDuração != null ?
                new ObjectParameter("tipoDuração", tipoDuração) :
                new ObjectParameter("tipoDuração", typeof(string));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Equipamento_Alugado_Preço", codigoParameter, tipoDuraçãoParameter, inicioParameter, fimParameter, preço);
        }
    
        public virtual int Factor_Tipo_Duração(string tipoDuração, ObjectParameter factor)
        {
            var tipoDuraçãoParameter = tipoDuração != null ?
                new ObjectParameter("tipoDuração", tipoDuração) :
                new ObjectParameter("tipoDuração", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Factor_Tipo_Duração", tipoDuraçãoParameter, factor);
        }
    
        public virtual int Fracoes_Tempo_Extra(Nullable<System.DateTime> fim, Nullable<System.DateTime> inicio, string tipoDuração)
        {
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var tipoDuraçãoParameter = tipoDuração != null ?
                new ObjectParameter("tipoDuração", tipoDuração) :
                new ObjectParameter("tipoDuração", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Fracoes_Tempo_Extra", fimParameter, inicioParameter, tipoDuraçãoParameter);
        }
    
        public virtual int Inserir_Aluguer_e_Cliente(string tipoDuração, Nullable<System.DateTime> inicio, Nullable<System.DateTime> fim, Nullable<int> numeroEmpregado, string nome, Nullable<int> numeroFiscal, string morada)
        {
            var tipoDuraçãoParameter = tipoDuração != null ?
                new ObjectParameter("tipoDuração", tipoDuração) :
                new ObjectParameter("tipoDuração", typeof(string));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            var numeroEmpregadoParameter = numeroEmpregado.HasValue ?
                new ObjectParameter("numeroEmpregado", numeroEmpregado) :
                new ObjectParameter("numeroEmpregado", typeof(int));
    
            var nomeParameter = nome != null ?
                new ObjectParameter("nome", nome) :
                new ObjectParameter("nome", typeof(string));
    
            var numeroFiscalParameter = numeroFiscal.HasValue ?
                new ObjectParameter("numeroFiscal", numeroFiscal) :
                new ObjectParameter("numeroFiscal", typeof(int));
    
            var moradaParameter = morada != null ?
                new ObjectParameter("morada", morada) :
                new ObjectParameter("morada", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Inserir_Aluguer_e_Cliente", tipoDuraçãoParameter, inicioParameter, fimParameter, numeroEmpregadoParameter, nomeParameter, numeroFiscalParameter, moradaParameter);
        }
    
        public virtual int Inserir_Desconto(string descrição, Nullable<System.DateTime> inicio, Nullable<System.DateTime> fim, Nullable<decimal> valor)
        {
            var descriçãoParameter = descrição != null ?
                new ObjectParameter("descrição", descrição) :
                new ObjectParameter("descrição", typeof(string));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            var valorParameter = valor.HasValue ?
                new ObjectParameter("valor", valor) :
                new ObjectParameter("valor", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Inserir_Desconto", descriçãoParameter, inicioParameter, fimParameter, valorParameter);
        }
    
        public virtual int Inserir_Desconto_Com_Tipo(string descrição, Nullable<System.DateTime> inicio, Nullable<System.DateTime> fim, Nullable<decimal> valor, string nomeTipo)
        {
            var descriçãoParameter = descrição != null ?
                new ObjectParameter("descrição", descrição) :
                new ObjectParameter("descrição", typeof(string));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            var valorParameter = valor.HasValue ?
                new ObjectParameter("valor", valor) :
                new ObjectParameter("valor", typeof(decimal));
    
            var nomeTipoParameter = nomeTipo != null ?
                new ObjectParameter("nomeTipo", nomeTipo) :
                new ObjectParameter("nomeTipo", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Inserir_Desconto_Com_Tipo", descriçãoParameter, inicioParameter, fimParameter, valorParameter, nomeTipoParameter);
        }
    
        public virtual int Inserir_TempoExtra(string descrição, Nullable<System.DateTime> inicio, Nullable<System.DateTime> fim, Nullable<int> fracçãoExtra, string tipoDuração)
        {
            var descriçãoParameter = descrição != null ?
                new ObjectParameter("descrição", descrição) :
                new ObjectParameter("descrição", typeof(string));
    
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            var fracçãoExtraParameter = fracçãoExtra.HasValue ?
                new ObjectParameter("fracçãoExtra", fracçãoExtra) :
                new ObjectParameter("fracçãoExtra", typeof(int));
    
            var tipoDuraçãoParameter = tipoDuração != null ?
                new ObjectParameter("tipoDuração", tipoDuração) :
                new ObjectParameter("tipoDuração", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Inserir_TempoExtra", descriçãoParameter, inicioParameter, fimParameter, fracçãoExtraParameter, tipoDuraçãoParameter);
        }
    
        public virtual ObjectResult<Listar_Equipamentos_Disponiveis_Aluguer_Result> Listar_Equipamentos_Disponiveis_Aluguer(Nullable<int> num)
        {
            var numParameter = num.HasValue ?
                new ObjectParameter("num", num) :
                new ObjectParameter("num", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Listar_Equipamentos_Disponiveis_Aluguer_Result>("Listar_Equipamentos_Disponiveis_Aluguer", numParameter);
        }
    
        public virtual ObjectResult<Listar_Equipamentos_Disponiveis_Periodo_Tipo_Result> Listar_Equipamentos_Disponiveis_Periodo_Tipo(Nullable<System.DateTime> inicioPeriodo, Nullable<System.DateTime> fimPeriodo, string tipo)
        {
            var inicioPeriodoParameter = inicioPeriodo.HasValue ?
                new ObjectParameter("inicioPeriodo", inicioPeriodo) :
                new ObjectParameter("inicioPeriodo", typeof(System.DateTime));
    
            var fimPeriodoParameter = fimPeriodo.HasValue ?
                new ObjectParameter("fimPeriodo", fimPeriodo) :
                new ObjectParameter("fimPeriodo", typeof(System.DateTime));
    
            var tipoParameter = tipo != null ?
                new ObjectParameter("tipo", tipo) :
                new ObjectParameter("tipo", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Listar_Equipamentos_Disponiveis_Periodo_Tipo_Result>("Listar_Equipamentos_Disponiveis_Periodo_Tipo", inicioPeriodoParameter, fimPeriodoParameter, tipoParameter);
        }
    
        public virtual ObjectResult<Listar_Equipamentos_Disponiveis_Ultima_Semana_Result> Listar_Equipamentos_Disponiveis_Ultima_Semana()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Listar_Equipamentos_Disponiveis_Ultima_Semana_Result>("Listar_Equipamentos_Disponiveis_Ultima_Semana");
        }
    
        public virtual int Numero_de_Preços_No_Periodo(Nullable<System.DateTime> inicio, Nullable<System.DateTime> fim, string tipoDuração, Nullable<int> codigo)
        {
            var inicioParameter = inicio.HasValue ?
                new ObjectParameter("inicio", inicio) :
                new ObjectParameter("inicio", typeof(System.DateTime));
    
            var fimParameter = fim.HasValue ?
                new ObjectParameter("fim", fim) :
                new ObjectParameter("fim", typeof(System.DateTime));
    
            var tipoDuraçãoParameter = tipoDuração != null ?
                new ObjectParameter("tipoDuração", tipoDuração) :
                new ObjectParameter("tipoDuração", typeof(string));
    
            var codigoParameter = codigo.HasValue ?
                new ObjectParameter("codigo", codigo) :
                new ObjectParameter("codigo", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Numero_de_Preços_No_Periodo", inicioParameter, fimParameter, tipoDuraçãoParameter, codigoParameter);
        }
    
        public virtual ObjectResult<Obter_Aluguers_Datas_Result> Obter_Aluguers_Datas(Nullable<System.DateTime> inicioPeriodo, Nullable<System.DateTime> fimPeriodo)
        {
            var inicioPeriodoParameter = inicioPeriodo.HasValue ?
                new ObjectParameter("inicioPeriodo", inicioPeriodo) :
                new ObjectParameter("inicioPeriodo", typeof(System.DateTime));
    
            var fimPeriodoParameter = fimPeriodo.HasValue ?
                new ObjectParameter("fimPeriodo", fimPeriodo) :
                new ObjectParameter("fimPeriodo", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Obter_Aluguers_Datas_Result>("Obter_Aluguers_Datas", inicioPeriodoParameter, fimPeriodoParameter);
        }
    
        public virtual int Verificar_Equipamento_Alugado_No_Periodo(Nullable<System.DateTime> inicioPeriodo, Nullable<System.DateTime> fimPeriodo, Nullable<int> codigo)
        {
            var inicioPeriodoParameter = inicioPeriodo.HasValue ?
                new ObjectParameter("inicioPeriodo", inicioPeriodo) :
                new ObjectParameter("inicioPeriodo", typeof(System.DateTime));
    
            var fimPeriodoParameter = fimPeriodo.HasValue ?
                new ObjectParameter("fimPeriodo", fimPeriodo) :
                new ObjectParameter("fimPeriodo", typeof(System.DateTime));
    
            var codigoParameter = codigo.HasValue ?
                new ObjectParameter("codigo", codigo) :
                new ObjectParameter("codigo", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Verificar_Equipamento_Alugado_No_Periodo", inicioPeriodoParameter, fimPeriodoParameter, codigoParameter);
        }
    
        public virtual ObjectResult<Equipamento> Listar_Equipamentos_Disponiveis_Periodo_Tipo1(Nullable<System.DateTime> inicioPeriodo, Nullable<System.DateTime> fimPeriodo, string tipo)
        {
            var inicioPeriodoParameter = inicioPeriodo.HasValue ?
                new ObjectParameter("inicioPeriodo", inicioPeriodo) :
                new ObjectParameter("inicioPeriodo", typeof(System.DateTime));
    
            var fimPeriodoParameter = fimPeriodo.HasValue ?
                new ObjectParameter("fimPeriodo", fimPeriodo) :
                new ObjectParameter("fimPeriodo", typeof(System.DateTime));
    
            var tipoParameter = tipo != null ?
                new ObjectParameter("tipo", tipo) :
                new ObjectParameter("tipo", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Equipamento>("Listar_Equipamentos_Disponiveis_Periodo_Tipo1", inicioPeriodoParameter, fimPeriodoParameter, tipoParameter);
        }
    
        public virtual ObjectResult<Equipamento> Listar_Equipamentos_Disponiveis_Periodo_Tipo1(Nullable<System.DateTime> inicioPeriodo, Nullable<System.DateTime> fimPeriodo, string tipo, MergeOption mergeOption)
        {
            var inicioPeriodoParameter = inicioPeriodo.HasValue ?
                new ObjectParameter("inicioPeriodo", inicioPeriodo) :
                new ObjectParameter("inicioPeriodo", typeof(System.DateTime));
    
            var fimPeriodoParameter = fimPeriodo.HasValue ?
                new ObjectParameter("fimPeriodo", fimPeriodo) :
                new ObjectParameter("fimPeriodo", typeof(System.DateTime));
    
            var tipoParameter = tipo != null ?
                new ObjectParameter("tipo", tipo) :
                new ObjectParameter("tipo", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Equipamento>("Listar_Equipamentos_Disponiveis_Periodo_Tipo1", mergeOption, inicioPeriodoParameter, fimPeriodoParameter, tipoParameter);
        }
    
        public virtual ObjectResult<Equipamento> Listar_Equipamentos_Disponiveis_Aluguer1(Nullable<int> num)
        {
            var numParameter = num.HasValue ?
                new ObjectParameter("num", num) :
                new ObjectParameter("num", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Equipamento>("Listar_Equipamentos_Disponiveis_Aluguer1", numParameter);
        }
    
        public virtual ObjectResult<Equipamento> Listar_Equipamentos_Disponiveis_Aluguer1(Nullable<int> num, MergeOption mergeOption)
        {
            var numParameter = num.HasValue ?
                new ObjectParameter("num", num) :
                new ObjectParameter("num", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Equipamento>("Listar_Equipamentos_Disponiveis_Aluguer1", mergeOption, numParameter);
        }
    
        public virtual ObjectResult<Equipamento> Listar_Equipamentos_Disponiveis_Ultima_Semana1()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Equipamento>("Listar_Equipamentos_Disponiveis_Ultima_Semana1");
        }
    
        public virtual ObjectResult<Equipamento> Listar_Equipamentos_Disponiveis_Ultima_Semana1(MergeOption mergeOption)
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Equipamento>("Listar_Equipamentos_Disponiveis_Ultima_Semana1", mergeOption);
        }
    }
}