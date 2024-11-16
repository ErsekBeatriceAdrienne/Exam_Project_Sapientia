import 'package:flutter/material.dart';
import 'array/array_page.dart';

class DataStructuresPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final String? userId;

  const DataStructuresPage(
      {Key? key, required this.toggleTheme, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with disappearing title on scroll
          SliverAppBar(
            backgroundColor: isDarkTheme ? Colors.black : Colors.white,
            pinned: false,
            floating: true,
            expandedHeight: 70,
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                "Data Structures",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
          ),

          // Main Content as a SliverList
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Title and Description in a rounded rectangle with shadow
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "What is a Data Structure?",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "A data structure is a particular way of organizing data in a computer so that it can be used effectively. The idea is to reduce the space and time complexities of different tasks.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Linear Data Structure Section
                  const Text(
                    "Linear Data Structure",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "A data structure in which data elements are arranged sequentially or linearly, where each element is attached to its previous and next adjacent elements, is called a linear data structure.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  // Linear Data Structure Buttons
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildCategoryButton(context, "Array", isDarkTheme),
                      _buildCategoryButton(context, "Stack", isDarkTheme),
                      _buildCategoryButton(context, "Queue", isDarkTheme),
                      _buildCategoryButton(context, "List", isDarkTheme),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Non-Linear Data Structure Section
                  const Text(
                    "Non-Linear Data Structure",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Data structures where data elements are not placed sequentially or linearly are called non-linear data structures.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  // Non-Linear Data Structure Buttons
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildCategoryButton(context, "Graph", isDarkTheme),
                      _buildCategoryButton(context, "Binary Tree", isDarkTheme),
                      _buildCategoryButton(context, "Hashtable", isDarkTheme),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Complexity Table Section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Data Structure Complexity Table",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Placeholder for table image or content
                        Text("Table image coming soon..."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
      BuildContext context, String title, bool isDarkTheme) {
    return ElevatedButton(
      onPressed: () {
        if (title == "Array") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArrayPage(
                toggleTheme: toggleTheme,
                userId: userId,
              ),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 8,
            right: 8,
            child: Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
