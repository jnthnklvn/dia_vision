import 'package:parse_server_sdk/parse_server_sdk.dart';

const kLinkGooglePlay = "linkGooglePlay";
const kLinkAppleStore = "linkAppleStore";
const kDescricao = "descricao";
const kTitulo = "titulo";

const kAppVisaoTable = "AppVisao";

class AppVisao extends ParseObject implements ParseCloneable {
  AppVisao({
    String? descricao,
    String? linkGooglePlay,
    String? linkAppleStore,
    String? titulo,
  }) : super(kAppVisaoTable) {
    this.descricao = descricao;
    this.linkAppleStore = linkAppleStore;
    this.linkGooglePlay = linkGooglePlay;
    this.titulo = titulo;
  }

  AppVisao.clone() : this();

  @override
  AppVisao clone(Map<String, dynamic> map) => AppVisao.clone()..fromJson(map);

  @override
  AppVisao fromJson(Map<String, dynamic> objectData) {
    super.fromJson(objectData);
    return this;
  }

  String? get linkGooglePlay => get<String?>(kLinkGooglePlay);
  set linkGooglePlay(String? linkGooglePlay) =>
      set<String?>(kLinkGooglePlay, linkGooglePlay);

  String? get linkAppleStore => get<String?>(kLinkAppleStore);
  set linkAppleStore(String? linkAppleStore) =>
      set<String?>(kLinkAppleStore, linkAppleStore);

  String? get descricao => get<String?>(kDescricao);
  set descricao(String? descricao) => set<String?>(kDescricao, descricao);

  String? get titulo => get<String?>(kTitulo);
  set titulo(String? titulo) => set<String?>(kTitulo, titulo);
}
