

class AuthService {
  // Using JSONPlaceholder for demo purposes
  // In real app, you would use your actual API endpoint
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo purposes, we'll simulate different responses based on email
      if (email == 'admin@example.com' && password == 'password123') {
        // Successful login
        return {
          'success': true,
          'user': {
            'id': 1,
            'name': 'Admin User',
            'email': email,
            'role': 'admin',
          },
          'token': 'demo_token_12345',
        };
      } else if (email == 'user@example.com' && password == 'password123') {
        // Successful login for regular user
        return {
          'success': true,
          'user': {
            'id': 2,
            'name': 'Regular User',
            'email': email,
            'role': 'user',
          },
          'token': 'demo_token_67890',
        };
      } else {
        // Failed login
        return {
          'success': false,
          'message': 'Invalid email or password',
        };
      }
      
      // Alternative: Real API call (uncomment to use)
      /*
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'user': data['user'],
          'token': data['token'],
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Login failed',
        };
      }
      */
      
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
      };
    }
  }
  
  Future<Map<String, dynamic>> getUserProfile(String token) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      return {
        'success': true,
        'user': {
          'id': 1,
          'name': 'Demo User',
          'email': 'demo@example.com',
          'avatar': 'https://via.placeholder.com/150',
          'bio': 'This is a demo user profile',
        },
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to fetch user profile',
      };
    }
  }
} 