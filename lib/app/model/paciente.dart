import 'package:dia_vision/app/model/user.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

const kNome = "nome";
const kPeso = "peso";
const keyUser = 'user';
const kAltura = "altura";
const kTelefone = "telefone";
const kPacienteTable = "Paciente";
const kDataNascimento = "dataNascimento";

class Paciente extends ParseObject implements ParseCloneable {
  Paciente(
      {String nome,
      DateTime dataNascimento,
      String telefone,
      num peso,
      num altura,
      User user})
      : super(kPacienteTable) {
    this.nome = nome;
    this.telefone = telefone;
    this.dataNascimento = dataNascimento;
    this.peso = peso;
    this.altura = altura;
    this.user = user;
  }

  Paciente.clone() : this();

  @override
  Paciente clone(Map<String, dynamic> map) => Paciente.clone()..fromJson(map);

  @override
  Paciente fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  String get nome => get<String>(kNome);
  set nome(String nome) => set<String>(kNome, nome);

  DateTime get dataNascimento => get<DateTime>(kDataNascimento);
  set dataNascimento(DateTime dataNascimento) =>
      set<DateTime>(kDataNascimento, dataNascimento);

  String get telefone => get<String>(kTelefone);
  set telefone(String telefone) => set<String>(kTelefone, telefone);

  num get peso => get<num>(kPeso);
  set peso(num peso) => set<num>(kPeso, peso);

  num get altura => get<num>(kAltura);
  set altura(num altura) => set<num>(kAltura, altura);

  ParseUser get user => get<ParseUser>(keyUser);
  set user(ParseUser user) => set<ParseUser>(keyUser, user);
}
