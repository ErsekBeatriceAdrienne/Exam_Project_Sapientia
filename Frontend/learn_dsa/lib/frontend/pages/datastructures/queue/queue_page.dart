import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_dsa/frontend/pages/datastructures/queue/queue_animations.dart';

import '../../../strings/datastructure_strings/queue_strings.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              pinned: true,
              floating: false,
              expandedHeight: 70,
              flexibleSpace: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.2),
                    child: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(left: 40, bottom: 20),
                      title: Text(
                        QueueStrings.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDFAEE8),
                        ),
                      ),
                    ),
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

                    const SizedBox(height: 15),

    // What is a stack?
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Queue description, what is a stack
                              Text(
                                QueueStrings.queue_definition,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Queue code example
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Center(
                                      child: Stack(
                                        children: [

                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            margin: const EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFDFAEE8),
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.15),
                                                  offset: const Offset(2, 2),
                                                  blurRadius: 6,
                                                  spreadRadius: 2,
                                                ),
                                              ],
                                            ),

                                            child: SelectableText(
                                              QueueStrings.queue_empty_initialization,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'monospace',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),

                                          // Copy button on right up corner
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.copy,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(text: QueueStrings.queue_empty_initialization,));
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Queue explanation
                                    Text(
                                      QueueStrings.queue_animation_title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    // Animation of the queue
                                    Center(
                                      child: AnimatedQueueWidget(),
                                    ),

                                    const SizedBox(height: 10),

                                    // Stack explanation
                                    Text(
                                      QueueStrings.queue_allocating_explanation,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

    // What is a Queue question box
                        Positioned(
                          top: -23,
                          left: 16,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                // Gradient colors
                                colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              QueueStrings.question,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

    // Functions Drop down
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              // Gradient colors
                              colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent,),
                            child:
                            ExpansionTile(
                              title: Text(
                                QueueStrings.functions_title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                              initiallyExpanded: false,
                              tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      // Allocating memory pseudo code title
                                      Text(
                                        QueueStrings.func_allocating_memory_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Allocating memory pseudo code
                                      Text(
                                        QueueStrings.func_allocating_memory,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // isFull pseudo code title
                                      Text(
                                        QueueStrings.func_isfull_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // isFull pseudo code
                                      Text(
                                        QueueStrings.func_isfull_explanation,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // isEmpty pseudo code title
                                      Text(
                                        QueueStrings.func_isempty_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // isEmpty pseudo code
                                      Text(
                                        QueueStrings.func_isempty_explanation,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Enqueue pseudo code title
                                      Text(
                                        QueueStrings.func_enqueue_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Enqueue pseudo code
                                      Text(
                                        QueueStrings.func_enqueue_explanation,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Dequeue pseudo code title
                                      Text(
                                        QueueStrings.func_dequeue_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Dequeue pseudo code
                                      Text(
                                        QueueStrings.func_dequeue_explanation,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Print pseudo code title
                                      Text(
                                        QueueStrings.func_display_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Print pseudo code
                                      Text(
                                        QueueStrings.func_display_explanation,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Destroy pseudo code title
                                      Text(
                                        QueueStrings.func_destroy_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Destroy pseudo code
                                      Text(
                                        QueueStrings.func_destroy_explanation,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),

                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
/*
    // Code Drop down
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              // Gradient colors
                              colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child:
                            ExpansionTile(
                              title: Text(
                                StackStrings.code_title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                              initiallyExpanded: false,
                              tilePadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      // Allocating memory pseudo code title
                                      Text(
                                        StackStrings.func_allocating_memory_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Allocating memory pseudo code comment
                                      Text(
                                        StackStrings.allocating_memory_function_comment,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Allocating array code with copy button
                                      Center(
                                        child: Stack(
                                          children: [
                                            // Code
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFDFAEE8),
                                                borderRadius: BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.15),
                                                    offset: const Offset(2, 2),
                                                    blurRadius: 6,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),

                                              child: SelectableText(
                                                StackStrings.allocating_memory_function,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'monospace',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            // Copy button on right up corner
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: StackStrings.allocating_memory_function,));
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Empty code title
                                      Text(
                                        StackStrings.func_isempty_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Empty code comment
                                      Text(
                                        StackStrings.func_isempty_comment,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // isEmpty code and copy button
                                      Center(
                                        child: Stack(
                                          children: [
                                            // Code
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFDFAEE8),
                                                borderRadius: BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.15),
                                                    offset: const Offset(2, 2),
                                                    blurRadius: 6,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),

                                              child: SelectableText(
                                                StackStrings.func_isempty,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'monospace',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            // Copy button on right up corner
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: StackStrings.func_isempty,));
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Full code title
                                      Text(
                                        StackStrings.func_isfull_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Full code comment
                                      Text(
                                        StackStrings.func_isfull_comment,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // isFull code and copy button
                                      Center(
                                        child: Stack(
                                          children: [
                                            // Code
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFDFAEE8),
                                                borderRadius: BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.15),
                                                    offset: const Offset(2, 2),
                                                    blurRadius: 6,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),

                                              child: SelectableText(
                                                StackStrings.func_isfull,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'monospace',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            // Copy button on right up corner
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: StackStrings.func_isfull,));
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Top code title
                                      Text(
                                        StackStrings.func_top_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Top code comment
                                      Text(
                                        StackStrings.func_top_comment,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Top code and copy button
                                      Center(
                                        child: Stack(
                                          children: [
                                            // Code
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFDFAEE8),
                                                borderRadius: BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.15),
                                                    offset: const Offset(2, 2),
                                                    blurRadius: 6,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),

                                              child: SelectableText(
                                                StackStrings.func_destroy,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'monospace',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            // Copy button on right up corner
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: StackStrings.func_destroy));
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Push code title
                                      Text(
                                        StackStrings.func_push_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Push code comment
                                      Text(
                                        StackStrings.func_push_comment,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Push code and copy button
                                      Center(
                                        child: Stack(
                                          children: [
                                            // Code
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFDFAEE8),
                                                borderRadius: BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.15),
                                                    offset: const Offset(2, 2),
                                                    blurRadius: 6,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),

                                              child: SelectableText(
                                                StackStrings.func_push,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'monospace',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            // Copy button on right up corner
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: StackStrings.func_push,));
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Pop code title
                                      Text(
                                        StackStrings.func_pop_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Pop code comment
                                      Text(
                                        StackStrings.func_pop_comment,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Pop code and copy button
                                      Center(
                                        child: Stack(
                                          children: [
                                            // Code
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFDFAEE8),
                                                borderRadius: BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.15),
                                                    offset: const Offset(2, 2),
                                                    blurRadius: 6,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),

                                              child: SelectableText(
                                                StackStrings.func_pop,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'monospace',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            // Copy button on right up corner
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: StackStrings.func_pop,));
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Size code title
                                      Text(
                                        StackStrings.func_size_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Size code comment
                                      Text(
                                        StackStrings.func_size_comment,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Size code and copy button
                                      Center(
                                        child: Stack(
                                          children: [
                                            // Code
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFDFAEE8),
                                                borderRadius: BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.15),
                                                    offset: const Offset(2, 2),
                                                    blurRadius: 6,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),

                                              child: SelectableText(
                                                StackStrings.func_size,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'monospace',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            // Copy button on right up corner
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: StackStrings.func_size));
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Deallocating memory code title
                                      Text(
                                        StackStrings.func_destroy_title,
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Deallocating memory code comment
                                      Text(
                                        StackStrings.func_destroy_comment,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // Deallocating memory code and copy button
                                      Center(
                                        child: Stack(
                                          children: [
                                            // Code
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFDFAEE8),
                                                borderRadius: BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.15),
                                                    offset: const Offset(2, 2),
                                                    blurRadius: 6,
                                                    spreadRadius: 2,
                                                  ),
                                                ],
                                              ),

                                              child: SelectableText(
                                                StackStrings.func_destroy,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'monospace',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            // Copy button on right up corner
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: StackStrings.func_destroy));
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Code copied!')),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

 */
                      ],
                    ),

                  ],
                ),
              ),
            ),

/*
            // How could we use this is life?
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Examples
                      Text(
                        ArrayStrings.where_to_use,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // When to use it question box
                Positioned(
                  top: -23,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // Gradient colors
                        colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      ArrayStrings.in_life_example,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // How could we use this is life?
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Examples
                      Text(
                        ArrayStrings.when_not_to,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // When to use it question box
                Positioned(
                  top: -23,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // Gradient colors
                        colors: [Color(0xFFa1f7ff), Color(0xFFDFAEE8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      ArrayStrings.not_to_use,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),*/
          ],
        )
    );
  }
}
