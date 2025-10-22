import 'api_service.dart';

/// Health Profile Service
/// Handles all health profile and metrics related API calls
class HealthProfileService {
  final ApiService _api;

  HealthProfileService({required ApiService apiService}) : _api = apiService;

  /// Create health profile
  Future<Map<String, dynamic>> createHealthProfile({
    required Map<String, dynamic> profileData,
  }) async {
    try {
      final response = await _api.post(
        '/api/v1/health/profile',
        profileData,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create health profile: $e');
    }
  }

  /// Get health profile
  Future<Map<String, dynamic>> getHealthProfile() async {
    try {
      final response = await _api.get('/api/v1/health/profile');
      return response.data;
    } catch (e) {
      throw Exception('Failed to get health profile: $e');
    }
  }

  /// Update health profile
  Future<Map<String, dynamic>> updateHealthProfile({
    required Map<String, dynamic> profileData,
  }) async {
    try {
      final response = await _api.put(
        '/api/v1/health/profile',
        profileData,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to update health profile: $e');
    }
  }

  /// Create health metric
  Future<Map<String, dynamic>> createHealthMetric({
    required String metricType,
    required dynamic value,
    required String unit,
    String? notes,
  }) async {
    try {
      final response = await _api.post(
        '/api/v1/health/metrics',
        {
          'metric_type': metricType,
          'value': value,
          'unit': unit,
          if (notes != null) 'notes': notes,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create health metric: $e');
    }
  }

  /// Get health metrics summary
  Future<Map<String, dynamic>> getMetricsSummary({
    String? metricType,
    String? period, // 'day', 'week', 'month', 'year'
  }) async {
    try {
      final response = await _api.get(
        '/api/v1/health/metrics/summary',
        params: {
          if (metricType != null) 'metric_type': metricType,
          if (period != null) 'period': period,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to get metrics summary: $e');
    }
  }

  /// Get health metrics history
  Future<List<dynamic>> getMetricsHistory({
    String? metricType,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    try {
      final response = await _api.get(
        '/api/v1/health/metrics/history',
        params: {
          if (metricType != null) 'metric_type': metricType,
          if (startDate != null) 'start_date': startDate.toIso8601String(),
          if (endDate != null) 'end_date': endDate.toIso8601String(),
          if (limit != null) 'limit': limit,
        },
      );
      return response.data as List<dynamic>;
    } catch (e) {
      throw Exception('Failed to get metrics history: $e');
    }
  }
}
