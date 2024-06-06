import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:toefl/models/friend.dart';
import 'package:toefl/remote/api/profile_api.dart';
import 'package:toefl/routes/route_key.dart';
import 'package:toefl/utils/colors.dart';
import 'package:toefl/utils/custom_text_style.dart';
import 'package:toefl/utils/hex_color.dart';
import 'package:toefl/widgets/common_app_bar.dart';
import 'package:toefl/widgets/search_text_field.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({
    super.key,
    this.searchFriend = false,
  });

  final bool searchFriend;

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  final searchController = TextEditingController();
  final ProfileApi profileApi = ProfileApi();
  List<Friend> users = [];
  List<Friend> friends = [];
  bool wasSearch = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.searchFriend) {
      initFriendList();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void initFriendList() async {
    setState(() {
      isLoading = true;
      wasSearch = true;
    });
    final friend = await profileApi.getAllFriend();
    setState(() {
      users = friend
          .map(
            (e) => Friend(
              id: e.id,
              name: e.nameUser,
              profileImage: e.profileImage,
            ),
          )
          .toList();
      friends = users;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: 'find_friend'.tr(),
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
                hintText: "search".tr(),
                onChanged: (value) async {
                  setState(() {
                    isLoading = true;
                  });
                  if (!widget.searchFriend) {
                    if (value.isNotEmpty) {
                      wasSearch = true;
                      users = await profileApi.searchSpecificUser(value);
                    }
                  } else {
                    if (friends.isNotEmpty) {
                      users = friends
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    }
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
                        wasSearch && !widget.searchFriend
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  "friend_result"
                                      .tr(args: [users.length.toString()]),
                                  style: CustomTextStyle.bold18.copyWith(
                                    color: HexColor(neutral60),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        users.isNotEmpty
                            ? Column(
                                children: List.generate(users.length, (index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RouteKey.profile,
                                              arguments: {
                                                'userId': users[index].id,
                                                "isMe": false
                                              });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
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
                                                style: CustomTextStyle.bold16
                                                    .copyWith(
                                                  color: HexColor(neutral70),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
