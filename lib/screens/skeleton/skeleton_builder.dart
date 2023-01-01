import 'package:flutter/material.dart';

import 'components/skeleton_container.dart';

class SkeletonCardBuilder extends StatelessWidget {
  const SkeletonCardBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: skeletonEnvelopList(context),
      ),
    );
  }

  ListTile skeletonEnvelopList(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      leading: Container(
        padding: const EdgeInsets.only(
          right: 12.0,
        ),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1.0,
              color: Colors.white24,
            ),
          ),
        ),
        child: const Icon(Icons.account_balance_wallet),
      ),
      title: EnvelopSkeleton.square(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 15.0,
      ),
      subtitle: EnvelopSkeleton.square(
        width: MediaQuery.of(context).size.width * 0.2,
        height: 12.0,
      ),
    );
  }
}
