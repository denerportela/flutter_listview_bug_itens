import 'dart:convert';
import 'itens_venda.dart';

class VendaModel extends Object {
  VendaModel(
      {this.vendaId, this.comanda, this.idCaixa, this.idEndereco, this.clienteId,
      this.statusEntrega, this.entregadorId, this.totalVenda, this.totalDesconto,
      this.observacoes, this.dtvenda, this.dtconclusao});

  int vendaId;
  int comanda;
  int idCaixa;
  int idEndereco;
  int clienteId;
  int statusEntrega;
  int entregadorId;
  double totalVenda;
  double totalDesconto;  
  String observacoes;
  DateTime dtvenda;
  DateTime dtconclusao;
  List<ItensVendaModel> listItensVenda;


  static fromJson(Map<String, dynamic> json) {
    final model = VendaModel();

    model.vendaId = json['vendaId'];
    model.comanda = json['comanda'];
    model.idCaixa = json['idCaixa'];
    model.idEndereco = json['idEndereco'];
    model.clienteId = json['clienteId'];
    model.statusEntrega = json['statusEntrega'];
    model.entregadorId = json['entregadorId'];

    model.totalVenda = json['totalVenda'];
    model.totalDesconto = json['totalDesconto'];



    model.observacoes = json['observacoes'];

    model.dtvenda = (json['dtvenda'] == null || json['dtvenda'] == '')
        ? null
        : DateTime.parse(json['dtvenda'] as String);
    model.dtconclusao = (json['dtconclusao'] == null || json['dtconclusao'] == '')
        ? null
        : DateTime.parse(json['dtconclusao'] as String);

    if (json['itensVenda'] != null) {
      model.listItensVenda = new List<ItensVendaModel>();
      json['itensVenda'].forEach((v) {
        model.listItensVenda.add(ItensVendaModel.fromJson(v));
      });
    }
    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['vendaId'] = this.vendaId;
    data['comanda'] = this.comanda;
    data['idCaixa'] = this.idCaixa;
    data['idEndereco'] = this.idEndereco;
    data['clienteId'] = this.clienteId;
    data['statusEntrega'] = this.statusEntrega;
    data['entregadorId'] = this.entregadorId;
    data['totalVenda'] = this.totalVenda;
    data['totalDesconto'] = this.totalDesconto;
    data['observacoes'] = this.observacoes;
    data['dtvenda'] = this.dtvenda?.toIso8601String();
    data['dtconclusao'] = this.dtconclusao?.toIso8601String();

    if (this.listItensVenda != null){
      
      final List<Map<String, dynamic>> listDataItens = List<Map<String, dynamic>>();
      for (var item in this.listItensVenda) {
        final Map<String, dynamic> dataItens = Map<String, dynamic>();
        dataItens['itensVendaId'] = item.itensVendaId;
      dataItens['vendaId'] = item.vendaId;
      dataItens['produtoId'] = item.produtoId;
      dataItens['item'] = item.item;
      dataItens['quantidade'] = item.quantidade;
      dataItens['valorUnitario'] = item.valorUnitario;
      dataItens['valorTotalItem'] = item.valorTotalItem;
      dataItens['desconto'] = item.desconto;
      dataItens['info'] = item.info;

    }
    data['itensVenda'] = listDataItens;
      
    }
    return data;
  }
}