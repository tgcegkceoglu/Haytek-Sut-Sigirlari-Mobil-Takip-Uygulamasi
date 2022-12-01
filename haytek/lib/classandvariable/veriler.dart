import 'package:truncate/truncate.dart';

class Veriler {
  kelime(String metin) {
  String text = metin;
  String yenimetin =
      truncate(text, 18, omission: "...", position: TruncatePosition.end);
  return yenimetin;
}
  List asilamatarihi = [
    "12/01/2022",
    "15/08/2021",
    "13/04/2021",
    "09/06/2021",
    "07/02/2022",
    "05/10/2022"
  ];
  List asilamatarihison = [
    "18/05/2022",
    "15/08/2021",
    "13/06/2021",
    "17/08/2021",
    "09/06/2022",
    "05/11/2022"
  ];
  List<String> resimyolu = [
    "https://img.piri.net/mnresize/840/-/resim/site/615x326/ineklercc96aa45.jpg",
    "https://vetrehberi.com/wp-content/uploads/2018/03/inekler-her-zaman-haklidir.jpg",
    "https://kraiburg.com.tr/wp-content/uploads/2016/07/yatan-inek-1.jpg",
    "https://img.pixers.pics/pho_wat(s3:700/FO/64/67/47/58/700_FO64674758_f83a17771870504e9447a97e972188ff.jpg,700,636,cms:2018/10/5bd1b6b8d04b8_220x50-watermark.png,over,480,586,jpg)/duvar-resimleri-inek.jpg.jpg",
    "https://petfiks.com/wp-content/uploads/2021/04/hamile-inek-nasil-anlasilir-min.jpg",
    "https://www.keyiflibilgi.com/wp-content/uploads/2021/09/simental-sigir-irki-ozellikleri-ve-randiman.jpg",
  ];
  List<String> asilayankisi = [
    "Volkan Korkmaz",
    "Hasan Tarık Yurtseven",
    "Tayyibe Gökçeoğlu",
    "Buse Başarı",
    "Büşra Çolak",
    "Sena Özkara",
  ];
  List<String> kupeno = [
    "1",
    "19114040",
    "406253",
    "986573",
    "234589",
    "986754",
    "32546",

  ];
  List<String> bogakupeno = [
    "256785",
    "243598",
    "784959",
    "359247",
    "553246",
    "632145",
  ];
  List<String> bogairk= [
     'Yerli Kara',
    'Doğu Anadolu Kırmızısı',
    'Boz Irk',
    'Güney Anadolu Kırmızısı',
    'Kırım Sığırı',
    'Zavot Sığırı',
  ];
  List<String> dogum = [
    'Tek',
    'İkiz ',
    'Üçüz',
    'Dördüz',
    'Beşiz',
    'Altız',
  ];
  List<String> hastalikismi = [
    'MASTİTİS (MEME İLTİHABI)',
    'HİPOKALSEMİ (SÜT HUMMASI)',
    'KETOSİS',
    'TİMPANİ(ŞİŞME)',
    'ANTRAKS (ŞARBON)',
    'YANIKARA',
    'BRUSELLOZİS (YAVRU ATMA HASTALIĞI)',
    'PİROPLAZMOZ (KAN İŞEME, AĞRIMA)',
    'SIĞIR BRUSELLOZU',
    'SIĞIR TÜBERKÜLOZU',
    'SIĞIR VEBASI',
    'SIĞIRLARIN NODÜLER EKZANTEMİ',
    'SIĞIRLARIN SÜNGERİMSİ BEYİN HASTALIĞI (BSE)',
    'ŞAP - A',
    'ŞAP - ASİA1',
    'ŞAP - O',
    'ŞAP - TİPLENDİRİLEMEDİ',
    'ŞAP ?',
    'Şap Grubu(Hepsi)',
  ];
  List<String> asiismi = [
    'ŞAP AŞISI',
    'SIĞIR VEBASI AŞISI ',
    'ŞARBON (ANTHRAKS) AŞISI',
    'BRUCELLA AŞISI',
    'ENTEROTOKSEMİ AŞISI',
    'LEPTOSPİROZ AŞISI',
    /* 'PASTÖRELLA AŞISI',
    'SEPTICEMIA NEONATORUM AŞISI',
    'YANIKARA AŞISI',
    'PARATÜBERKÜLOZ AŞISI',
    'BOTULİSMUS AŞISI',
    'THEİLERİA ANNULATA AŞISI',
    'IBR AŞISI',
    'MASTİTİS AŞISI', */
  ];
  List<String> irk = [
    'Montafon',
    'Brangus',
    'Simmental',
    'Holstein',
    'Holstein Friesian',
    'Jersey',
    'Charolais',
    'Yerli Kara',
    'Doğu Anadolu Kırmızısı',
    'Boz Irk',
    'Güney Anadolu Kırmızısı',
    'Kırım Sığırı',
    'Zavot Sığırı',
  ];
}
