
class UserModel {
  final String balance;
  final String date;
  final String time;
  final int timestamp;
  final String password;
  final String userUID;
  final String docID;
  final String name;
  final String phone;
  final String email;
  final String referral;
  final String username;
  final String wallet;
  final String mining;
  final String miningUnit;
  final String userLevel;
  final String isLevel1;
  final String isLevel2;
  final String isLevel3;

  UserModel({
    required this.docID,
    required this.balance,
    required this.date,
    required this.time,
    required this.timestamp,
    required this.password,
    required this.userUID,
    required this.name,
    required this.phone,
    required this.email,
    required this.referral,
    required this.username,
    required this.wallet,
    required this.mining,
    required this.miningUnit,
    required this.userLevel,
    required this.isLevel1,
    required this.isLevel2,
    required this.isLevel3,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      docID: documentId,
      timestamp: data['timestamp'].toInt() ?? 0,
      balance: data['balance'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      password: data['password'] ?? '',
      userUID: data['userUID'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      referral: data['referral'] ?? '',
      username: data['username'] ?? '',
      wallet: data['wallet'] ?? '',
      mining: data['mining'] ?? 'end',
      miningUnit: data['miningUnit'] ?? '0',
      userLevel: data['userLevel'] ?? '0',
      isLevel1: data['isLevel1'] ?? 'false',
      isLevel2: data['isLevel2'] ?? 'false',
      isLevel3: data['isLevel3'] ?? 'false',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': docID,
      'balance': balance,
      'date': date,
      'time': time,
      'timestamp': timestamp,
      'phone': phone,
      'userUID': userUID,
      'name': name,
      'email': email,
      'password': password,
      'referral': referral,
      'username': username,
      'wallet': wallet,
      'mining': mining,
      'miningUnit': miningUnit,
      'userLevel': userLevel,
      'isLevel1': isLevel1,
      'isLevel2': isLevel2,
      'isLevel3': isLevel3,
    };
  }
}
