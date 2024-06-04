import 'package:flutter/material.dart';
import 'package:toefl/models/friend.dart';
import 'package:toefl/remote/api/profile_api.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/common_app_bar.dart';
import 'package:toefl/widgets/search_text_field.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({super.key});

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  final searchController = TextEditingController();
  final ProfileApi profileApi = ProfileApi();
  List<Friend> users = [];
  bool wasSearch = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: 'Find Friends',
        withBack: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              child: SearchTextField(
                controller: searchController,
                hintText: "Search...",
                onChanged: (value) async {
                  setState(() {
                    isLoading = true;
                  });
                  if (value.isNotEmpty) {
                    wasSearch = true;
                    users = await profileApi.searchSpecificUser(value);
                  }
                  setState(() {
                    wasSearch = true;
                    isLoading = false;
                  });
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 14.0),
            child: Divider(
              color: Color(0xffE7E7E7),
              thickness: 1,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            height: MediaQuery.of(context).size.height * 0.77,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: HexColor(mariner700),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          height: 16,
                        ),
                        wasSearch
                            ? Text(
                                "${users.length} Result",
                                style: CustomTextStyle.bold18.copyWith(
                                  color: HexColor(neutral60),
                                ),
                              )
                            : const SizedBox(
                                height: 10,
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        users.isNotEmpty
                            ? Column(
                                children: List.generate(users.length, (index) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 24,
                                            backgroundImage: NetworkImage(
                                                users[index].profileImage),
                                            backgroundColor:
                                                HexColor(mariner100),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            users[index].name,
                                            style:
                                                CustomTextStyle.bold16.copyWith(
                                              color: HexColor(neutral70),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: Color(0xffE7E7E7),
                                        thickness: 1,
                                      ),
                                    ],
                                  );
                                }),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
