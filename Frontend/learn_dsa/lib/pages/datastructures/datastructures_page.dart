import 'package:flutter/material.dart';
import 'array/array_page.dart';

class DataStructuresPage extends StatelessWidget
{
  final VoidCallback toggleTheme;
  final String? userId;

  const DataStructuresPage({Key? key, required this.toggleTheme, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final VoidCallback safeToggleTheme = toggleTheme;

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("What is a Data Structure?"),
              _buildDescriptionText(
                "A data structure is a particular way of organising data in a computer so that it can be used effectively. The idea is to reduce the space and time complexities of different tasks.",
              ),
              const SizedBox(height: 20),

              _buildSectionTitle("Linear Data Structure"),
              _buildDescriptionText(
                "A data structure in which data elements are arranged sequentially or linearly, where each element is attached to its previous and next adjacent elements, is called a linear data structure.",
              ),

              const SizedBox(height: 20),
              _buildExpansionTile(
                context,
                title: "Array",
                content: "In real life, arrays can be used to store a list of student names in a classroom.",
                buttons: [
                  "Regular Array",
                  "Dynamic Array",
                  "Struct Array"
                ],
              ),
              const SizedBox(height: 10),
              _buildExpansionTile(
                context,
                title: "Stack",
                content: "A stack can be used for undo functionality in software.",
              ),
              const SizedBox(height: 10),
              _buildExpansionTile(
                context,
                title: "Queue",
                content: "A queue can be used in a print queue to manage print jobs.",
                buttons: [
                  "Regular Queue",
                  "Circular Queue",
                  "Priority Queue"
                ],
              ),
              const SizedBox(height: 10),
              _buildExpansionTile(
                context,
                title: "List",
                content: "A list can be used to manage a collection of items in a shopping cart.",
                buttons: [
                  "Single Linked List",
                  "Double Linked List",
                  "Sorted List"
                ],
              ),
              const SizedBox(height: 20),

              _buildSectionTitle("Non-Linear Data Structure"),
              _buildDescriptionText(
                "Data structures where data elements are not placed sequentially or linearly are called non-linear data structures.",
              ),

              const SizedBox(height: 20),
              _buildExpansionTile(
                context,
                title: "Binary Tree",
                content: "A binary tree can be used for fast searching in a phone book.",
              ),
              const SizedBox(height: 10),
              _buildExpansionTile(
                context,
                title: "Hashtable",
                content: "A hashtable can be used for storing key-value pairs, such as user login credentials.",
              ),
              const SizedBox(height: 10),
              _buildExpansionTile(
                context,
                title: "Graph",
                content: "A graph can be used to represent a social network, where nodes are people and edges are connections.",
                buttons: [
                  "Balanced Graph",
                  "Even Graph",
                  "Directed Graph",
                  "Undirected Graph",
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionText(String text)
  {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple[100], //Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurpleAccent,
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context, {
    required String title,
    required String content,
    List<String>? buttons,
  }) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.deepPurple : Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkTheme ? Colors.white : Colors.white,
            ),
          ),
          initiallyExpanded: false,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkTheme ? Colors.grey[700] : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white70 : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (buttons != null) ...[
                    for (var button in buttons)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            if (button == "Regular Array") {
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
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: isDarkTheme ? Colors.blueAccent : Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            button,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
