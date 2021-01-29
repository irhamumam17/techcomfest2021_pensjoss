part of '../pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Size get size => MediaQuery.of(context).size;

  TabController tabController;

  final bubleTabIndicator = BubbleTabIndicator(
    indicatorHeight: 34.0,
    indicatorColor: Colors.grey[300],
  );

  int activeTab = 1;

  bool isLoading = false;

  void logout() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<AuthProvider>(context, listen: false).logout();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: activeTab,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Tab Bar Widget
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 22),
                  color: Colors.white,
                  child: TabBar(
                    controller: tabController,
                    indicator: bubleTabIndicator,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      IconText(
                        icon: MdiIcons.formDropdown,
                        text: 'Riwayat',
                      ),
                      IconText(
                        icon: MdiIcons.home,
                        text: 'Home',
                      ),
                      IconText(
                        icon: MdiIcons.account,
                        text: 'Profil',
                      ),
                    ],
                  ),
                ),
              ),
              // Tab View Slider
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    RiwayatPage(),
                    MainPage(),
                    AkunPage(logout: logout),
                  ],
                ),
              ),
            ],
          ),
          if (isLoading) LoadingWidget(),
        ],
      ),
    );
  }
}
