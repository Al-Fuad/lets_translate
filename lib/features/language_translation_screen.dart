import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationScreen extends StatefulWidget {
  const LanguageTranslationScreen({super.key});

  @override
  State<LanguageTranslationScreen> createState() => _LanguageTranslationScreenState();
}

class _LanguageTranslationScreenState extends State<LanguageTranslationScreen> {
  var languages = ["Arabic","Bengali","English"];
  var originLang = "From";
  var destLang = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();

  Future<void> translate(String input, String src, String des) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: des);
    setState(() {
      output = translation.toString();
    });
    if(src == "--" || des == "--"){
      output = "Failed";
    }
  }

  String getLangCode(String lang){
    if(lang == "Auto Detect"){
      return "auto";
    }
    else if(lang == "Arabic"){
      return "ar";
    }
    else if(lang == "Bengali"){
      return "bn";
    }
    else if(lang == "English"){
      return "en";
    }
    else{
      return "--";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lets Translate"),
        elevation: 8,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    hint: Text(originLang),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String la){
                      return DropdownMenuItem(value: la,child: Text(la),);
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        originLang = value!;
                      });
                    } ,
                  ),
                  const SizedBox(width: 40,),
                  const Icon(Icons.arrow_right),
                  const SizedBox(width: 40,),
                  DropdownButton(
                    hint: Text(destLang),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String la){
                      return DropdownMenuItem(value: la,child: Text(la),);
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        destLang = value!;
                      });
                    } ,
                  ),
                ],
              ),
              const SizedBox(height: 40,),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                        controller: languageController,
                        decoration: const InputDecoration(
                          labelText: "Please enter your text",
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "Please enter text to translate";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(output, style: TextStyle(fontSize: 25),),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    translate(languageController.text.toString(), getLangCode(originLang), getLangCode(destLang));
                  },
                  child: const Text("Translate"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
