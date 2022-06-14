import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Anasayfa(),
    );
  }
}
  class Anasayfa extends StatefulWidget {
    const Anasayfa({Key? key}) : super(key: key);
  
    @override
    State<Anasayfa> createState() => _AnasayfaState();
  }
  
  class _AnasayfaState extends State<Anasayfa> {
  String alinanVeri = "";
  var tfController = TextEditingController(); //Veriyi almamızı sağlar tfcontroller.text ile veriyi kullanabiliriz
String resimaAdi = "kofte.png";
bool switchKontrol = false;
bool checkBoxKontrol = false;
int radioDeger = 0;
bool progressKontrol = false;
double ilerleme = 50.0;
  var tfSaat = TextEditingController();
  var tfTarih= TextEditingController();
  var ulkelerListesi= <String>[];
  String secilenUlke ="Türkiye";

  @override
  void initState(){
    super.initState();
    ulkelerListesi.add("Türkiye");
    ulkelerListesi.add("İtalya");
    ulkelerListesi.add("Japonya");
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Widget Kullanimi")),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                Text(alinanVeri),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: tfController,
                    decoration: const InputDecoration(
                      hintText: "Veriyi girin",
                    ),
                    keyboardType: TextInputType.phone,    //  Kullanıcının karşısında çıkacak kılavye
                    obscureText: true,    //Şifreyi gizleme .... şeklinde görünmesi için kullanılır
                  ),
                ),
                ElevatedButton(onPressed: (){
                  setState((){
                    alinanVeri = tfController.text;
                  });
                }, child: Text("Veriyi Al")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      setState((){
                        resimaAdi = "kofte.png";
                      });
                    }, child: const Text("RESİM 1")),
                    SizedBox(height: 48,width: 48,child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/$resimaAdi")),
                    ElevatedButton(onPressed: (){
                      setState((){
                        resimaAdi = "ayran.png";
                      });
                    }, child: const Text("RESİM 2")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      child: SwitchListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("Dart"),
                          value: switchKontrol,
                          onChanged: (veri){
                            setState((){
                              switchKontrol = veri;
                            });
                            print("Switch : $veri");
                          }),
                    ),
                SizedBox(width: 140,
                  child: CheckboxListTile(
                    title: Text("Flutter"),
                      controlAffinity: ListTileControlAffinity.leading, // Kontrol butonunu yazının soluna mı sağına mı koycaksın belirler
                      value: checkBoxKontrol,
                      onChanged: (bool? veri){
                    setState((){
                      checkBoxKontrol =  veri!;
                      print("CheckBox : $veri");
                    });
                  })
                  ,
                ),

                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                          title: Text("barca"),
                          value: 1,
                          groupValue: radioDeger,
                          onChanged: (int? veri){
                            setState((){
                              radioDeger = veri!;
                              print("Radio 1: $veri");
                            });
                          }),
                    ),
                    SizedBox(
                      width: 150,
                      child: RadioListTile(
                          title: Text("real"),
                          value: 2,
                          groupValue: radioDeger,
                          onChanged: (int? veri){
                            setState((){
                              radioDeger = veri!;
                              print("Radio 2: $veri");
                            });
                          }),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      setState((){
                        progressKontrol = true;
                      });
                    }, child: const Text("Başla")),
                    Visibility(child: CircularProgressIndicator(),visible: progressKontrol),
                    ElevatedButton(onPressed: (){
                      setState((){
                        progressKontrol = false;
                      });
                    }, child: const Text("Dur")),
                  ],
                ),
             Text(ilerleme.toInt().toString()),
            Slider(max: 100.0,min: 0.0,value: ilerleme, onChanged: (veri){
      setState((){
    ilerleme = veri;
  });
}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 48,
                      child: TextField(
                        controller: tfSaat,
                        decoration: InputDecoration(hintText: "Saat"),
                      ),
                    ),
                    IconButton(onPressed: (){
showTimePicker(context: context, initialTime:
TimeOfDay.fromDateTime(DateTime.now())).then((value) { //Bize Picker bir saat geritiriyor onu value atiyor
                     tfSaat.text = "${value!.hour} : ${value.minute}";
    }
    );

                    }, icon: Icon(Icons.access_time_outlined)),
                    SizedBox(
                      width: 70,
                      child: TextField(
                        controller: tfTarih,
                        decoration: InputDecoration(hintText: "tarih"),
                      ),
                    ),
                    IconButton(onPressed: (){
showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2030)).then((value){
      tfTarih.text = "${value!.day} - ${value.month} - ${value.year}";
});
                    }, icon: Icon(Icons.date_range))
                  ],
                ),
                DropdownButton(
                  value: secilenUlke,
                    icon: Icon(Icons.arrow_drop_down),
                    items: ulkelerListesi.map<DropdownMenuItem<String>>(// veri kümemiz string diye dropdown menü item da string
                        (value){
                          return DropdownMenuItem(value: value,child: Text(value));
                        }
                    ).toList(),
                    onChanged: (String? secilenVeri){
                    setState((){
                      secilenUlke = secilenVeri!;
                    });
                    }),
                GestureDetector(
                   onTap: (){
                     print("Container tek tıklandı");
                   },
                  onDoubleTap: (){
                     print("çift tıklandı");

                  },
                  onLongPress: (){
                     print("uzun basıldı");
           },
                  child: Container(
                    width: 200,
                    height: 100,
                    color: Colors.red,
                  ),
                ),
                ElevatedButton(onPressed: (){
                  print("Switch en son durum : $switchKontrol");
                  print("CheckBox en son durum : $checkBoxKontrol");
                  print("Radio deger $radioDeger");
                  print("Slider son durum ${ilerleme.toInt()}");
                },
                    child: Text("Göster")),
              ],
            ),
          ),
        ),
      );
    }
  }
  