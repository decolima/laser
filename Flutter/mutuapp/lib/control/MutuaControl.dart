import '../entity/Status.dart';
import '../entity/mutua.dart';

class MutuaControl {
  static final mutua = <Mutua>[];
  static int? indexN;
  static int? indexP;

  static Mutua creaMutua(
      String reason, DateTime start, DateTime end, String protocolNumber) {
    Mutua m = Mutua.create();
    m = m.copyWith(
        reason: reason, start: start, end: end, protocolNumber: protocolNumber);
    return m;
  }

  static bool addMutua(Mutua m) {
    if (m.status != Status.CLOSED) {
      if (mutua.where((e) => e.status == m.status).isEmpty) {
        mutua.add(m);
        return true;
      } else {
        return false;
      }
    } else {
      mutua.add(m);
      return true;
    }
  }

  static Mutua aggMutua(Mutua m, Status st) {
    m = m.copyWith(status: st);
    return m;
  }

  static List<Mutua> getMutua() {
    return mutua;
  }

  static List<Mutua> getMutuaFiltred(Status st) {
    return mutua.where((e) => e.status.name == st.name).toList();
  }

  static clearMutua() {
    mutua.clear();
  }

  static Mutua getMutuaStatus(Status st) {
    return getMutuaFiltred(st)[0];
  }
}
