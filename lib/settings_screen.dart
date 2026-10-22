import 'package:flutter/cupertino.dart';
import '../constants.dart';
import '../services/storage_service.dart';
import '../widgets/ios_card.dart';

class SettingsScreen extends StatelessWidget {
  final StorageService storage;
  final Future<void> Function() onReloadData;

  const SettingsScreen({
    super.key,
    required this.storage,
    required this.onReloadData,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        IosCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('تطبيق مدينة جيرود الرسمي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 6),
              Text('دليل أدوار المياه، الصيدليات المناوبة، وأرقام الطوارئ في بلدة جيرود.', style: TextStyle(fontSize: 13, color: CupertinoColors.secondaryLabel)),
              SizedBox(height: 16),
              Center(
                child: Text(
                  'طُوّر من قِبل هيثم البوشي',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
