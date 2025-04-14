import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_chat_app/core/services/user_service.dart';
import 'package:live_chat_app/features/profile/view/profile_view.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';

class ProfileController extends State<ProfileView> {
  @override
  void initState() {
    ToastContext().init(context);
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  File? imageFile;
  dynamic pickImageError;
  final picker = ImagePicker();

  Future<void> cropImage() async {
    final cropped = await ImageCropper()
        .cropImage(sourcePath: imageFile!.path, uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.green.shade800,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          hideBottomControls: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
        cancelButtonTitle: 'Batal',
        doneButtonTitle: 'Gunakan',
        resetButtonHidden: true,
        rotateButtonsHidden: true,
        aspectRatioPickerButtonHidden: true,
        aspectRatioLockEnabled: true,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
      )
    ]);
    if (cropped != null) {
      imageFile = File(cropped.path);
      setState(() {});
    } else {
      imageFile = null;
      setState(() {});
    }
  }

  onPickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
      setState(() {});
    } catch (e) {
      pickImageError = e;
    }
    if (imageFile != null) {
      await cropImage();
      final newProfilePic =
          await uploadPhoto(childName: 'profile', isPost: true);
      await UserService.updateProfil(newProfilePic!);
      return Toast.show(
        'Sukses update profil!',
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    }
    setState(() {});
  }

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> uploadPhoto({
    required String childName,
    required bool isPost,
  }) async {
    Reference ref =
        firebaseStorage.ref().child(childName).child(auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putFile(imageFile!);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
