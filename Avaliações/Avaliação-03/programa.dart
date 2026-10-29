import 'dart:collection';

class Aluno {
  final int id;
  final String nome;
  final int idade;

  const Aluno({required this.id, required this.nome, required this.idade});

  @override
  String toString() => 'ID: ${id.toString().padLeft(2, '0')} | Nome: ${nome.padRight(16)} | Idade: $idade';
}

class StudentRepository {
  final List<Aluno> _table = [];
  int _autoIncrement = 1;

  void createTable() {
    print('System: Initializing "tb_alunos" structure.');
  }

  void insert(String nome, int idade) {
    if (nome.isEmpty || idade < 0) {
      throw ArgumentError('Invalid student data: Name cannot be empty and age must be non-negative.');
    }
    _table.add(Aluno(id: _autoIncrement++, nome: nome, idade: idade));
  }

  UnmodifiableListView<Aluno> findAll() => UnmodifiableListView(_table);
}

void main() {
  final repository = StudentRepository();

  try {
    print('--- Initializing Student Management System ---');
    
    repository.createTable();

    final data = [
      ('Ana Silva', 20),
      ('Carlos Oliveira', 22),
      ('Beatriz Souza', 19),
    ];

    for (final record in data) {
      repository.insert(record.$1, record.$2);
    }
    print('Status: Successfully persisted ${data.length} records.');

    _displayStudents(repository);

  } on ArgumentError catch (e) {
    print('Validation Error: ${e.message}');
  } catch (e, stack) {
    print('Critical System Failure: $e');
    print(stack);
  } finally {
    print('--- Application cycle terminated ---');
  }
}

void _displayStudents(StudentRepository repository) {
  final students = repository.findAll();

  print('\n--- Current Student Records ---');
  if (students.isEmpty) {
    print('The repository is empty.');
  } else {
    students.forEach(print);
  }
  print('-------------------------------\n');
}
