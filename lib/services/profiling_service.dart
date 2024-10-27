import '../models/transaction.dart';

class ProfilingService {
  String getUserProfile(List<Transaction> transactions) {
    Map<String, int> profileScores = {
      'Commuter': 0,
      'Family-Oriented': 0,
      'Foodie': 0,
      'Tech Enthusiast': 0,
      'Fitness Enthusiast': 0,
    };

    for (var transaction in transactions) {
      String description = transaction.description?.toLowerCase() ?? '';

      // Commuter profile
      if (description.contains('taxi') ||
          description.contains('bus') ||
          description.contains('train') ||
          description.contains('subway')) {
        profileScores['Commuter'] = (profileScores['Commuter'] ?? 0) + 1;
      }

      // Family-Oriented profile
      if (description.contains('sister') ||
          description.contains('brother') ||
          description.contains('mom') ||
          description.contains('dad') ||
          description.contains('family')) {
        profileScores['Family-Oriented'] =
            (profileScores['Family-Oriented'] ?? 0) + 1;
      }

      // Foodie profile
      if (description.contains('restaurant') ||
          description.contains('cafe') ||
          description.contains('food') ||
          description.contains('grocery')) {
        profileScores['Foodie'] = (profileScores['Foodie'] ?? 0) + 1;
      }

      // Tech Enthusiast profile
      if (description.contains('electronics') ||
          description.contains('computer') ||
          description.contains('phone') ||
          description.contains('gadget')) {
        profileScores['Tech Enthusiast'] =
            (profileScores['Tech Enthusiast'] ?? 0) + 1;
      }

      // Fitness Enthusiast profile
      if (description.contains('gym') ||
          description.contains('fitness') ||
          description.contains('sport') ||
          description.contains('workout')) {
        profileScores['Fitness Enthusiast'] =
            (profileScores['Fitness Enthusiast'] ?? 0) + 1;
      }
    }

    // Find the profile with the highest score
    String topProfile = 'General';
    int maxScore = 0;

    profileScores.forEach((profile, score) {
      if (score > maxScore) {
        maxScore = score;
        topProfile = profile;
      }
    });

    // If the top score is 0, return 'General'
    return maxScore > 0 ? topProfile : 'General';
  }

  List<String> getTopProfiles(List<Transaction> transactions, {int topN = 3}) {
    Map<String, int> profileScores = {
      'Commuter': 0,
      'Family-Oriented': 0,
      'Foodie': 0,
      'Tech Enthusiast': 0,
      'Fitness Enthusiast': 0,
    };

    // ... (same scoring logic as in getUserProfile)

    // Sort profiles by score
    var sortedProfiles = profileScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Return top N profiles
    return sortedProfiles
        .take(topN)
        .where((entry) => entry.value > 0)
        .map((entry) => entry.key)
        .toList();
  }
}
