import 'package:parse_server_sdk/parse_server_sdk.dart';

const kCidade = "cidade";
const kBairro = "bairro";
const kEstado = "estado";
const kNumero = "numero";
const kCep = "cep";
const kRua = "rua";
const kEnderecoTable = "Endereco";

class Endereco extends ParseObject implements ParseCloneable {
  Endereco(
      {String cidade,
      String rua,
      String cep,
      String bairro,
      num numero,
      String estado})
      : super(kEnderecoTable) {
    this.cidade = cidade;
    this.bairro = bairro;
    this.numero = numero;
    this.estado = estado;
    this.rua = rua;
    this.cep = cep;
  }

  Endereco.clone() : this();

  @override
  Endereco clone(Map<String, dynamic> map) => Endereco.clone()..fromJson(map);

  @override
  Endereco fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  set createdAt(DateTime data) => set<DateTime>("createdAt", data);

  String get cep => get<String>(kCep);
  set cep(String cep) => set<String>(kCep, cep);

  String get cidade => get<String>(kCidade);
  set cidade(String cidade) => set<String>(kCidade, cidade);

  num get numero => get<num>(kNumero);
  set numero(num numero) => set<num>(kNumero, numero);

  String get estado => get<String>(kEstado);
  set estado(String estado) => set<String>(kEstado, estado);

  String get bairro => get<String>(kBairro);
  set bairro(String bairro) => set<String>(kBairro, bairro);

  String get rua => get<String>(kRua);
  set rua(String rua) => set<String>(kRua, rua);
}
