import 'package:flutter/cupertino.dart';
import '../models/pharmacy.dart';
import '../models/advertisement.dart';
import '../widgets/ad_banner.dart';
import '../widgets/ios_card.dart';

class PharmaciesScreen extends StatelessWidget {
  final Pharmacy? dayPharmacy;
  final Pharmacy? nightPharmacy;
  final List<Pharmacy> allPharmacies;
  final List<Advertisement> adsList;
  final Future<void> Function() onRefresh;

  const PharmaciesScreen({
    super.key,
    required this.dayPharmacy,
    required this.nightPharmacy,
    required this.allPharmacies,
    required this.adsList,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: onRefresh),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AdBannerWidget(ads: adsList),
              // Shift 1: Day Pharmacy (ظهراً)
              IosCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('مناوبة ظهراً', style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.activeOrange)),
                    SizedBox(height: 8),
                    Text(dayPharmacy?.name ?? 'صيدلية النور', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(dayPharmacy?.address ?? 'جيرود - ساحة البلدية', style: TextStyle(color: CupertinoColors.secondaryLabel)),
                  ],
                ),
              ),
              // Shift 2: Night Pharmacy (ليلاً)
              IosCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('مناوبة ليلاً', style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.systemIndigo)),
                    SizedBox(height: 8),
                    Text(nightPharmacy?.name ?? 'صيدلية الشفاء', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(nightPharmacy?.address ?? 'جيرود - الشارع العام', style: TextStyle(color: CupertinoColors.secondaryLabel)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
