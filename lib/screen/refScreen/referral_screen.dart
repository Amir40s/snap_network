import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_network/constant.dart';
import 'package:snap_network/provider/account/account_provider.dart';
class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final referralProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Referral List'),
      ),
      body: FutureBuilder(
        future: referralProvider.fetchReferrals(auth.currentUser!.uid.toString()), // Replace with main user ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ReferralList(referrals: referralProvider.referrals);
        },
      ),
    );
  }
}

class ReferralList extends StatelessWidget {
  final Map<String, List<DocumentSnapshot>> referrals;

  const ReferralList({required this.referrals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: referrals[auth.currentUser!.uid.toString()]?.length ?? 0,
      itemBuilder: (context, index) {
        DocumentSnapshot user = referrals[auth.currentUser!.uid.toString()]![index];
        return ReferralItem(user: user, referrals: referrals);
      },
    );
  }
}

class ReferralItem extends StatelessWidget {
  final DocumentSnapshot user;
  final Map<String, List<DocumentSnapshot>> referrals;

  const ReferralItem({required this.user, required this.referrals});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(user['name']),
      children: referrals[user.id]?.map((referral) {
        return ListTile(
          title: Text(referral['name']),
          subtitle: ReferralItem(user: referral, referrals: referrals),
        );
      }).toList() ?? [],
    );
  }
}
