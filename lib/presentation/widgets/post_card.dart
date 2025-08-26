import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hubline/config/app_theme.dart';

class PostCard extends StatelessWidget {
  final String userName;
  final String? userAvatar;
  final String postText;
  final String? postImage;
  final int likesCount;
  final int commentsCount;
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onShareTap;

  const PostCard({
    super.key,
    required this.userName,
    this.userAvatar,
    required this.postText,
    this.postImage,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.onLikeTap,
    this.onCommentTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: userAvatar != null
                        ? AssetImage(userAvatar!)
                        : null,
                    backgroundColor: const Color(0xFFF8F9FA),
                    child: userAvatar == null
                        ? Icon(
                            Icons.person,
                            color: AppTheme.primaryColor,
                            size: 22,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '2 horas',
                        style: GoogleFonts.urbanist(
                          fontSize: 13,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: PopupMenuButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: const Color(0xFF6B7280),
                      size: 20,
                    ),
                    offset: const Offset(-20, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.flag_outlined, size: 18, color: const Color(0xFF6B7280)),
                            const SizedBox(width: 12),
                            Text('Reportar', style: GoogleFonts.urbanist()),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.visibility_off_outlined, size: 18, color: const Color(0xFF6B7280)),
                            const SizedBox(width: 12),
                            Text('Ocultar', style: GoogleFonts.urbanist()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Post text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              postText,
              style: GoogleFonts.urbanist(
                fontSize: 15,
                color: const Color(0xFF374151),
                height: 1.5,
                letterSpacing: -0.1,
              ),
            ),
          ),

          // Post image (optional)
          if (postImage != null) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  postImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Actions row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                _ActionButton(
                  icon: Icons.favorite_outline,
                  count: likesCount,
                  onTap: onLikeTap,
                ),
                const SizedBox(width: 8),
                _ActionButton(
                  icon: Icons.comment_outlined,
                  count: commentsCount,
                  onTap: onCommentTap,
                ),
                const Spacer(),
                _ActionButton(
                  icon: Icons.share_outlined,
                  onTap: onShareTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    } else {
      return count.toString();
    }
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final int? count;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    this.count,
    this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    color: const Color(0xFF6B7280),
                    size: 18,
                  ),
                  if (widget.count != null) ...[
                    const SizedBox(width: 6),
                    Text(
                      _formatCount(widget.count!),
                      style: GoogleFonts.urbanist(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF374151),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    } else {
      return count.toString();
    }
  }
}