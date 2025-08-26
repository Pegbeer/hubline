import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hubline/config/app_theme.dart';
import 'package:hubline/presentation/controllers/home_controller.dart';
import 'package:hubline/presentation/controllers/auth_controller.dart';
import 'package:hubline/presentation/pages/profile/profile_page.dart';
import 'package:hubline/presentation/widgets/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final AuthController authController = Get.find<AuthController>();

    final List<Widget> pages = [
      _FeedTab(),
      _ConnectionsTab(),
      _MessagesTab(),
      _NotificationsTab(),
      _ProfileTab(),
    ];

    return Scaffold(
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey(homeController.selectedIndex.value),
            child: pages[homeController.selectedIndex.value],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, -8),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavBarItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    label: 'feed'.tr,
                    isActive: homeController.selectedIndex.value == 0,
                    onTap: () => homeController.changeTab(0),
                  ),
                  _NavBarItem(
                    icon: Icons.people_outline,
                    activeIcon: Icons.people,
                    label: 'connections'.tr,
                    isActive: homeController.selectedIndex.value == 1,
                    onTap: () => homeController.changeTab(1),
                  ),
                  _NavBarItem(
                    icon: Icons.message_outlined,
                    activeIcon: Icons.message,
                    label: 'messages'.tr,
                    isActive: homeController.selectedIndex.value == 2,
                    onTap: () => homeController.changeTab(2),
                  ),
                  _NavBarItem(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'profile'.tr,
                    isActive: homeController.selectedIndex.value == 4,
                    onTap: () => homeController.changeTab(4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom Header
        Container(
          padding: const EdgeInsets.only(
            left: 24,
            top: 48,
            right: 24,
            bottom: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 20,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hubline',
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: const Color(0xFF1A1A1A),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Conecta con profesionales',
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // TODO: Implement search
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Color(0xFF6B7280),
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // TODO: Implement notifications
                      },
                      icon: Stack(
                        children: [
                          const Icon(
                            Icons.notifications_outlined,
                            color: Color(0xFF6B7280),
                            size: 22,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xFFF8F9FA),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                PostCard(
                  userName: 'Bessie Cooper',
                  postText:
                      'Beautiful moments always present on the track. They will not fade easily ✨',
                  postImage: 'assets/images/eiffel_tower.jpg',
                  likesCount: 2500,
                  commentsCount: 45,
                  onLikeTap: () {
                    // TODO: Implement like functionality
                  },
                  onCommentTap: () {
                    // TODO: Implement comment functionality
                  },
                  onShareTap: () {
                    // TODO: Implement share functionality
                  },
                ),
                PostCard(
                  userName: 'John Doe',
                  postText:
                      'Just had an amazing day at work! Grateful for the opportunities.',
                  likesCount: 123,
                  commentsCount: 12,
                  onLikeTap: () {
                    // TODO: Implement like functionality
                  },
                  onCommentTap: () {
                    // TODO: Implement comment functionality
                  },
                  onShareTap: () {
                    // TODO: Implement share functionality
                  },
                ),
                PostCard(
                  userName: 'Maria Garcia',
                  postText:
                      'Excited to announce that I\'ve joined a new project! Looking forward to new challenges and learning opportunities.',
                  postImage: 'assets/images/img.png',
                  likesCount: 89,
                  commentsCount: 7,
                  onLikeTap: () {
                    // TODO: Implement like functionality
                  },
                  onCommentTap: () {
                    // TODO: Implement comment functionality
                  },
                  onShareTap: () {
                    // TODO: Implement share functionality
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ConnectionsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('connections_coming_soon'.tr));
  }
}

class _MessagesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('messages_coming_soon'.tr));
  }
}

class _NotificationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('notifications_coming_soon'.tr));
  }
}

class _ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfilePage();
  }
}

class _NavBarItem extends StatefulWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.isActive) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(_NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.isActive
                        ? AppTheme.primaryColor.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Icon(
                      widget.isActive ? widget.activeIcon : widget.icon,
                      color: widget.isActive
                          ? AppTheme.primaryColor
                          : const Color(0xFF6B7280),
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.label,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    fontWeight: widget.isActive
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: widget.isActive
                        ? AppTheme.primaryColor
                        : const Color(0xFF6B7280),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
