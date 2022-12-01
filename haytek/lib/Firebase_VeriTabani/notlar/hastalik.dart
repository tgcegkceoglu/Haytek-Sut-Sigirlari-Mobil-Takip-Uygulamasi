import 'package:cloud_firestore/cloud_firestore.dart';

class HastalikEkleFirebase {
  final String hayvanresim;
  final String hayvanId;
  final String hastalikId;
  final String hayvaninkupeno;
  final String hastalikismi;
  final String hastaliknot;
  final DateTime hastalikbaslangic;
  final DateTime hastalikbitis;

  HastalikEkleFirebase({
    required this.hayvanresim,
    required this.hastaliknot,
    required this.hayvanId,
    required this.hastalikId,
    required this.hayvaninkupeno,
    required this.hastalikismi,
    required this.hastalikbaslangic,
    required this.hastalikbitis,
  });
  Map<String, dynamic> toJson() => {
        //Mape Dönüştür
        'hayvanId': hayvanId,
        'hastalikId':hastalikId,
        'hastaliknot':hastaliknot,
        'hayvaninkupeno': hayvaninkupeno,
        'hastalikismi':hastalikismi,
        'hastalikbaslangic': hastalikbaslangic,
        'hastalikbitis': hastalikbitis,
        'hayvanresim':hayvanresim,
      };

  static HastalikEkleFirebase fromJson(Map<String, dynamic> json) => //Mapten oluştur
      HastalikEkleFirebase(
        hayvanresim: json['hayvanresim'],
        hastaliknot: json['hastaliknot'],
        hayvanId: json['hayvanId'],
        hastalikId: json['hastalikId'],
        hayvaninkupeno: json['hayvaninkupeno'],
        hastalikismi: json['hastalikismi'],
        hastalikbaslangic:(json['hastalikbaslangic'] as Timestamp).toDate(),
        hastalikbitis:(json['hastalikbitis'] as Timestamp).toDate(),
      );
}