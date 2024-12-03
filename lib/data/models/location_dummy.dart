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
    name: 'Umred Karhandla Wildlife Sanctuary',
    locality: 'Nagpur',
    taluka: 'Seloo',
    district: 'Nagpur',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi, Gujarati, Sindhi, and Punjabi',
    elevation: '256 meters above sea level',
    telephoneCode: '07155',
    description:
        'Located about 50 km from Nagpur city, Umred Karhandla is a famous wildlife sanctuary. Home to a diverse range of flora and fauna, it’s a natural habitat for tigers, leopards, and many endangered species.',
    image: 'assets/locations/another-regal-pose.jpg',
  ),
  Location(
    name: 'Futala Lake',
    locality: 'Futala',
    taluka: 'Nagpur',
    district: 'Nagpur',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi, Hindi, and English',
    elevation: '310 meters above sea level',
    telephoneCode: '0712',
    description:
        'A popular evening spot for locals and tourists, Futala Lake is known for its scenic beauty and vibrant surroundings. A great place for a stroll or to experience the bustling nightlife of Nagpur.',
    image:
        'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0a/a9/92/cd/clean-and-variety-of.jpg?w=1200&h=1200&s=1',
  ),
  Location(
    name: 'Ambazari Lake and Garden',
    locality: 'Ambazari',
    taluka: 'Nagpur',
    district: 'Nagpur',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi, Hindi, and English',
    elevation: '310 meters above sea level',
    telephoneCode: '0712',
    description:
        'Ambazari Lake, one of the largest lakes in Nagpur, is surrounded by a beautiful garden. It’s perfect for boating, picnics, or a relaxing evening stroll.',
    image: 'https://i.ytimg.com/vi/tm9DDKJNWv8/maxresdefault.jpg',
  ),
  Location(
    name: 'Deekshabhoomi',
    locality: 'Ramdaspeth',
    taluka: 'Nagpur',
    district: 'Nagpur',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi, Hindi, and English',
    elevation: '315 meters above sea level',
    telephoneCode: '0712',
    description:
        'Deekshabhoomi is a significant monument where Dr. B.R. Ambedkar converted to Buddhism. A place symbolizing equality and social justice, it attracts followers and tourists from all over the world.',
    image:
        'https://i.pinimg.com/736x/ab/f4/64/abf46402449096d981a54ac9982ac060.jpg',
  ),
  Location(
    name: 'Ramtek Fort Temple',
    locality: 'Ramtek',
    taluka: 'Ramtek',
    district: 'Nagpur',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi, Hindi, and English',
    elevation: '345 meters above sea level',
    telephoneCode: '07114',
    description:
        'Located on a hill, Ramtek Fort Temple is an ancient temple dedicated to Lord Rama. The site offers breathtaking views of the surrounding landscape and has deep mythological significance.',
    image:
        'https://tse4.mm.bing.net/th?id=OIP.PxA0VFj4YsYLAi_i66Vd9wHaD8&pid=Api&P=0&h=180',
  ),
  Location(
    name: 'Dragon Palace Temple',
    locality: 'Kamptee',
    taluka: 'Nagpur',
    district: 'Nagpur',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi, Hindi, and English',
    elevation: '300 meters above sea level',
    telephoneCode: '0712',
    description:
        'A beautiful Buddhist temple known for its peaceful atmosphere and striking architecture, Dragon Palace Temple is a popular spot for meditation and spiritual relaxation.',
    image:
        'http://hoteljasnagra.com/wp-content/uploads/2018/05/DRAGAN-PALACE-KAMATHI.jpg',
  ),
  Location(
    name: 'Maharajbagh Zoo',
    locality: 'Sitabuldi',
    taluka: 'Nagpur',
    district: 'Nagpur',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi, Hindi, and English',
    elevation: '315 meters above sea level',
    telephoneCode: '0712',
    description:
        'Maharajbagh Zoo is home to a variety of wildlife and is a great place for children and adults alike. Located in the heart of Nagpur, it offers a green oasis in the city.',
    image:
        'https://tse1.mm.bing.net/th?id=OIP.qXhkmKoTKvSiUTnMXvarEwHaEC&pid=Api&P=0&h=180',
  ),
  Location(
    name: 'Seminary Hills',
    locality: 'Civil Lines',
    taluka: 'Nagpur',
    district: 'Nagpur',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi, Hindi, and English',
    elevation: '320 meters above sea level',
    telephoneCode: '0712',
    description:
        'Seminary Hills is a popular spot for morning walks and nature enthusiasts, offering scenic views of Nagpur city. The area is surrounded by dense greenery and is home to many bird species.',
    image:
        'https://tse4.mm.bing.net/th?id=OIP.tj-6y01wqB8QzaJ-GosLuQHaDm&pid=Api&P=0&h=180',
  ),
  Location(
    name: 'Sitabuldi Fort',
    locality: 'Sitabuldi',
    taluka: 'Nagpur',
    district: 'Nagpur',
    state: 'Maharashtra',
    region: 'Vidarbha',
    division: 'Nagpur',
    language: 'Marathi, Hindi, and English',
    elevation: '315 meters above sea level',
    telephoneCode: '0712',
    description:
        'Sitabuldi Fort is a historic site located in the heart of Nagpur, known for its role in the battle between the British and the Maratha Empire. It offers panoramic views of the city and is an important landmark.',
    image:
        'https://tse1.mm.bing.net/th?id=OIP.FRHl-FXIz18ETqSTBcyWkQHaE-&pid=Api&P=0&h=180',
  ),
  // Add more hidden and known places around Nagpur as needed
];
