import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toefl/remote/api/profile_api.dart';
import 'package:toefl/remote/env.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/blue_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile(
      {super.key, required this.initialName, required this.initialImage});

  final String initialName;
  final String initialImage;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  File? image;
  bool isLoading = false;
  ProfileApi api = ProfileApi();

  String? validateName(String? value) {
    if (value!.length < 3) {
      return 'length_name'.tr();
    } else {
      return null;
    }
  }

  @override
  void initState() {
    _nameController.text = widget.initialName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text('edit_profile'.tr()),
      ),
      body: ListView(
        primary: false,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const CircleAvatar(
                  //   backgroundColor: Colors.transparent,
                  //   radius: 50,
                  //   backgroundImage:
                  //       AssetImage('assets/images/avatar_profile.png'),
                  // ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    backgroundImage: image != null
                        ? FileImage(image!)
                        : widget.initialImage.isNotEmpty
                            ? NetworkImage(
                                "${Env.storageUrl}/toefl/${widget.initialImage}")
                            : const AssetImage(
                                    'assets/images/avatar_profile.png')
                                as ImageProvider,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    splashColor: const Color(0xffE7E7E7).withOpacity(0.3),
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(type: FileType.image);

                      if (result != null) {
                        setState(() {
                          image = File(result.files.single.path!);
                        });
                      }
                    },
                    child: Text(
                      'change_picture'.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: HexColor(mariner600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _textField(
                          'label_name'.tr(),
                          false,
                          "input your name",
                          validateName,
                          _nameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        isLoading
                            ? CircularProgressIndicator(
                                color: HexColor(mariner700),
                              )
                            : BlueButton(
                                title: 'btn_update'.tr(),
                                size: 300,
                                onTap: () async {
                                  if (isLoading == false) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    final success = await api.updateProfile(
                                        image, _nameController.text);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (success && context.mounted) {
                                      Navigator.pop(context, true);
                                    }
                                  }
                                },
                              ),
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

  Widget _textField(
    String title,
    bool isEmail,
    String hintText,
    String? Function(String?)? validate,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6.0),
          TextFormField(
            inputFormatters: isEmail
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
                  ]
                : null,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor(mariner700)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: HexColor(neutral40),
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            validator: validate,
          ),
        ],
      ),
    );
  }
}
