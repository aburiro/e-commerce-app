import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Filter selections
  String selectedGender = 'All';
  Set<String> selectedBrands = {'Puma'};
  RangeValues priceRange = const RangeValues(16, 543);
  Set<String> selectedColors = {'Black', 'Yellow', 'Green'};

  final List<String> genders = ['All', 'Men', 'Women'];
  final List<String> brands = [
    'Adidas',
    'Puma',
    'CR7',
    'Nike',
    'Yeezy',
    'Supreme',
  ];
  final List<String> colors = [
    'White',
    'Black',
    'Grey',
    'Yellow',
    'Red',
    'Green',
  ];

  void _toggleBrand(String brand) {
    setState(() {
      if (selectedBrands.contains(brand)) {
        selectedBrands.remove(brand);
      } else {
        selectedBrands.add(brand);
      }
    });
  }

  void _toggleColor(String color) {
    setState(() {
      if (selectedColors.contains(color)) {
        selectedColors.remove(color);
      } else {
        selectedColors.add(color);
      }
    });
  }

  void _applyFilter() {
    // Create filter summary
    final filterSummary = {
      'gender': selectedGender,
      'brands': selectedBrands.toList(),
      'priceRange': priceRange,
      'colors': selectedColors.toList(),
    };

    print('Filters Applied: $filterSummary');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Filters applied! Gender: $selectedGender, Brands: ${selectedBrands.length}, Price: \$${priceRange.start.toInt()}-\$${priceRange.end.toInt()}, Colors: ${selectedColors.length}',
        ),
        duration: const Duration(milliseconds: 1200),
        backgroundColor: const Color(0xFF6C63FF),
      ),
    );

    // Return to previous screen with filters
    Navigator.pop(context, filterSummary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGenderSection(),
            _buildBrandSection(),
            _buildPriceRangeSection(),
            _buildColorSection(),
            _buildAnotherOptionSection(),
            _buildApplyFilterButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Filter',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildGenderSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gender',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: genders.map((gender) {
              bool isSelected = selectedGender == gender;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = gender;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF6C63FF)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        gender,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Brand',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: brands.map((brand) {
              bool isSelected = selectedBrands.contains(brand);
              return GestureDetector(
                onTap: () => _toggleBrand(brand),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6C63FF)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    brand,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price Range',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${priceRange.start.toInt()}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                '\$${priceRange.end.toInt()}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RangeSlider(
            values: priceRange,
            min: 0,
            max: 1000,
            activeColor: const Color(0xFF6C63FF),
            inactiveColor: Colors.grey[200],
            onChanged: (RangeValues values) {
              setState(() {
                priceRange = values;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Color',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: colors.map((color) {
              bool isSelected = selectedColors.contains(color);
              return GestureDetector(
                onTap: () => _toggleColor(color),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6C63FF)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    color,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAnotherOptionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Another option',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[600], size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildApplyFilterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: GestureDetector(
        onTap: _applyFilter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Apply Filter',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
