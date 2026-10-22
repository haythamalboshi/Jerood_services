import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/emergency_contact.dart';
import '../models/advertisement.dart';
import '../widgets/ad_banner.dart';
import '../widgets/ios_card.dart';

class EmergencyScreen extends StatelessWidget {
  final List<EmergencyContact> emergencyList;
  final List<Advertisement> adsList;
  final Future<void> Function() onRefresh;

  const EmergencyScreen({
    super.key,
    required this.emergencyList,
    required this.adsList,
    required this.onRefresh,
  });

  Future<void> _makeCall(EmergencyContact contact) async {
    final clean = contact.cleanDialNumber;
    final Uri uri = Uri.parse('tel:$clean');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: emergencyList.length,
      itemBuilder: (ctx, i) {
        final contact = emergencyList[i];
        return IosCard(
          onTap: () => _makeCall(contact),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(contact.entityName, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(contact.phoneNumber, style: TextStyle(color: CupertinoColors.activeGreen, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }
}
