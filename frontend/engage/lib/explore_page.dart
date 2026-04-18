import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'survey_bottom_sheet.dart';
import 'activity_detail_page.dart';
import 'activity_model.dart';
import 'art_activities_page.dart';
import 'sound_activities_page.dart';
import 'movement_activities_page.dart';
import 'drama_activities_page.dart';
import 'storytelling_activities_page.dart';
import 'profile_page.dart';
import 'blog_detail_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _selectedIndex = 1; // Explore is selected

  final List<ModalityItem> _modalities = [
    ModalityItem(
      title: 'Art',
      description: 'Express through colour, shape, and image.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF8B1538),
          Color(0xFFB83D5E),
          Color(0xFFD67A8F),
          Color(0xFFE8A5B5),
        ],
      ),
      imagePath: 'assets/art1.png',
    ),
    ModalityItem(
      title: 'Sound',
      description: 'Use you voice, breath or sound to shift state.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF5B3A7A),
          Color(0xFF6B4C93),
          Color(0xFFFF6B35),
          Color(0xFFFFA500),
        ],
      ),
      imagePath: 'assets/music1.png',
    ),
    ModalityItem(
      title: 'Drama',
      description: 'Explore emotions through performance and storytelling.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1A2E3A),
          Color(0xFF2D4A5A),
          Color(0xFF3D6B7A),
          Color(0xFF4A8A9A),
        ],
      ),
      imagePath: 'assets/drama3.png',
    ),
    ModalityItem(
      title: 'Movement',
      description: 'Connect body and mind through physical expression.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2D5016), Color(0xFF4A7C2A), Color(0xFF6BA84F)],
      ),
      imagePath: 'assets/movement1.png',
    ),
    ModalityItem(
      title: 'Storytelling',
      description: 'Share narratives that shape understanding.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF6B2C5A),
          Color(0xFF8B3D6A),
          Color(0xFFAD5A7A),
          Color(0xFFCF7A9A),
        ],
      ),
      imagePath: 'assets/story5.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F3B40), // Dark teal background
      body: SafeArea(
        child: Column(
          children: [
            // Top section - "Let's check in" Survey
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Not sure where to start?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Let\'s check in.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Answer 3 questions, and we\'ll suggest something made for this moment.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const SurveyBottomSheet(),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Take survey',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Middle section - Modalities
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How would you like to engage right now?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Go with what feels right.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ..._modalities.map(
                      (modality) => _ModalityItemCard(modality: modality),
                    ),
                    const SizedBox(height: 40),
                    // Explore Activities section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Explore Activities',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.tune,
                          color: Colors.white.withOpacity(0.7),
                          size: 24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Go with what feels right.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Activity cards
                    _buildActivityCard(
                      title: 'Grounding with a Pencil',
                      description:
                          'Draw a freehand shape and reconnect with yourself through mindful movement.',
                      duration: '7 mins',
                      location: 'Anywhere',
                      imageColors: [
                        Color(0xFFE8D5B7),
                        Color(0xFFA8C5D1),
                        Color(0xFFF5F5DC),
                      ],
                      imagePath: 'assets/groundingpencil1.png',
                      isFavorite: false,
                      showDetails: true,
                      onArrowTap: () => _openExploreActivity(
                        activity: const Activity(
                          title: 'Grounding with a Pencil',
                          description:
                              'Draw a freehand shape and reconnect with yourself through mindful movement.',
                          duration: '7 mins',
                          location: 'Anywhere',
                          imagePath: 'assets/groundingpencil1.png',
                          imageColors: [
                            Color(0xFFE8D5B7),
                            Color(0xFFA8C5D1),
                            Color(0xFFF5F5DC),
                          ],
                          facilitatorName: 'Lucy',
                          facilitatorImagePath: 'assets/Lucy Image .jpg',
                        ),
                        modality: 'art',
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildActivityCard(
                      title: 'Body Scan',
                      description:
                          'A guided scan to reconnect with your body, one breath and sensation at a time.',
                      duration: '7 mins',
                      location: 'Anywhere',
                      imageColors: [
                        Color(0xFF2D5016),
                        Color(0xFF4A7C2A),
                        Color(0xFF6BA84F),
                      ],
                      imagePath: 'assets/bodyscan6.png',
                      isFavorite: false,
                      showDetails: true,
                      onArrowTap: () => _openExploreActivity(
                        activity: const Activity(
                          title: 'Body Scan',
                          description:
                              'A guided scan to reconnect with your body, one breath and sensation at a time.',
                          duration: '7 mins',
                          location: 'Anywhere',
                          imagePath: 'assets/bodyscan6.png',
                          imageColors: [
                            Color(0xFF2D5016),
                            Color(0xFF4A7C2A),
                            Color(0xFF6BA84F),
                          ],
                          facilitatorName: 'Naomi',
                          facilitatorImagePath: 'assets/naomi.jpeg',
                        ),
                        modality: 'movement',
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildActivityCard(
                      title: 'Paper play',
                      description:
                          'Use and deform papers to explore how you feel, create your own art arrangement.',
                      duration: '20 mins',
                      location: 'Creative Space',
                      imageColors: [
                        Color(0xFFD3D3D3),
                        Color(0xFFE8D5B7),
                        Color(0xFF90EE90),
                      ],
                      imagePath: 'assets/paper2.png',
                      isFavorite: false,
                      showDetails: true,
                      onArrowTap: () => _openExploreActivity(
                        activity: const Activity(
                          title: 'Paper play',
                          description:
                              'Use and deform papers to explore how you feel, create your own art arrangement.',
                          duration: '20 mins',
                          location: 'Creative Space',
                          imagePath: 'assets/paper2.png',
                          imageColors: [
                            Color(0xFFD3D3D3),
                            Color(0xFFE8D5B7),
                            Color(0xFF90EE90),
                          ],
                          facilitatorName: 'Lucy',
                          facilitatorImagePath: 'assets/Lucy Image .jpg',
                          sessionVideoAssets: [
                            'assets/videos/paper_play/01.mp4',
                            'assets/videos/paper_play/02.mp4',
                            'assets/videos/paper_play/03.mp4',
                            'assets/videos/paper_play/04.mp4',
                            'assets/videos/paper_play/05.mp4',
                            'assets/videos/paper_play/06.mp4',
                            'assets/videos/paper_play/07.mp4',
                            'assets/videos/paper_play/08.mp4',
                            'assets/videos/paper_play/09.mp4',
                          ],
                        ),
                        modality: 'art',
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Explore Blogs section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Explore Blogs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'View all',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Go with what feels right.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Blog cards
                    _buildBlogCard(
                      title: 'Unlocking Clarity',
                      description: 'The Surprising Power of Art Making for...',
                      imageColors: [
                        Color(0xFFFFD700),
                        Color(0xFFFF6B35),
                        Color(0xFF4A8A9A),
                        Color(0xFF90EE90),
                      ],
                      imagePath: 'assets/artblog6.png',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BlogDetailPage(
                              title: 'Unlocking Clarity: The Surprising Power of Art Making for Your Mind',
                              heroImagePath: 'assets/artblog6.png',
                              sections: [
                                BlogSection(
                                  heading: '',
                                  body:
                                      'In the midst of life\'s demands, we often find ourselves with a mind crowded by unresolved thoughts, stress, and emotional clutter. The search for clarity can feel like trying to find a single point of focus in an overwhelming landscape. But what if the simple act of creating art could help untangle these thoughts and bring clarity to the mind? This blog explores how engaging in art-making, whether through painting, drawing, or other forms of visual expression, can help clear mental clutter, increase emotional awareness, and bring about a deeper connection to our inner selves.',
                                ),
                                BlogSection(
                                  heading: 'Art as a Tool for Clarity',
                                  body:
                                      'Engaging in visual art is not only about creating something aesthetically pleasing; it serves as a powerful cognitive tool. Kaimal et al. (2016) found that creating art can lead to significant reductions in cortisol levels, the hormone primarily responsible for stress. This physiological shift supports the idea that art-making is more than just a creative outlet; it\'s a form of mindfulness that helps us process emotions and gain mental clarity. Art activates the brain\'s relaxation response, which reduces the noise and clutter that often clouds our ability to think clearly.\n\nIn line with this, Malchiodi (2012) highlights how art provides a pathway to the subconscious, allowing us to externalise emotions that might otherwise remain buried. The process of making art can open doors to insights about ourselves, enabling us to better understand our internal states. When we create, we begin to map the intangible - emotions, thoughts, and anxieties - onto a tangible form. This externalisation of emotions not only brings clarity to our minds but also helps us to engage with those emotions in a healthy, controlled manner.',
                                ),
                                BlogSection(
                                  heading: 'Art\'s Impact on Emotional Awareness',
                                  body:
                                      'The benefits of art extend far beyond cognitive clarity. Art allows us to engage with and better understand our emotions, offering a form of emotional release and awareness. Stuckey and Nobel (2010) emphasise that creative expression helps us cultivate cognitive flexibility. By engaging with a medium like art, we can gain fresh perspectives on problems that once felt insurmountable, enabling us to reframe our emotional responses and see our challenges through a new lens. This cognitive shift, facilitated by art, can help individuals approach life\'s difficulties with a sense of calm and clarity.\n\nMoreover, as Lutzker (2019) suggests, art-making provides a space for emotional processing, where individuals can gain a deeper understanding of their emotional patterns. Through observing and reflecting on their own art, individuals can become more attuned to their emotional responses and behaviours. Art allows us to recognise emotional patterns we may not be consciously aware of, providing a roadmap to personal growth and emotional clarity.',
                                ),
                                BlogSection(
                                  heading: 'Shifting Perspectives Through Art',
                                  body:
                                      'One of the most transformative aspects of art-making is its ability to shift our perspective. When we engage in creative processes, we step outside the confines of linear thinking and allow ourselves to explore different ways of seeing the world. This shift in perspective can be especially valuable when dealing with stress, trauma, or emotional overwhelm, providing an opportunity to recalibrate our emotional responses and find new ways of coping.\n\nCox et al. (2017) argue that art-making not only provides emotional clarity but also fosters problem-solving skills by encouraging innovative thinking. The act of creating something new - a painting, a sculpture, or even a sketch - can help us break free from old patterns of thought and gain a new perspective on personal challenges. By expressing our emotions through art, we create space to shift how we view ourselves and our experiences, which ultimately allows for greater mental clarity and emotional freedom.',
                                ),
                                BlogSection(
                                  heading: 'Conclusion',
                                  body:
                                      'One of the most transformative aspects of art-making is its ability to shift our perspective. When we engage in creative processes, we step outside the confines of linear thinking and allow ourselves to explore different ways of seeing the world. This shift in perspective can be especially valuable when dealing with stress, trauma, or emotional overwhelm, providing an opportunity to recalibrate our emotional responses and find new ways of coping.\n\nCox et al. (2017) argue that art-making not only provides emotional clarity but also fosters problem-solving skills by encouraging innovative thinking. The act of creating something new - a painting, a sculpture, or even a sketch - can help us break free from old patterns of thought and gain a new perspective on personal challenges. By expressing our emotions through art, we create space to shift how we view ourselves and our experiences, which ultimately allows for greater mental clarity and emotional freedom.',
                                ),
                              ],
                              references: [
                                'Kaimal, G., Ray, K., & Muniz, J. (2016). Reduction of cortisol levels and participants\' responses following art making. Art Therapy: Journal of the American Art Therapy Association, 33(2), 74-80. https://doi.org/10.1080/07421656.2016.1151247',
                                'Malchiodi, C. A. (2012). The art therapy sourcebook. New York: McGraw-Hill.',
                                'Stuckey, H. L., & Nobel, J. (2010). The connection between art, healing, and public health: A review of the literature. American Journal of Public Health, 100(2), 254-263. https://doi.org/10.2105/AJPH.2008.156497',
                                'Lutzker, J. R. (2019). Therapeutic benefits of creative activities for mental clarity. Journal of Mental Health Counseling, 41(3), 239-251. https://doi.org/10.17744/mehc.41.3.03',
                                'Cox, D., Moser, R., & Daniels, J. (2017). Art-making as a tool for emotional clarity and problem-solving. Journal of Counseling Psychology, 64(1), 102-114. https://doi.org/10.1037/cou0000213',
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildBlogCard(
                      title: 'The Power of gentle Move...',
                      description: 'Enhancing Wellbeing and Mental Health...',
                      imageColors: [
                        Color(0xFFFF6B35),
                        Color(0xFF4A8A9A),
                        Color(0xFF2D5016),
                      ],
                      imagePath: 'assets/movementblog2.png',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BlogDetailPage(
                              title: 'Power of Gentle Movement: Enhancing Wellbeing and Mental Health',
                              heroImagePath: 'assets/movementblog2.png',
                              sections: [
                                BlogSection(
                                  heading: '',
                                  body:
                                      'When we think about improving our mental health, we often turn to meditation or deep breathing exercises as tools for mindfulness. However, for individuals who are hyperaroused or overstimulated, whether from stress, anxiety, or trauma, these practices can feel inaccessible. The body may be too tense, the mind too scattered to focus on stillness. That’s where gentle movement comes in. It offers an accessible way to regulate emotions, increase body awareness, and enhance overall well-being.',
                                ),
                                BlogSection(
                                  heading: 'Movement Looks Different for Everyone',
                                  body:
                                      'Movement is a deeply personal experience. For some, a brisk walk might bring relief, while for others, a gentle stretch or even deep breathing can be just as effective. The key is recognising that movement, in all its forms, is a tool for emotional regulation and healing. Even breath, the most subtle form of movement, plays a critical role in how we feel. Breath is movement; it’s rhythmic, it’s cyclical, and it’s essential for regulating our bodies and minds. As we inhale and exhale, we create space within ourselves to process and release emotions, physically manifesting our mental state. For some, breathing exercises may be the first step toward mental clarity. But for others, more physical forms of movement are needed before the calming effects of deep breathing can be accessed.',
                                ),
                                BlogSection(
                                  heading: 'Gentle Movement as a Tool for Mindfulness and Emotional Regulation',
                                  body:
                                      'Research in dance movement therapy (DMT) shows that movement can be a powerful way to increase mindfulness and emotional awareness, especially for those who struggle with stillness. According to Koch et al. (2014), through guided movement, individuals reconnect with their bodies, allowing them to access and regulate emotions in a safe and structured way. In fact, gentle movement encourages emotional expression and facilitates relaxation by grounding the body in the present moment.\n\nResearch around the benefits of movement is further rooted in the polyvagal theory by Porges (2011), which explains that the ventral vagal system, responsible for safety and calmness, is activated through social connection and body awareness. For those in states of hyperarousal, engaging in mindful movement can help reset the nervous system, bringing them into a state of ventral vagal flow, making deep breathing more accessible. This grounding effect can significantly reduce feelings of anxiety, panic, or agitation, creating space for deeper emotional regulation.',
                                ),
                                BlogSection(
                                  heading: 'Movement as a Personal Path to Emotional Expression',
                                  body:
                                      'Levy (2013) explains that movement provides a platform for individuals to express emotions non-verbally, which can be especially beneficial for those who find it difficult to articulate their feelings. This form of self-expression allows individuals to release pent-up emotions and gain insight into their emotional states in a safe and controlled way. By focusing on the body, individuals can bypass mental barriers, allowing for deeper emotional release and greater emotional awareness.\n\nLutzker (2019) also emphasises that even small, intentional movements, such as slow stretches or rhythmic swaying, can help individuals develop greater awareness of their physical sensations and emotional states. This process of becoming mindful through movement offers a bridge between the mind and body, enabling people to process and express emotions that they may not have access to through words alone.',
                                ),
                                BlogSection(
                                  heading: 'Evidence-Based Support for Movement’s Role in Mental Health',
                                  body:
                                      'Studies show that incorporating movement into mental health practices can have profound benefits. Cohen and Wiesen (2017) found that individuals who engaged in therapeutic movement experienced improved mood and reduced anxiety. Additionally, Cramer et al. (2022) found that regular movement therapy significantly reduced symptoms of depression and stress, supporting the idea that movement is an effective tool for managing mental health.\n\nParker et al. (2015) also found that incorporating movement practices improved emotional regulation and helped individuals develop better coping mechanisms for stress. Moreover, Stuckey and Nobel (2010) highlighted that creative movement activities, including those used in therapeutic settings, are linked to improved mental and physical health, with a particular focus on reducing stress and enhancing emotional well-being.',
                                ),
                                BlogSection(
                                  heading: 'Conclusion',
                                  body:
                                      'Movement, in its many forms, offers a versatile and accessible tool for emotional regulation and overall well-being. Whether it’s breath, gentle stretching, or rhythmic movement, engaging with the body allows us to access and express emotions that may otherwise remain hidden. For those struggling to engage in stillness, gentle movement provides a safe and grounding pathway to mental clarity. Research supports the powerful role of movement in enhancing emotional health, making it a key practice for anyone seeking a more embodied, mindful approach to mental wellness.\n\nThrough the engage app, you can explore a variety of movement-based exercises designed to help you reconnect with your body, regulate emotions, and enhance your overall well-being.',
                                ),
                              ],
                              references: [
                                'Cramer, H., Lauche, R., & Dobos, G. (2022). Effect of coherent breathing on mental health and wellbeing. Scientific Reports, 12(1), 1231. https://doi.org/10.1038/s41598-022-27247-y',
                                'Koch, S. C., Fuchs, T., & Leman, M. (2014). The neurophysiological basis of dance movement therapy: Implications for the treatment of stress-related disorders. Frontiers in Psychology, 5, 905. https://doi.org/10.3389/fpsyg.2014.00905',
                                'Levy, F. J. (2013). Dance/movement therapy: Healing art. American Journal of Dance Therapy, 35(1), 97-114. https://doi.org/10.1007/s10465-013-9122-0',
                                'Yilmaz Balban, M., & Okumus, G. (2021). Breath-focused exercises for managing stress and anxiety: A systematic review. Frontiers in Psychology, 12, 3347. https://doi.org/10.3389/fpsyg.2021.678135',
                                'Zachou, A., Raud, M., & Warke, J. (2023). Effectiveness of movement practices for emotional regulation. International Journal of Psychology and Psychotherapy, 25(2), 45-58. https://doi.org/10.1016/j.ijpp.2023.02.001',
                                'Parker, M. E., Adler, S., & Butts, M. (2015). Dance/movement therapy for children: An overview of theory and practice. The Arts in Psychotherapy, 42, 106-111. https://doi.org/10.1016/j.aip.2015.01.004',
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom navigation bar - no SafeArea to prevent overflow
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 12 + MediaQuery.of(context).padding.bottom,
          top: 0,
        ),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF1A2E35),
            borderRadius: BorderRadius.circular(40),
            border: Border(
              top: BorderSide(
                color: Colors.white.withOpacity(0.12),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _BottomNavItem(
                  icon: Icons.home,
                  label: 'home',
                  isSelected: _selectedIndex == 0,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                _BottomNavItem(
                  icon: Icons.explore,
                  label: 'explore',
                  isSelected: _selectedIndex == 1,
                  onTap: () {},
                ),
                _BottomNavItem(
                  icon: Icons.person,
                  label: 'profile',
                  isSelected: _selectedIndex == 2,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required String title,
    String? description,
    String? duration,
    String? location,
    required List<Color> imageColors,
    String? imagePath,
    bool isFavorite = false,
    bool showDetails = false,
    VoidCallback? onArrowTap,
  }) {
    return Container(
      height: showDetails ? 200 : 160,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          // Background image/gradient
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imagePath != null
                  ? Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: imageColors,
                        ),
                      ),
                      child: CustomPaint(painter: _ActivityImagePainter()),
                    ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag and favorite icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
                if (showDetails) ...[
                  const Spacer(),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (duration != null)
                        _buildInfoTag(Icons.access_time, duration),
                      if (location != null) ...[
                        const SizedBox(width: 8),
                        _buildInfoTag(Icons.location_on, location),
                      ],
                      const Spacer(),
                      GestureDetector(
                        onTap: onArrowTap,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openExploreActivity({
    required Activity activity,
    required String modality,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ActivityDetailPage(
          activity: activity,
          modality: modality,
        ),
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogCard({
    required String title,
    required String description,
    required List<Color> imageColors,
    String? imagePath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      height: 168,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF005C77).withOpacity(0.55),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.16), width: 1),
      ),
      child: Row(
        children: [
          // Text content
          Expanded(
            flex: 11,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40 / 2,
                      fontWeight: FontWeight.bold,
                      height: 1.15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.88),
                      fontSize: 36 / 2,
                      height: 1.25,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          // Image
          Expanded(
            flex: 13,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (imagePath != null)
                    Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: imageColors,
                        ),
                      ),
                      child: CustomPaint(painter: _BlogImagePainter()),
                    ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.45),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class ModalityItem {
  final String title;
  final String description;
  final LinearGradient gradient;
  final String imagePath;

  ModalityItem({
    required this.title,
    required this.description,
    required this.gradient,
    required this.imagePath,
  });
}

class _ModalityItemCard extends StatelessWidget {
  final ModalityItem modality;

  const _ModalityItemCard({required this.modality});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (modality.title == 'Art') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ArtActivitiesPage()),
          );
        } else if (modality.title == 'Sound') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SoundActivitiesPage(),
            ),
          );
        } else if (modality.title == 'Movement') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MovementActivitiesPage(),
            ),
          );
        } else if (modality.title == 'Drama') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DramaActivitiesPage(),
            ),
          );
        } else if (modality.title == 'Storytelling') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const StorytellingActivitiesPage(),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F3B40).withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        child: Row(
          children: [
            // Illustration on the left
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                modality.imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to gradient container if image fails to load
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: modality.gradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // Text content in the middle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    modality.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    modality.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Arrow icon on the right
            const Icon(Icons.arrow_forward, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}

class _ActivityImagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw abstract patterns
    for (int i = 0; i < 5; i++) {
      final angle = (i / 5) * math.pi * 2;
      final radius = size.width * (0.2 + (i % 2) * 0.1);
      final x = size.width * 0.5 + math.cos(angle) * radius;
      final y = size.height * 0.5 + math.sin(angle) * radius;

      paint.color = Colors.white.withOpacity(0.1);
      canvas.drawCircle(Offset(x, y), size.width * 0.1, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BlogImagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw abstract colorful patterns
    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * math.pi * 2;
      final radius = size.width * (0.15 + (i % 3) * 0.05);
      final x = size.width * 0.5 + math.cos(angle) * radius;
      final y = size.height * 0.5 + math.sin(angle) * radius;

      paint.color = Colors.white.withOpacity(0.15 + (i % 3) * 0.05);
      canvas.drawCircle(
        Offset(x, y),
        size.width * (0.08 + (i % 2) * 0.03),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
          size: 20,
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
    return GestureDetector(
      onTap: onTap,
      child: isSelected
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.22),
                    Colors.white.withOpacity(0.12),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Center(child: content),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Center(child: content),
            ),
    );
  }
}
