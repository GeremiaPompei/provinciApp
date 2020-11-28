import 'package:provinciApp/model/pacchetto.dart';

/// Classe contenente le costanti utili per la ricerca dei dati tramite
/// richieste http rest.
class CostantiWeb {
  /// Url principale per la ricerca dei dati della provincia di macerata.
  static const urlProvincia = 'http://dati.provincia.mc.it/api/3/action/';

  /// Url per la ricerca di tutti i pacchetti che hanno una certa parola che
  /// verrà concatenata a tale stringa.
  static const urlProvinciaSearch =
      urlProvincia + 'package_search?rows=1000&q=';

  /// Url per la ricerca della lista dei comuni.
  static const urlProvinciaComuniList = urlProvincia + 'organization_list';

  /// Url per la ricerca di un comune con un certo id.
  static const urlProvinciaComuniShow = urlProvincia + 'organization_show?id=';

  /// Url per la ricerca della lista delle categorie.
  static const urlProvinciaCategorieList = urlProvincia + 'group_list';

  /// Url per la ricerca di una categoria con un certo id.
  static const urlProvinciaCategorieShow = urlProvincia + 'group_show?id=';

  /// Url Extra
  static final urlExtra =
      'https://raw.githubusercontent.com/GeremiaPompei/provinciApp/master/assets/extra.json';
}
