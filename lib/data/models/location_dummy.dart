class Location {
  final String name;
  final String locality;
  final String taluka;
  final String district;
  final String state;
  final String region;
  final String division;
  final String language;
  final String elevation;
  final String telephoneCode;
  final String description;
  final String image;

  Location({
    required this.name,
    required this.locality,
    required this.taluka,
    required this.district,
    required this.state,
    required this.region,
    required this.division,
    required this.language,
    required this.elevation,
    required this.telephoneCode,
    required this.description,
    required this.image,
  });
}

final List<Location> locations = [
  Location(
    name: 'Ridhora',
    locality: 'रिधोरा',
    taluka: 'Seloo',
    district: 'Wardha',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi and Gujarati, Sindhi And Punjabi',
    elevation: '256 meters. Above Seal level',
    telephoneCode: '07155',
    description:
        "It's a day Picnic spot around Wardha. It has two attractions 1) Ridhora Dam and 2 ) Panchdahara Waterfall. The best part is it is in Leap of Nature and Just 21 Km from Wardha city center. You can reach here by two-wheeler and car. Ensure that you carry food with you as not many shops are available currently",
    image: 'assets/locations/ridhora.jpg',
  ),
  Location(
    name: 'Bor Dam ( Bordharan )',
    locality: 'रिधोरा',
    taluka: 'Seloo',
    district: 'Wardha',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi and Gujarati, Sindhi And Punjabi',
    elevation: '256 meters. Above Seal level',
    telephoneCode: '07155',
    description:
        'Add your description here now well to see this place know more',
    image: 'assets/locations/ridhora2.jpg',
  ),
  // Add more locations as needed
  Location(
    name: 'Umred Karhandla Wildlife Sanctuary',
    locality: 'Nagpur',
    taluka: 'Seloo',
    district: 'Wardha',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi and Gujarati, Sindhi And Punjabi',
    elevation: '256 meters. Above Seal level',
    telephoneCode: '07155',
    description:
        'Umred Karhandla Wildlife Sanctuary is a protected area located about 50 km from Nagpur city and 60 km from Bhandara district in the Indian state of Maharashtra. It is spread over the Pauni Tahsil of Bhandara district and the Umred, Kuhi, and Bhivapur Talukas of Nagpur district. The sanctuary is home to a diverse range of flora and fauna, including several endangered species.',
    image: 'assets/locations/another-regal-pose.jpg',
  ),
];
