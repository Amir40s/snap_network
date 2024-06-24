class ReferralUserModel {
  String id;
  String name;
  String email;
  String phone;
  String referral;
  String username;
  String userLevel;
  String balance;
  int referralCount;

  ReferralUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.referral,
    required this.username,
    required this.balance,
    required this.userLevel,
    required this.referralCount,
  });

  factory ReferralUserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ReferralUserModel(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      username: data['username'] ?? '',
      balance: data['balance'] ?? '',
      userLevel: data['userLevel'] ?? '',
      referral: data['referral'] ?? '',
      referralCount: 0, // to be computed later
    );
  }
}
