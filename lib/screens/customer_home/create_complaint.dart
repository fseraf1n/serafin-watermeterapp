import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:water_metering_app/screens/customer_home/contact_us.dart';
import 'package:water_metering_app/utils/colors.dart';
import 'package:water_metering_app/utils/constants.dart';
import 'package:water_metering_app/utils/utils.dart';

class CreateComplaint extends StatefulWidget {
  const CreateComplaint({Key? key}) : super(key: key);

  @override
  State<CreateComplaint> createState() => _CreateComplaintState();
}

class _CreateComplaintState extends State<CreateComplaint> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Submit Ticket'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Complaint Details Form Field
              const Text('Complaint Information'),
              TextFormField(
                maxLines: 8,
                controller: _descriptionController,
                decoration: textInputDecoration.copyWith(
                    hintText: 'Enter complaint information'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter your complaint details.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),

              // Add Optional Image
              const Text('Upload Image of Water Meter'),
              const Text('Optional'),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: Center(
                  child: _file != null
                      ? Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                            ),
                          ),
                        )
                      : const Text('Please select an image'),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton.icon(
                    label: const Text('Upload Photo'),
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () async {
                      Uint8List file = await pickImage(
                        ImageSource.camera,
                      );
                      setState(() {
                        _file = file;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      onPrimary: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // Submit Complaint Button
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: const Text('Submit Ticket'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Success');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
