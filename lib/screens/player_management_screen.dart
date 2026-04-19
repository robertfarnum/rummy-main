import 'package:flutter/material.dart';
import '../models/game.dart';

class PlayerManagementScreen extends StatefulWidget {
  const PlayerManagementScreen({super.key});

  @override
  State<PlayerManagementScreen> createState() => _PlayerManagementScreenState();
}

class _PlayerManagementScreenState extends State<PlayerManagementScreen> {
  final TextEditingController _nameController = TextEditingController();
  List<String> _savedPlayerNames = [];
  String? _selectedPlayerForEdit;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedPlayers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedPlayers() async {
    setState(() {
      _isLoading = true;
    });

    // Load saved player names
    _savedPlayerNames = await Game.getSavedPlayerNames();
    
    setState(() {
      _isLoading = false;
    });
  }

  void _addPlayer() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Player name cannot be empty')),
      );
      return;
    }

    // If this is an edit operation
    if (_selectedPlayerForEdit != null) {
      // Remove the old name and add the new one
      final index = _savedPlayerNames.indexOf(_selectedPlayerForEdit!);
      if (index != -1) {
        setState(() {
          _savedPlayerNames[index] = name;
          _selectedPlayerForEdit = null;
        });
      }
    } else {
      // Check if name already exists
      if (_savedPlayerNames.contains(name)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Player with this name already exists')),
        );
        return;
      }

      setState(() {
        _savedPlayerNames.add(name);
      });
    }

    // Save the updated list
    await Game.savePlayerNamesList(_savedPlayerNames);
    
    _nameController.clear();
  }

  void _editPlayer(String name) {
    setState(() {
      _selectedPlayerForEdit = name;
      _nameController.text = name;
    });
  }

  void _deletePlayer(String name) async {
    setState(() {
      _savedPlayerNames.remove(name);
    });

    // Save the updated list
    await Game.savePlayerNamesList(_savedPlayerNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Players'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _selectedPlayerForEdit != null ? 'Edit Player' : 'Add New Player',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Player Name',
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (_) => _addPlayer(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _addPlayer,
                                  child: Text(_selectedPlayerForEdit != null ? 'Update' : 'Add Player'),
                                ),
                              ),
                              if (_selectedPlayerForEdit != null) ...[
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedPlayerForEdit = null;
                                        _nameController.clear();
                                      });
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Saved Players',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _savedPlayerNames.isEmpty
                        ? const Center(child: Text('No saved players'))
                        : ListView.builder(
                            itemCount: _savedPlayerNames.length,
                            itemBuilder: (context, index) {
                              final name = _savedPlayerNames[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  title: Text(name),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => _editPlayer(name),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => _deletePlayer(name),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}