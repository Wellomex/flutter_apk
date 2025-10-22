import 'api_service.dart';

/// Optimization Plan Service
/// Handles optimization plan generation
class OptimizationPlanService {
  final ApiService _api;

  OptimizationPlanService({required ApiService apiService}) : _api = apiService;

  /// Generate optimization plan based on user's health data
  Future<Map<String, dynamic>> generatePlan({
    String? focusArea,
    int? durationDays,
    Map<String, dynamic>? preferences,
  }) async {
    try {
      final response = await _api.post(
        '/api/v1/plan/run',
        {
          if (focusArea != null) 'focus_area': focusArea,
          if (durationDays != null) 'duration_days': durationDays,
          if (preferences != null) 'preferences': preferences,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to generate optimization plan: $e');
    }
  }
}
