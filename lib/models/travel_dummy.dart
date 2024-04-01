// Define a class for the travel destination

class TravelDestination {
  final String image;
  final String location;
  final String description;

  TravelDestination({
    required this.image,
    required this.location,
    required this.description,
  });
}

// Dummy data list
List<TravelDestination> dummyData = [
  TravelDestination(
    // image: 'assets/images/on1.jpg',
    image:
        'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0a/a9/92/cd/clean-and-variety-of.jpg?w=1200&h=1200&s=1',
    location: 'Futala,Nagpur',
    description:
        'Paris, the capital city of France, is widely regarded as one of the most beautiful cities in the world. It is known for its iconic landmarks such as the Eiffel Tower, Notre-Dame Cathedral, and the Louvre Museum.',
  ),
  TravelDestination(
    image: 'assets/images/n2.jpg',
    location: 'Kyoto, Japan',
    description:
        'Kyoto, a city on the island of Honshu in Japan, is famous for its classical Buddhist temples, as well as gardens, imperial palaces, Shinto shrines, and traditional wooden houses.',
  ),
  // Add more destinations as needed
];

// Example usage of the dummy data in your ListView.builder
