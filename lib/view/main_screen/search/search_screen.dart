import 'package:flutter/material.dart';
import 'package:TourEase/core/helpers/helper.dart';
import '../../../core/constants/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      body: Container(
        color: dark ? AppColors.dark : AppColors.light2,
        child: SafeArea(
          child: Column(
            children: [
              _buildSearchBar(dark),
              _buildFilterChips(dark),
              Expanded(child: _buildSearchResults(dark)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(bool dark) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? Colors.black.withOpacity(0.2) : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(color: dark ? Colors.white : Colors.black87),
        decoration: InputDecoration(
          hintText: 'Search destinations...',
          hintStyle: TextStyle(color: dark ? Colors.white70 : Colors.black45),
          prefixIcon: Icon(Icons.search, color: dark ? Colors.white70 : Colors.black45),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear, color: dark ? Colors.white70 : Colors.black45),
            onPressed: () => _searchController.clear(),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildFilterChips(bool dark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: ['All', 'Popular', 'Recommended', 'Nearby']
            .map((filter) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: _selectedFilter == filter,
                    onSelected: (selected) {
                      setState(() => _selectedFilter = filter);
                    },
                    backgroundColor: dark ? Colors.black.withOpacity(0.3) : Colors.white.withOpacity(0.8),
                    selectedColor: AppColors.secondary,
                    labelStyle: TextStyle(
                      color: _selectedFilter == filter
                          ? Colors.white
                          : (dark ? Colors.white70 : Colors.black54),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildSearchResults(bool dark) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10, // Placeholder count
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: dark ? Colors.black.withOpacity(0.2) : Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://picsum.photos/100/100?random=$index',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'Destination ${index + 1}',
              style: TextStyle(
                color: dark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Lorem ipsum dolor sit amet',
              style: TextStyle(color: dark ? Colors.white70 : Colors.black54),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: dark ? Colors.white70 : Colors.black45),
          ),
        );
      },
    );
  }
}
