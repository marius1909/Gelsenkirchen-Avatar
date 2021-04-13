
/// Enthält alle im Spiel vorkommenden Hinweise für ein Suchspiel.
class SuchspielHinweis {
  int _hinweisAnzahl;
  int _derzeitigerHinweis;
  String _loesungsWort;
  List<String> _hinweise;

  int get hinweisAnzahl {
    return _hinweisAnzahl;
  }

  int get derzeitigerHinweis {
    return _derzeitigerHinweis;
  }

  SuchspielHinweis(String _loesungswort) {
    this._hinweisAnzahl = 0;
    this._derzeitigerHinweis = 0;
    this._loesungsWort = _loesungswort;
    this._hinweise = List();
  }

  void hinweisHinzufuegen(String hinweis) {
    _hinweise.add(hinweis);
    _hinweisAnzahl += 1;
  }

  bool istLoesungswort(String loesungswort) {
    return _loesungsWort.contains(loesungswort.toLowerCase());
  }

  int loesungsWortLaenge() {
    return _loesungsWort.length;
  }

  String naechsterHinweis() {
    if (_derzeitigerHinweis == _hinweisAnzahl) {
      return null;
    }
    String derzeitigeFrage = _hinweise[_derzeitigerHinweis];
    _derzeitigerHinweis += 1;
    return derzeitigeFrage;
  }

  static Map<String, SuchspielHinweis> get alleHinweise {
    Map<String, SuchspielHinweis> _alleHinweise = Map();

    SuchspielHinweis edelweissHinweis = SuchspielHinweis("edelweiß");
    edelweissHinweis.hinweisHinzufuegen(
        "Sie ist eine überwinternd grüne, ausdauernde krautige Pflanze, die Wuchshöhen von 5 bis über 20 Zentimetern erreicht.");
    edelweissHinweis.hinweisHinzufuegen(
        "Sie gilt in Deutschland als stark gefährdet, als Ursachen gelten in Deutschland v. a. das Betreten und Befahren der Standorte, früher vor allem das teils gewerbsmäßige Pflücken.");
    edelweissHinweis.hinweisHinzufuegen(
        "Entgegen weit verbreiteter Ansicht ist es keine Steilfels-Pflanze. Zwar besiedelt es auch Felsbänder, aber gemäß seiner ursprünglichen Herkunft aus hochgelegenen Steppengebieten kommt es weit eher in alpinen Rasen vor, insbesondere seit es dank größeren Naturschutzbewusstseins nicht mehr an allen leicht zugänglichen Stellen gepflückt wird.");
    edelweissHinweis.hinweisHinzufuegen(
        "Der blendend weiße Schimmer auf den Hochblättern entsteht dadurch, dass tausende kleine Luftbläschen an dem vielfach durcheinander gewirkten, krausen Haar das einfallende Licht reflektieren. Dies dient als Signal für nektarsuchende Insekten, als Verdunstungsschutz und als Schutz vor Wärmeverlust.");
    edelweissHinweis.hinweisHinzufuegen(
        "Der botanische Gattungsname Leontopodium leitet sich von den griechischen Wörtern leon für Löwe und podion für Füßchen ab, dies bezieht sich auf die charakteristische dichtfilzige, weiße Behaarung und der Form der Hochblätter. Das Artepitheton nivale bezieht sich auf die alpine Stufe (von lat. nivalis = schneeig).");
    edelweissHinweis.hinweisHinzufuegen(
        "Weitere Trivialnamen sind Wollblume, Bauchwehbleamerl, Irlweiß, Almsterndl, Federweiß, selten auch Silberstern und Wülblume (in der Schweiz). Auf romanisch [vierte schweizerische Landessprache, neben deutsch und italienisch im Kanton Graubünden gesprochen und geschrieben] heißt Leontopodium nivale «Alvetern» (alv = weiß, etern = ewig): das spiegelt die Besonderheit, dass die weißen Blütenstände bis in den Winter hinein überdauern.");
    _alleHinweise["edelweiß"] = edelweissHinweis;

    SuchspielHinweis rotbucheHinweis = SuchspielHinweis("rotbuche");
    rotbucheHinweis.hinweisHinzufuegen(
        "Während der letzten Kaltzeit wurde Sie aus Mitteleuropa verdrängt. Sie überlebte im Mittelmeerraum und begann ihre Rückeroberung des europäischen Verbreitungsgebietes vor etwa 10.000 Jahren.");
    rotbucheHinweis.hinweisHinzufuegen(
        "Die Blätter sind eiförmig, spitz bis zugespitzt oder bespitzt und sind am Grund keilförmig bis abgerundet, teils herzförmig oder schief. Sie sind zwischen 7 und 10 cm lang und bis zu 5 cm breit. Der Blattrand ist wellig bis ausgeschweift, teils leicht gekerbt, gezähnt oder gezähnelt und bewimpert.");
    rotbucheHinweis.hinweisHinzufuegen(
        "Mit einem Anteil von 15 % ist die sie der häufigste Laubbaum in den Wäldern Deutschlands.");
    rotbucheHinweis.hinweisHinzufuegen(
        "Da die EU ihre Verantwortung zum Schutz der Buchenwälder erkannt hat, wurden in der europäischen FFH-Richtlinie mehrere Lebensraumtypen unter Schutz gestellt, welche den Buchenwald enthalten.");
    rotbucheHinweis.hinweisHinzufuegen(
        "Der Namensteil „Rot“ bezieht sich auf die mitunter leicht rötliche Färbung des Holzes.");
    _alleHinweise["rotbuche"] = rotbucheHinweis;

    SuchspielHinweis korkeicheHinweis = SuchspielHinweis("korkeiche");
    korkeicheHinweis.hinweisHinzufuegen(
        "Sie ist einhäusig getrenntgeschlechtig (monözisch), es treten sowohl weibliche als auch männliche Blüten an einem Exemplar auf.");
    korkeicheHinweis.hinweisHinzufuegen(
        "Die ledrigen Blätter sind wechselständig und werden 3 bis 5 Zentimeter lang und 1,5 bis 4 Zentimeter breit. Die Form variiert zwischen rundlich, oval und lanzettförmig -oval.");
    korkeicheHinweis.hinweisHinzufuegen(
        "Charakteristisch sind die dicken, längsrissigen Korkschichten der graubraunen Stammborke. Das Kambium der bei jungen Bäumen glatten Rinde bildet sehr früh eine Korkschicht, die drei bis fünf Zentimeter dick werden kann. Das leichte und schwammige Korkgewebe zeigt senkrechte Risse und ist an der Außenseite weiß, an der Innenseite rot bis rotbraun. Nach der Ernte des Korkes erscheint der Stamm rotbraun, später jedoch deutlich dunkler.");
    korkeicheHinweis.hinweisHinzufuegen(
        "Sie wächst als immergrüner Baum, der eine durchschnittliche Wuchshöhe von 10 bis 20 Metern oder in seltenen Fällen bis 25 Meter und Stammdurchmesser (BHD) von 50 bis 90 Zentimeter erreicht. Er bildet eine dichte und asymmetrische, in einer Höhe von zwei bis drei Metern ansetzende Krone, die sich bei freistehenden Bäumen weit ausbreitet.");
    korkeicheHinweis.hinweisHinzufuegen(
        "Sie ist ein immergrüner Laubbaum des westlichen Mittelmeerraums aus der Gattung der Eichen (Quercus).");
    _alleHinweise["korkeiche"] = korkeicheHinweis;

    return _alleHinweise;
  }
}
