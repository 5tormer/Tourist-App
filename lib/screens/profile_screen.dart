import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourist_app/services/firebase_firestore_service.dart';
import 'package:tourist_app/services/firebase_storage_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _descriptionTextController =
      TextEditingController();
  String? description;
  List<String>? keySkills;
  String? avatarLink;

  FirebaseStorageService firebaseStorageService = FirebaseStorageService();
  FirebaseFirestoreService firebaseFirestoreService =
      FirebaseFirestoreService();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) => init(
          db: firebaseFirestoreService,
          userEmail: context.read<User?>()!.email!,
        ));
    super.initState();
  }

  Future<void> init(
      {required FirebaseFirestoreService db, required String userEmail}) async {
    await getDescriptionData(db: db, userEmail: userEmail);
    await getProfileImage(userEmail);
  }

  Future<void> getDescriptionData(
      {required FirebaseFirestoreService db, required String userEmail}) async {
    try {
      description = (await db.getDataFromCollection(
        userEmail: userEmail,
        collectionName: 'description',
        key: 'text',
      ))!
          .first;
      setState(() {});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setDescriptionData({
    required FirebaseFirestoreService db,
    required String userEmail,
    required String text,
  }) async {
    await db.setDataForCollection(
      userEmail: userEmail,
      collectionName: 'description',
      text: text,
    );
    setState(() {});
  }

  Future<void> setProfileImage(String userEmail) async {
    await firebaseStorageService.setProfileImage(userEmail);
  }

  Future<void> getProfileImage(String userEmail) async {
    avatarLink = await firebaseStorageService.getProfileImage(userEmail);
    setState(() {});
  }

  Future<void> _showMyDialog(onPressed) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Редактировать описание'),
          content: TextFormField(
            controller: _descriptionTextController,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Изменить'),
              onPressed: () async {
                await onPressed();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<User?>(
        builder: (_, user, ___) {
          return user == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      avatarLink == null
                          ? GestureDetector(
                              onTap: () async {
                                await setProfileImage(user.email!);
                                await getProfileImage(user.email!);
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    user.email!.split('@')[0].substring(0, 1) +
                                        ' ' +
                                        user.email!
                                            .split('@')[1]
                                            .substring(0, 1),
                                    style: const TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                await setProfileImage(user.email!);
                                await getProfileImage(user.email!);
                              },
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage(
                                  avatarLink!,
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                      Text(user.email!, style: const TextStyle(fontSize: 20)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'О себе',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showMyDialog(() async {
                            await setDescriptionData(
                              db: firebaseFirestoreService,
                              userEmail: context.read<User?>()!.email!,
                              text: _descriptionTextController.text,
                            );
                            await getDescriptionData(
                              db: firebaseFirestoreService,
                              userEmail: context.read<User?>()!.email!,
                            );
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              description ?? 'Добавьте описание',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
