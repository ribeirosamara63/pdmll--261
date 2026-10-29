import 'dart:convert';

// 14-agregacao.dart  
// Agregação e Composição

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  String get nome => _nome;
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  String get nome => _nome;
  List<Dependente> get dependentes => _dependentes;
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  String get nomeProjeto => _nomeProjeto;
  List<Funcionario> get funcionarios => _funcionarios;
}

void main() {
  Dependente dep1 = Dependente('Davi');
  Dependente dep2 = Dependente('Sabrina');
  Dependente dep3 = Dependente('Márcia');

  Funcionario func1 = Funcionario('Carlos', [dep1, dep2]);
  Funcionario func2 = Funcionario('Mariana', [dep3]);
  Funcionario func3 = Funcionario('Roberto', []);

  List<Funcionario> listaFuncionarios = [func1, func2, func3];

  EquipeProjeto equipe = EquipeProjeto('Sistema E-commerce', listaFuncionarios);

 
  Map<String, dynamic> equipeMap = {
    'nomeProjeto': equipe.nomeProjeto,
    'funcionarios': equipe.funcionarios.map((func) => {
      'nome': func.nome,
      'dependentes': func.dependentes.map((dep) => {
        'nome': dep.nome
      }).toList()
    }).toList()
  };

  String jsonString = jsonEncode(equipeMap);
  print(jsonString);
}
