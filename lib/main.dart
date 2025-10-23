import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const KalkulatorBMI());
}

class KalkulatorBMI extends StatelessWidget {
  const KalkulatorBMI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kalkulato BMI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.blue,
      ),
      home: const KalkulatorBMIScreen()
    );
  }
}

class KalkulatorBMIScreen extends StatefulWidget {
  const KalkulatorBMIScreen({super.key});

  @override
  State<KalkulatorBMIScreen> createState() => _KalkulatorBMIScreenState();
}

class _KalkulatorBMIScreenState extends State<KalkulatorBMIScreen> {

  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String? _SelectedGender;
  double? _bmiResult;
  String _bmiInterpretation = "Silahkan Masukan Data Anda!";

  void _hitungBMI(){
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightInCM = double.tryParse(_heightController.text) ?? 0;

  setState(() {
    if(weight > 0 && heightInCM > 0 && _SelectedGender != null){
      final double heightInM = heightInCM/100;
      final double bmi = weight / (heightInM*heightInM);
      _bmiResult = bmi;

    if( _SelectedGender == 'Perempuan') {
      if(bmi<18.5){
        _bmiInterpretation = "Kekurangan Berat Badan";
      }else if(bmi<24){
        _bmiInterpretation = "Ideal";
      }else if(bmi<30){
        _bmiInterpretation = "Kelebihan Berat Badan";
      }else{
        _bmiInterpretation = "Obesitas";
      }
    }else{
      if(bmi<18.5){
        _bmiInterpretation = "Kekurangan Berat Badan";
      }else if(bmi<25){
        _bmiInterpretation = "Idel";
      }else if(bmi<30){
        _bmiInterpretation = "Kelebihan Berat Badan";
      }else{
        _bmiInterpretation = "Obessitas";
      }
    }
    }else{
      _bmiResult = null;
      _bmiInterpretation = "Data Tidak Falid atau Gender Belum di Pilih";
      }
    });
  }

void _reset(){
  setState(() {
    _weightController.clear();
    _heightController.clear();
    _SelectedGender = null;
    _bmiResult = null;
    _bmiInterpretation = "Silahkan Masukan Data Anda !";
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kalkulator BMI",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.grey[100],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 24, color: Colors.blue,),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    value: _SelectedGender, 
                    hint: const Text(
                      "Pilih Gender",
                      style: TextStyle(color: Colors.black54),
                    ),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                      DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _SelectedGender = value;
                      });
                    },
                  ),
                ),
              ],
            ),
             
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              decoration: InputDecoration(
                labelText: "Berat Badan (kg)",
                labelStyle: const TextStyle(color: Colors.blue),
                icon: Icon(Icons.monitor_weight, color: Colors.blue,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              decoration: InputDecoration(
                labelText: "Tinggi Badan (cm)",
                labelStyle: const TextStyle(color: Colors.blue),
                icon: Icon(Icons.height, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _hitungBMI, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    "Hitung BMI",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 16),  
                ElevatedButton(
                  onPressed: _reset, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Hasil",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
                color: Colors.lightBlue[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                    Text(
                      _bmiResult != null ? _bmiResult!.toStringAsFixed(2) : '__',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _bmiInterpretation,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text("Pastikan Data yang di Masukan Akurat untuk Hasil yang Tepat.",
                style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}