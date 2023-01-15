import 'package:budget_planner_flutter/screens/envelops/add_envelop.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToAddEnvelop(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEnvelop.add(isUpdate: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardData.length,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: ((context, index) => OnboardContent(
                        image: onboardData[index].image,
                        title: onboardData[index].title,
                        description: onboardData[index].description,
                      )),
                ),
              ),
              Row(
                children: [
                  // DotIndicator(),
                  ...List.generate(
                    onboardData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_pageController.page == onboardData.length - 1) {
                          _navigateToAddEnvelop(context);
                          return;
                        }

                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        primary: Colors.blueGrey[400],
                      ),
                      child: const Icon(Icons.arrow_forward_sharp),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive ? Colors.blueGrey[400] : Colors.blueGrey[200],
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

final List<Onboard> onboardData = [
  Onboard(
    image: "assets/icons/onboard-envelop.png",
    title: "Make Smart Money Moves - Start Saving Wisely!!",
    description:
        """A budget is a plan for how you would like to spend or save money. You can use a budget to help you control your spending, pay down debt, or make room for the things.""",
  ),
  Onboard(
    image: "assets/icons/onboard-envelop.png",
    title: "Create envelops to create a budget",
    description:
        """Envelopes represent the different areas of spending that a person wants to keep track of, such as groceries, rent, utilities, entertainment, and so on""",
  ),
  Onboard(
    image: "assets/icons/onboard-envelop.png",
    title: "Fill your envelops",
    description:
        "You’ve Crafted a Budget to give each rupee a purpose in your life. Now you can fill your envelops",
  ),
  Onboard(
    image: "assets/icons/onboard-envelop.png",
    title: "Record your expenses",
    description:
        "You’ve done all the work of crafting, setting up, and filling your budget Envelopes. Now comes the most important part of any budget, using it!",
  ),
];

class Onboard {
  final String image, title, description;

  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardContent extends StatelessWidget {
  final String image, title, description;

  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
