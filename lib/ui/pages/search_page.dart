import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/firebase_provider.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/empty_widget.dart';
import '../widgets/user_item.dart';

class UsersSearchPage extends StatefulWidget {
  const UsersSearchPage({Key? key}) : super(key: key);

  @override
  State<UsersSearchPage> createState() => _UsersSearchPageState();
}

class _UsersSearchPageState extends State<UsersSearchPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.black,
          title: const Text(
            'Users Search',
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              CustomTextFormField(
                controller: controller,
                hintText: 'Search',
                onChanged: (val) =>
                    Provider.of<FirebaseProvider>(context, listen: false)
                        .searchUser(val),
              ),
              Consumer<FirebaseProvider>(
                builder: (context, value, child) => Expanded(
                  child: controller.text.isEmpty
                      ? const EmptyWidget(icon: Icons.search,text: 'Not Found',)
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: value.search.length,
                          itemBuilder: (context, index) =>
                              value.search[index].uid !=
                                      FirebaseAuth.instance.currentUser?.uid
                                  ? UserItem(user: value.search[index])
                                  : const SizedBox(),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
}
