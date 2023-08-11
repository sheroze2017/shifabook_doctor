import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shifabook_doctor/Controller/doctorData/landmark.dart';

class SearchableDialog extends StatefulWidget {
  @override
  _SearchableDialogState createState() => _SearchableDialogState();
}

class _SearchableDialogState extends State<SearchableDialog> {
  TextEditingController _searchController = TextEditingController();
  List<String> locations = [
    'Dow University Ojha Campus',
    'Darul Sehat',
    'The Clinic 24/7'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(16.0),
      title: Text('Select a Location'),
      content: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Search',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: (pattern) async {
          return locations.where((location) =>
              location.toLowerCase().contains(pattern.toLowerCase()));
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              Navigator.pop(context, locations.indexOf(suggestion) + 1);
            },
          );
        },
        onSuggestionSelected: (suggestion) {
          Navigator.pop(context, locations.indexOf(suggestion) + 1);
        },
      ),
    );
  }
}
