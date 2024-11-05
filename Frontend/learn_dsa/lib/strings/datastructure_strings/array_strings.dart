class ArrayStrings
{
  // App Bar title
  static const String title = 'Array' ;
  static const String introduction = 'Introduction';
  static const String definition_title = 'Definition';

  // Questions
  static const String question = 'What is an array ?!';
  static const String regular_array_initialization_question = 'But how do we write it in code?';
  static const String regular_array_initialization1 = ' - int array[ ] = { 15, 4 18, 9, 20 }; ?';
  static const String reg_array_final = ' - So.. int a [ ] = { 2, 3, 4 }; ?';


  // Answers
  static const String definition = '\t\t\t\tAn array is a collection of a datatype where the elements are stored along each-other so we can access every item quickly.\n\n Example :';
  static const String array_empty_explanation = '\t\t\tIf we run the code the memory for the array will be allocated. We didn\'t specify the elements so it\'s an empty array, but if you notice it\'s not actually empty. ';
  static const String example_image_explanation = 'This is an \' int \' type array, where the elements are integer numbers. We count the amount of items from 0, not 1, because the computer memory can’t. There is a solution to this, but first let’s understand the basics.';
  static const String reg_array_explanations = 'In C language first comes the type of the data that will be stored, for example \' int \' (integer numbers), then comes the name of the array e.g. \' a \', and the special brackets \' [] \' which is the symbol of an array. '
                      ' Then = and we can specify the elements inside curly brackets \' { } \' , and of course we need the closing \' ; \'';
  static const String initialization_done = 'Yes exactly! And for the array on the picture it would be int array [ ] = { 15, 4, 18, 9, 20 }; ';

  // Code snippets
  static const String array_empty_inicialization = '// C language\n#include <stdio.h>\n\nint main() \n{\n\t\t\t// empty int type array of size 5\n\t\t\tint a[5];\n\t\t\treturn 0;\n}';
}