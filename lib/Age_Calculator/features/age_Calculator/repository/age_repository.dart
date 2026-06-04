import 'package:flutter_w/Age_Calculator/features/age_Calculator/data/model/age_model.dart';
import 'package:flutter_w/Age_Calculator/features/age_Calculator/data/services/age_service.dart';



class AgeRepository {

  final AgeService service = AgeService();

  AgeModel getAge(DateTime dob) {
    return service.calculate(dob);
  }
}