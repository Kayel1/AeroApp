import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GrowthLogEntry {
  GrowthLogEntry({required this.date, this.note, this.imagePath});
  final DateTime date;
  final String? note;
  final String? imagePath;
}

class GrowthLogPage extends StatefulWidget {
  const GrowthLogPage({super.key});
  @override
  State<GrowthLogPage> createState() => _GrowthLogPageState();
}

class _GrowthLogPageState extends State<GrowthLogPage> {
  final List<GrowthLogEntry> _entries = [];
  final TextEditingController _note = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1600);
    if (file != null) setState(() => _imagePath = file.path);
  }

  void _addEntry() {
    setState(() {
      _entries.insert(0, GrowthLogEntry(date: DateTime.now(), note: _note.text.trim().isEmpty ? null : _note.text.trim(), imagePath: _imagePath));
      _note.clear();
      _imagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Growth Log')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _note,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Daily note (e.g., Day 12: Lettuce reached 10cm)'),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              OutlinedButton.icon(onPressed: _pickImage, icon: const Icon(Icons.photo), label: const Text('Add photo')),
              const SizedBox(width: 12),
              if (_imagePath != null) Text('Selected', style: TextStyle(color: cs.primary)),
              const Spacer(),
              FilledButton.icon(onPressed: _addEntry, icon: const Icon(Icons.add), label: const Text('Add log')),
            ],
          ),
          const SizedBox(height: 16),
          for (final e in _entries)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                title: Text('${e.date.year}-${e.date.month.toString().padLeft(2, '0')}-${e.date.day.toString().padLeft(2, '0')}'),
                subtitle: e.note != null ? Text(e.note!) : null,
                leading: e.imagePath != null ? ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(File(e.imagePath!), width: 56, height: 56, fit: BoxFit.cover)) : const Icon(Icons.spa),
              ),
            ),
        ],
      ),
    );
  }
}


