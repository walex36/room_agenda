import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:room_agenda/src/core/core.dart';
import 'package:room_agenda/src/features/company/company.dart';

class CompanyFirebaseDatasource implements ImpCompanyRemoteDatasource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<List<CompanyModel>> getCompanies({required List<String> cnpjs}) async {
    const textError = 'Erro ao buscar empresas';

    try {
      final doc = await _db
          .collection(FirestoreConst.company())
          .where('cnpj', whereIn: cnpjs)
          .get();

      final result = doc.docs
          .map((company) => CompanyModel.fromMap(company.data()))
          .toList();

      return result;
    } on FirebaseException catch (e) {
      throw RemoteException(e.message ?? textError);
    }
  }

  @override
  Future<bool> updateCompany({required CompanyModel company}) async {
    const textError = 'Erro ao salvar empresa';

    try {
      await _db
          .collection(FirestoreConst.company())
          .doc(company.hash)
          .update(company.toMap());

      return true;
    } on FirebaseException catch (e) {
      throw RemoteException(e.message ?? textError);
    }
  }
}
