import 'package:flutter/material.dart';

// void main() {
//   runApp(const ContactBook());
// }

class ContactBook extends StatelessWidget {
  const ContactBook({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Book',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006400)),
      ),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> allContacts = [
    {
      "title": "Dhaka Exchange",
      "contacts": [
        { "area": "Kishoreganj Sadar", "phone": "01769511141" },
        { "area": "Hossainpur", "phone": "01769511141" },
        { "area": "Katiadi", "phone": "01769511141" },
        { "area": "Pakundia", "phone": "01769511141" },
        { "area": "Bhairab", "phone": "01769202356" },
        { "area": "Bajitpur", "phone": "01679435672" },
        { "area": "Kuliarchar", "phone": "01679435672" },
        { "area": "Karimganj", "phone": "01769195023" },
        { "area": "Tarail", "phone": "01769195023" },
        { "area": "Nikli", "phone": "01769195023" },
        { "area": "Mithamain", "phone": "01769215104" },
        { "area": "Austagram", "phone": "01769215104" },
        { "area": "Itna", "phone": "01727969453" },
        { "area": "Tangail Sadar", "phone": "01789317327" },
        { "area": "Basail", "phone": "01769210041" },
        { "area": "Sakhipur", "phone": "01769210041" },
        { "area": "Kalihati", "phone": "01769210042" },
        { "area": "Bhuyapur", "phone": "01769212608" },
        { "area": "Gopalpur", "phone": "01769212608" },
        { "area": "Madhupur", "phone": "01769510926" },
        { "area": "Dhanbari", "phone": "01769510926" },
        { "area": "Mirzapur", "phone": "01769288784" },
        { "area": "Nagarpur", "phone": "01931301799" },
        { "area": "Delduar", "phone": "01931301799" },
        { "area": "Chowhali", "phone": "01931301799" },
        { "area": "Ghatail", "phone": "01769195030" },
        { "area": "Rajbari", "phone": "01769552380" },
        { "area": "Goalondo", "phone": "01769552380" },
        { "area": "Baliakandi", "phone": "01769552380" },
        { "area": "Kalukhali", "phone": "01769552380" },
        { "area": "Pangsha", "phone": "01769552380" },
        { "area": "Madaripur Sadar", "phone": "01769078424" },
        { "area": "Shibchar", "phone": "01769078425" },
        { "area": "Kalkini", "phone": "01769078426" },
        { "area": "Gopalganj Sadar", "phone": "01769552162" },
        { "area": "Kashiani", "phone": "01325789908" },
        { "area": "Muksudpur", "phone": "01769552166" },
        { "area": "Tungipara", "phone": "01769552166" },
        { "area": "Kotalipara", "phone": "01769552166" },
        { "area": "Gazipur", "phone": "01769095198" },
        { "area": "Tongi", "phone": "01769095198" },
        { "area": "Kaliakoir", "phone": "01769095198" },
        { "area": "Kashimpur", "phone": "01769095198" },
        { "area": "Pubail", "phone": "01769095198" },
        { "area": "Kapasia", "phone": "01769095198" },
        { "area": "Kaliganj (Gazipur)", "phone": "01769095198" },
        { "area": "Joydebpur", "phone": "01769095198" },
        { "area": "Narayanganj", "phone": "01769095198" },
        { "area": "Bandar", "phone": "01769095198" },
        { "area": "Fatullah", "phone": "01769095198" },
        { "area": "Siddhirganj", "phone": "01769095198" },
        { "area": "Araihazar", "phone": "01769095198" },
        { "area": "Sonargaon", "phone": "01769095198" },
        { "area": "Rupganj", "phone": "01769095198" },
        { "area": "Munshiganj", "phone": "01769095198" },
        { "area": "Manikganj", "phone": "01769095198" },
        { "area": "Narsingdi", "phone": "01769095198" },
        { "area": "Shariatpur", "phone": "01769095198" },
        { "area": "Faridpur", "phone": "01769095198" }
      ]
    },
    {
      "title": "Savar Exchange",
      "contacts": [
        { "area": "Savar", "phone": "01769095209" },
        { "area": "Ashulia", "phone": "01769095209" },
        { "area": "Hemayetpur", "phone": "01769095198" },
        { "area": "Keraniganj", "phone": "01769095250" },
        { "area": "Dohar", "phone": "01769095209" },
        { "area": "Bipail", "phone": "01769095250" },
        { "area": "Gazipur", "phone": "01769095198" },
        { "area": "Mouchak", "phone": "01769095198" },
        { "area": "Manikganj", "phone": "01769095198" }
      ]
    },
    {
      "title": "Bogura Exchange",
      "contacts": [
        { "area": "Bogura Sadar", "phone": "01769117963" },
        { "area": "Majhira", "phone": "01769117963" },
        { "area": "Dupchanchia", "phone": "01754930866" },
        { "area": "Sariakandi", "phone": "01759961210" },
        { "area": "Sariakandi (alternate)", "phone": "01754930694" }
      ]
    },
    {
      "title": "Cumilla Exchange",
      "contacts": [
        { "area": "Cumilla Sadar", "phone": "017693324440" },
        { "area": "Alekhar Char", "phone": "017693324448" },
        { "area": "Chandina", "phone": "01769331332" },
        { "area": "Chouddagram", "phone": "017693324446" },
        { "area": "Laksam", "phone": "01769332133" },
        { "area": "Nangalkot", "phone": "01769337655" },
        { "area": "Monohorgonj", "phone": "01769332255" },
        { "area": "Burichong", "phone": "01769338197" },
        { "area": "Debidwar", "phone": "01769331057" },
        { "area": "Homna", "phone": "01769330350" },
        { "area": "Daudkandi", "phone": "01769332299" },
        { "area": "Lalmai", "phone": "01811781257" }
      ]
    },
    {
      "title": "Sylhet Exchange",
      "contacts": [
        { "area": "Barlekha", "phone": "01769511081" },
        { "area": "Juri", "phone": "01769511081" },
        { "area": "Kulaura", "phone": "01769511081" },
        { "area": "Moulvibazar", "phone": "01769172386" },
        { "area": "Rajnagar", "phone": "01769172386" },
        { "area": "Sreemangal", "phone": "01769172386" },
        { "area": "Kamalganj", "phone": "01769172386" },
        { "area": "Sunamganj Sadar", "phone": "01769178755" },
        { "area": "Tahirpur", "phone": "01769178755" },
        { "area": "Madhyanagar", "phone": "01769178755" },
        { "area": "Bishwambarpur", "phone": "01769178755" },
        { "area": "Shantiganj", "phone": "01769178755" },
        { "area": "Dirai", "phone": "01769178755" },
        { "area": "Dharampasha", "phone": "01769178755" },
        { "area": "Shalla", "phone": "01769178755" },
        { "area": "Jamalganj", "phone": "01769178755" },
        { "area": "Chatak", "phone": "01575545395" },
        { "area": "Dowarabazar", "phone": "01575545395" },
        { "area": "Jagannathpur", "phone": "01575545395" },
        { "area": "Gowainghat", "phone": "01769177643" },
        { "area": "Jaintiapur", "phone": "01769177643" },
        { "area": "Kanaighat", "phone": "01769177643" },
        { "area": "Zakiganj", "phone": "01769177643" },
        { "area": "Golapganj", "phone": "01769172534" },
        { "area": "Beanibazar", "phone": "01769172534" },
        { "area": "Fenchuganj", "phone": "01769172534" },
        { "area": "Dakshin Surma", "phone": "01769172534" },
        { "area": "Moglabazar", "phone": "01769172534" },
        { "area": "Sylhet Sadar", "phone": "01769172556" },
        { "area": "Jalalabad", "phone": "01769172556" },
        { "area": "Kotwali", "phone": "01769172556" },
        { "area": "Shah Paran", "phone": "01769172556" },
        { "area": "Bimanbandar", "phone": "01769172556" },
        { "area": "Osmaninagar", "phone": "01774540450" },
        { "area": "Balaganj", "phone": "01774540450" },
        { "area": "Bishwanath", "phone": "01774540450" },
        { "area": "Habiganj Sadar", "phone": "01769172614" },
        { "area": "Bahubal", "phone": "01769172614" },
        { "area": "Rashidpur", "phone": "01769172614" },
        { "area": "Baniachong", "phone": "01769172616" },
        { "area": "Nabiganj", "phone": "01769172616" },
        { "area": "Ajmiriganj", "phone": "01769172616" },
        { "area": "Madhabpur", "phone": "01745776488" },
        { "area": "Shayestaganj", "phone": "01745776488" },
        { "area": "Chunarughat", "phone": "01745776488" }
      ]
    },
    {
      "title": "Chattogram Exchange",
      "contacts": [
        { "area": "Mirsharai", "phone": "01769245243" },
        { "area": "Sitakunda", "phone": "01769245243" },
        { "area": "Bayezid Bostami", "phone": "01769245243" },
        { "area": "Hathazari", "phone": "01769242617" },
        { "area": "Rangunia", "phone": "01769242617" },
        { "area": "Rauzan", "phone": "01769245243" },
        { "area": "Khulshi", "phone": "01769253649" },
        { "area": "Halishahar", "phone": "01769253649" },
        { "area": "Pahartali", "phone": "01769253649" },
        { "area": "EPZ", "phone": "01769253649" },
        { "area": "Bandar", "phone": "01769253649" },
        { "area": "Akborshah", "phone": "01769253649" },
        { "area": "Anwara", "phone": "01769244214" },
        { "area": "Karnaphuli", "phone": "01769244214" },
        { "area": "Boalkhali", "phone": "01769244214" },
        { "area": "Kotwali", "phone": "01769242617" },
        { "area": "Double Mooring", "phone": "01769242617" },
        { "area": "Chandgaon", "phone": "01769242617" },
        { "area": "Chawk Bazar", "phone": "01769242617" },
        { "area": "Panchlaish", "phone": "01769242617" },
        { "area": "Sadarghat", "phone": "01769242617" },
        { "area": "Patenga", "phone": "01769253649" },
        { "area": "Potia", "phone": "01336619425" },
        { "area": "Chandanaish", "phone": "01769102401" },
        { "area": "Satkania", "phone": "01858367937" },
        { "area": "Banshkhali", "phone": "01769102822" },
        { "area": "Lohagara", "phone": "01769104554" },
        { "area": "Cox's Bazar Sadar", "phone": "01831387796" },
        { "area": "Eidgaon", "phone": "01769102647" },
        { "area": "Ramu", "phone": "01769102646" },
        { "area": "Ukhia", "phone": "01826552075" },
        { "area": "Chakaria", "phone": "01769104617" },
        { "area": "Pekua", "phone": "01769107469" }
      ]
    },
    {
      "title": "Jashore Exchange",
      "contacts": [
        { "area": "Kushtia", "phone": "01769552362" },
        { "area": "Mirpur", "phone": "01769552362" },
        { "area": "Kumarkhali", "phone": "01769552362" },
        { "area": "Khoksa", "phone": "01769552362" },
        { "area": "Islamic University", "phone": "01769552362" },
        { "area": "Daulatpur", "phone": "01769552362" },
        { "area": "Veramara", "phone": "01769552362" },
        { "area": "Meherpur Sadar", "phone": "01769558450" },
        { "area": "Mujibnagar", "phone": "01769558450" },
        { "area": "Gangni", "phone": "01769558651" },
        { "area": "Jhenaidah", "phone": "01769552436" },
        { "area": "Kaliganj", "phone": "01769552442" },
        { "area": "Shailkupa", "phone": "01769552438" },
        { "area": "Harinakunda", "phone": "01769552436" },
        { "area": "Maheshpur", "phone": "01769552436" },
        { "area": "Kotchandpur", "phone": "01769552436" }
      ]
    },
    {
      "title": "Ramu Exchange",
      "contacts": [
        { "area": "Cox’s Bazar Sadar", "phone": "01831387796" },
        { "area": "Ramu", "phone": "01769102646" },
        { "area": "Eidgaon", "phone": "01769102647" },
        { "area": "Ukhia", "phone": "01826552075" },
        { "area": "Chakaria", "phone": "01769104617" },
        { "area": "Pekua", "phone": "01769107469" }
      ]
    },
      {
        "title": "Rajshahi Exchange",
        "contacts": [
          {"area": "Bogura Sadar", "phone": "01769117963"},
          {"area": "Majhira", "phone": "01754930866"},
          {"area": "Dupchanchia", "phone": "01754930694"},
          {"area": "Sariakandi", "phone": "01759961210"},
          {"area": "Naogaon Sadar", "phone": "01769122122"},
          {"area": "Patnitala", "phone": "01769122107"},
          {"area": "Niamatpur", "phone": "01769122109"},
          {"area": "Joypurhat", "phone": "01769112144"},
          {"area": "Kalai", "phone": "N/A"},
          {"area": "Khetlal", "phone": "N/A"},
          {"area": "Panchbibi", "phone": "N/A"},
          {"area": "Akkelpur", "phone": "N/A"},
          {"area": "Sirajganj Sadar", "phone": "01769126015"},
          {"area": "Belkuchi", "phone": "01769122449"},
          {"area": "Kazipur", "phone": "01769122419"},
          {"area": "Tarash", "phone": "01769122496"},
          {"area": "Ullapara", "phone": "01769122476"},
          {"area": "Natore Sadar", "phone": "01769112447"},
          {"area": "Lalpur", "phone": "01769112454"},
          {"area": "Singra", "phone": "01769112456"},
          {"area": "Rajshahi City", "phone": "01769112388"},
          {"area": "Durgapur", "phone": "01769118971"},
          {"area": "Mohonpur", "phone": "01769118972"},
          {"area": "Charghat", "phone": "01769118973"},
          {"area": "Pabna Sadar", "phone": "01339502710"},
          {"area": "Santhia", "phone": "N/A"},
          {"area": "Bhangura", "phone": "N/A"},
          {"area": "Chapai Nawabganj Sadar", "phone": "01769112372"},
          {"area": "Shibganj", "phone": "01769117392"}
        ]
      },
       {
        "title": "Khulna Exchange",
        "contacts": [
          {"area": "Kushtia Sadar", "phone": "01769552362"},
          {"area": "Mirpur", "phone": "01769558642"},
          {"area": "Kumarkhali", "phone": "N/A"},
          {"area": "Khoksha", "phone": "N/A"},
          {"area": "Islamic University", "phone": "N/A"},
          {"area": "Daulatpur", "phone": "N/A"},
          {"area": "Bheramara", "phone": "N/A"},
          {"area": "Meherpur Sadar", "phone": "01769558450"},
          {"area": "Mujibnagar", "phone": "N/A"},
          {"area": "Gangni", "phone": "01769558651"},
          {"area": "Jhenaidah Sadar", "phone": "01769552436"},
          {"area": "Kaliganj", "phone": "01769552442"},
          {"area": "Shailkupa", "phone": "01769552438"},
          {"area": "Harinakundu", "phone": "N/A"},
          {"area": "Maheshpur", "phone": "N/A"},
          {"area": "Kotchandpur", "phone": "N/A"},
          {"area": "Chuadanga Sadar", "phone": "01769556715"},
          {"area": "Damurhuda", "phone": "01769026006"},
          {"area": "Jibannagar", "phone": "N/A"},
          {"area": "Alamdanga", "phone": "N/A"},
          {"area": "Jashore Sadar", "phone": "01769558168"},
          {"area": "Chowgacha", "phone": "01769558167"},
          {"area": "Bagherpara", "phone": "01769558166"},
          {"area": "Jhikargachha", "phone": "N/A"},
          {"area": "Sharsha", "phone": "N/A"},
          {"area": "Abhaynagar", "phone": "N/A"},
          {"area": "Keshabpur", "phone": "N/A"},
          {"area": "Monirampur", "phone": "N/A"},
          {"area": "Narail Sadar", "phone": "01769554505"},
          {"area": "Lohagara", "phone": "01769558351"},
          {"area": "Naragati", "phone": "N/A"},
          {"area": "Kalia", "phone": "N/A"},
          {"area": "Magura Sadar", "phone": "01769554522"},
          {"area": "Sreepur", "phone": "01797470291"},
          {"area": "Mohammadpur", "phone": "N/A"},
          {"area": "Shalikha", "phone": "N/A"},
          {"area": "Khulna Sadar", "phone": "01334796395"},
          {"area": "Sonadanga", "phone": "01334796399"},
          {"area": "Rupsha", "phone": "01334796398"},
          {"area": "Phultala", "phone": "01334796397"},
          {"area": "Khalishpur", "phone": "01334796400"},
          {"area": "Batiaghata", "phone": "N/A"},
          {"area": "Paikgacha", "phone": "N/A"},
          {"area": "Satkhira", "phone": "01769558647"},
          {"area": "Kalaroa", "phone": "01769558648"},
          {"area": "Tala", "phone": "01769558649"},
          {"area": "Bagerhat Sadar", "phone": "01769078423"},
          {"area": "Moralganj", "phone": "01769078420"},
          {"area": "Mollahat", "phone": "01769078421"},
          {"area": "Chitalmari", "phone": "01769078422"},
          {"area": "Rampal", "phone": "01769078419"}
        ]
      },

      {
        "title": "Barishal Exchange",
        "contacts": [
          {"area": "Barishal Sadar", "phone": "01769078400"},
          {"area": "Hizla", "phone": "01769078403"},
          {"area": "Babuganj", "phone": "01769078404"},
          {"area": "Gournadi", "phone": "01769078405"},
          {"area": "Bakerganj", "phone": "01769078406"},
          {"area": "Bakerganj (2)", "phone": "01769078407"},
          {"area": "Patuakhali Sadar", "phone": "01769078409"},
          {"area": "Mirzaganj", "phone": "01769078408"},
          {"area": "Galachipa", "phone": "01769078410"},
          {"area": "Bauphal", "phone": "01769078411"},
          {"area": "Kalapara", "phone": "01769078412"},
          {"area": "Kalapara (2)", "phone": "01769078413"},
          {"area": "Jhalokathi Sadar", "phone": "01769078414"},
          {"area": "Kathalia", "phone": "01769078415"},
          {"area": "Pirojpur Sadar", "phone": "01769078416"},
          {"area": "Mathbaria", "phone": "01769078417"},
          {"area": "Nesarabad", "phone": "01769078418"}
        ]
      },
    {
      "title": "Mymensingh Exchange",
      "contacts": [
        {"area": "Netrokona Sadar", "phone": "01769202436"},
        {"area": "Atpara", "phone": "01769202436"},
        {"area": "Barhatta", "phone": "01769202436"},
        {"area": "Mohanganj", "phone": "01769202436"},
        {"area": "Madan", "phone": "01303121551"},
        {"area": "Kendua", "phone": "01303121551"},
        {"area": "Khaliajuri", "phone": "01303121551"},
        {"area": "Durgapur", "phone": "01769192096"},
        {"area": "Purbadhala", "phone": "01769192096"},
        {"area": "Mymensingh Sadar", "phone": "01769202516"},
        {"area": "Muktagacha", "phone": "01769202516"},
        {"area": "Fulbaria", "phone": "01769206013"},
        {"area": "Tarakanda", "phone": "01769202530"},
        {"area": "Phulpur", "phone": "01769202530"},
        {"area": "Haluaghat", "phone": "01769202530"},
        {"area": "Dobaura", "phone": "01769202530"},
        {"area": "Gouripur", "phone": "01769192112"},
        {"area": "Ishwarganj", "phone": "01769192112"},
        {"area": "Nandail", "phone": "01769192112"},
        {"area": "Valuka", "phone": "01769192174"},
        {"area": "Trishal", "phone": "01769192174"},
        {"area": "Gafargaon", "phone": "01769192173"},
        {"area": "Jamalpur Sadar", "phone": "01829554592"},
        {"area": "Melandaha", "phone": "01829554592"},
        {"area": "Madaripur", "phone": "01609251960"},
        {"area": "Sarishabari", "phone": "01747326719"},
        {"area": "Dewanganj", "phone": "01769192146"},
        {"area": "Bakshiganj", "phone": "01769192146"},
        {"area": "Islampur", "phone": "01769192146"},
        {"area": "Sherpur Sadar", "phone": "01769192520"},
        {"area": "Nakla", "phone": "01769556666"},
        {"area": "Nalitabari", "phone": "01769556666"},
        {"area": "Sreebardi", "phone": "01769510012"},
        {"area": "Jhenaigati", "phone": "01769510012"}
      ]
    },
    {
      "title": "Rangpur Exchange",
      "contacts": [
        {"area": "Rangpur", "phone": "01769662514"},
        {"area": "Rangpur Cadet College", "phone": "01769512088"},
        {"area": "Rangpur Sadar", "phone": "01769662221"},
        {"area": "Gangachara", "phone": "01769662514"},
        {"area": "Kaunia", "phone": "01769662514"},
        {"area": "Pirgacha", "phone": "01769662514"},
        {"area": "Mithapukur", "phone": "01769662514"},
        {"area": "Taraganj", "phone": "01769662514"},
        {"area": "Pirganj", "phone": "01769662514"},
        {"area": "Badarganj", "phone": "01769662514"},

        {"area": "Barapukuria Coal Mine", "phone": "01769682440"},
        {"area": "Barapukuria Power Plant", "phone": "01886536309"},
        {"area": "Madhyapara Rock Mine", "phone": "01824388574"},
        {"area": "Dinajpur Sadar", "phone": "01721468889"},
        {"area": "Parbatipur (Locomotive Workshop/Oil Refueling)", "phone": "01721468889"},
        {"area": "Birampur", "phone": "01721468889"},
        {"area": "Nawabganj", "phone": "01721468889"},
        {"area": "Hakimpur", "phone": "01721468889"},
        {"area": "Ghoraghat", "phone": "01721468889"},
        {"area": "Kaharole", "phone": "01721468889"},
        {"area": "Bochaganj", "phone": "01721468889"},
        {"area": "Khansama", "phone": "01721468889"},
        {"area": "Biral", "phone": "01721468889"},
        {"area": "Birganj", "phone": "01721468889"},
        {"area": "Chirirbandar", "phone": "01721468889"},
        {"area": "Fulbari", "phone": "01721468889"},

        {"area": "Panchagarh", "phone": "01769672598"},
        {"area": "Panchagarh Sadar", "phone": "01769676721"},
        {"area": "Tetulia", "phone": "01769675006"},
        {"area": "Atwari", "phone": "01769672598"},
        {"area": "Debiganj", "phone": "01769672598"},
        {"area": "Boda", "phone": "01769672598"},

        {"area": "Thakurgaon", "phone": "01769672616"},
        {"area": "Thakurgaon Airfield", "phone": "01769662626"},
        {"area": "Thakurgaon BTV & Radio Station", "phone": "01829675086"},
        {"area": "Thakurgaon Sadar", "phone": "01769672616"},
        {"area": "Baliadangi", "phone": "01769672616"},
        {"area": "Pirganj (Thakurgaon)", "phone": "01769672616"},
        {"area": "Haripur", "phone": "01769672616"},
        {"area": "Ranishankail", "phone": "01769672616"},

        {"area": "Nilphamari", "phone": "01769682388"},
        {"area": "Saidpur Airport", "phone": "01814753599"},
        {"area": "Nilphamari Sadar", "phone": "01769682388"},
        {"area": "Dimla", "phone": "01769682388"},
        {"area": "Jaldhaka", "phone": "01769682388"},
        {"area": "Kishoreganj (Nilphamari)", "phone": "01769682388"},
        {"area": "Domar", "phone": "01769682388"},
        {"area": "Saidpur", "phone": "01814753599"},

        {"area": "Lalmonirhat", "phone": "01769682360"},
        {"area": "Lalmonirhat Military Farm", "phone": "01769511740"},
        {"area": "Lalmonirhat Sadar", "phone": "01769682360"},
        {"area": "Kaliganj", "phone": "01769682360"},
        {"area": "Aditmari", "phone": "01769682360"},
        {"area": "Hatibandha", "phone": "01769682360"},
        {"area": "Patgram", "phone": "01769682366"},

        {"area": "Gaibandha", "phone": "01625462588"},
        {"area": "Gaibandha Sadar", "phone": "01625462588"},
        {"area": "Sundarganj", "phone": "01791468487"},
        {"area": "Palashbari", "phone": "01791468488"},
        {"area": "Sadullapur", "phone": "01791468488"},
        {"area": "Fulchhari", "phone": "01791468488"},
        {"area": "Saghata", "phone": "01791468488"},
        {"area": "Gobindaganj", "phone": "01791468488"},

        {"area": "Kurigram", "phone": "01769662546"},
        {"area": "Kurigram Sadar", "phone": "01769662546"},
        {"area": "Ulipur", "phone": "01769662546"},
        {"area": "Chilmari", "phone": "01769662546"},
        {"area": "Fulbari (Kurigram)", "phone": "01769662546"},
        {"area": "Nageshwari", "phone": "01769662546"},
        {"area": "Bhurungamari", "phone": "01769662546"},
        {"area": "Rajarhat", "phone": "01769662546"},
        {"area": "Roumari", "phone": "01769662546"},
        {"area": "Rajibpur", "phone": "01769662546"}
      ]
    }


  ];
    // Add more divisions here

  List<Map<String, dynamic>> get filteredDivisions {
    if (_searchQuery.isEmpty) {
      return allContacts;
    }
    return allContacts
        .where((division) => division['title']
        .toLowerCase()
        .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void navigateToContacts(BuildContext context, Map<String, dynamic> division) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DivisionContactsPage(
          divisionTitle: division['title'],
          contacts: division['contacts'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA8D5A2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Contact Book',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                      ),
                      const Icon(Icons.search, color: Color(0xFF006400)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ...filteredDivisions.map((division) => GestureDetector(
                  onTap: () => navigateToContacts(context, division),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(1, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFF006400),
                          child: Icon(Icons.call, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            division['title'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DivisionContactsPage extends StatelessWidget {
  final String divisionTitle;
  final List<Map<String, String>> contacts;

  const DivisionContactsPage({
    super.key,
    required this.divisionTitle,
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA8D5A2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          divisionTitle,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),  // 40 for bottom padding
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.phone, color: Color(0xFF006400)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${contact['area']} - ${contact['phone']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
