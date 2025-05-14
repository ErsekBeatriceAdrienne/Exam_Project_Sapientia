import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../helpers/essentials.dart';

class CollapsibleCodeBlock extends StatefulWidget {
  final String title;
  final String codeContent;

  const CollapsibleCodeBlock({Key? key, required this.title, required this.codeContent}) : super(key: key);

  @override
  State<CollapsibleCodeBlock> createState() => _CollapsibleCodeBlockState();
}

class _CollapsibleCodeBlockState extends State<CollapsibleCodeBlock> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        animationDuration: const Duration(milliseconds: 300),
        expansionCallback: (_, __) => setState(() => _isExpanded = !_isExpanded),
        children: [
          ExpansionPanel(
            isExpanded: _isExpanded,
            canTapOnHeader: true,
            backgroundColor: Colors.transparent,
            headerBuilder: (context, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color(0xFF1f7d53),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.black),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: widget.codeContent));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context)!.code_copied_text),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.all(16),
                            elevation: 6,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Essentials().buildHighlightedCodeLines(widget.codeContent),
            ),
          ),
        ],
      ),
    );
  }
}