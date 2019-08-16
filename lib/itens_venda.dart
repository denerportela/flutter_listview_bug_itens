import 'dart:convert';

class ItensVendaModel extends Object {
  ItensVendaModel(
      {this.itensVendaId, this.vendaId, this.produtoId, this.item, this.quantidade,
      this.valorUnitario, this.valorTotalItem, this.desconto, this.info});

  int itensVendaId;
  int vendaId;
  int produtoId;
  int item;
  double quantidade;
  double valorUnitario;  
  double valorTotalItem;
  double desconto;  
  String info;

  static fromJson(Map<String, dynamic> json) {
    final model = ItensVendaModel();

    model.itensVendaId = json['itensVendaId'];
    model.vendaId = json['vendaId'];
    model.produtoId = json['produtoId'];
    model.item = json['item'];
    

    model.quantidade = json['quantidade'];
    model.valorUnitario = json['valorUnitario'];
    model.valorTotalItem = json['valorTotalItem'];
    model.desconto = json['desconto'];

    model.info = json['info'];

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['itensVendaId'] = this.itensVendaId;
    data['vendaId'] = this.vendaId;
    data['produtoId'] = this.produtoId;
    data['item'] = this.item;
    data['quantidade'] = this.quantidade;
    data['valorUnitario'] = this.valorUnitario;
    data['valorTotalItem'] = this.valorTotalItem;
    data['desconto'] = this.desconto;
    data['info'] = this.info;

    return data;
  }
}