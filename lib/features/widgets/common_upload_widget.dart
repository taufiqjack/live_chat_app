import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_chat_app/features/profile/controller/profile_controller.dart';
import 'package:live_chat_app/routes/route.dart';

void uploadwidget(BuildContext context, ProfileController controller) async {
  return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: Go.height / 2.5,
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Foto Profil",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            FontAwesomeIcons.trashAlt,
                            size: 20,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                  await controller
                                      .onPickImage(ImageSource.camera);
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.purple.shade500),
                                  child: const Icon(
                                    FontAwesomeIcons.camera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text("Kamera")
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                  await controller
                                      .onPickImage(ImageSource.gallery);
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.purple.shade500),
                                  child: const Icon(
                                    FontAwesomeIcons.image,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text("Galeri")
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        );
      });
}
