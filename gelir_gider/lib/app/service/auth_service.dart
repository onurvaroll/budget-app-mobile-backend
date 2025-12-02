import 'package:gelir_gider/app/constants/api_constants.dart';
import 'package:gelir_gider/app/models/app_user.dart';
import 'package:gelir_gider/app/service/api_service.dart';
import 'package:gelir_gider/app/service/storage_service.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxService {
  late final ApiService _apiService;
  late final StorageService _storageService;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  final Rx<AppUser?> currentUser = Rx<AppUser?>(null);

  Future<AuthService> init() async {
    _apiService = Get.find<ApiService>();
    _storageService = Get.find<StorageService>();

    try {
      await _googleSignIn.initialize(
        serverClientId: ApiConstants.serverClientId,
      );

      final GoogleSignInAccount? silentUser = await _googleSignIn
          .attemptLightweightAuthentication();

      if (silentUser != null) {
        print("AuthService: Silently signed in as ${silentUser.email}");
      } else {
        print("AuthService: No silent user found.");
      }
    } catch (e) {
      print("AuthService Init Error: $e");

      print(
        "AuthService Init Error: Platform yapılandırmasını (SHA-1, Info.plist) kontrol edin.",
      );
    }

    return this;
  }

  Future<AppUser?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) {
        print("Google Sign-In: Kullanıcı oturum açmayı iptal etti.");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      print("idToken alındı: $idToken");

      if (idToken == null) {
        print("Google Sign-In HATA: idToken null geldi!");
        print(
          "LÜTFEN KONTROL EDİN: Bölüm 3'teki platform yapılandırması (Android SHA-1, iOS Info.plist) doğru mu?",
        );
        print(
          "LÜTFEN KONTROL EDİN: 'serverClientId' 'initialize()' metoduna doğru iletildi mi? [3]",
        );
        await signOut();

        return null;
      }

      print("Google Auth idToken alındı, arka uca gönderiliyor...");

      final response = await _apiService.post(ApiConstants.login, {
        'token': idToken,
      });

      if (response.statusCode == 200) {
        print("Login Response Data: ${response.data}");

        if (response.data['token'] != null) {
          await _storageService.setValue<String>(
            StorageKeys.userToken,
            response.data['token'],
          );
          print("JWT Token saklandı.");
        }

        if (response.data['user'] != null) {
          var user = AppUser.fromJson(response.data['user']);
          currentUser.value = user;
          print("AuthService: Kullanıcı bilgileri alındı: ${user.email}");
          return user;
        } else {
          print(
            "UYARI: Login yanıtında 'user' objesi bulunamadı. Profil bilgileri çekiliyor...",
          );
          // Token var, profili ayrıca çekmeyi dene
          try {
            final user = await getProfile();
            if (user != null) {
              currentUser.value = user;
              print(
                "AuthService: Profil bilgileri başarıyla çekildi: ${user.email}",
              );
              return user;
            }
          } catch (e) {
            print("AuthService: Profil çekme hatası: $e");
          }
          return null;
        }
      } else {
        print(
          "AuthService: Arka uç girişi başarısız. Status: ${response.statusCode}",
        );
        await signOut();

        return null;
      }
    } catch (e) {
      print("Google Sign-In Error: $e");

      if (e.toString().contains('clientConfigurationError') ||
          e.toString().contains('12500')) {
        print(
          "HATA: clientConfigurationError. Lütfen Bölüm 3'teki platform yapılandırmasını kontrol edin.",
        );
      }
      await signOut();
      currentUser.value = null;

      return null;
    }
  }

  Future<void> signOut() async {
    try {
      currentUser.value = null;

      await _googleSignIn.signOut();

      await _storageService.removeValue(StorageKeys.userToken);

      print("AuthService: Sign out başarılı.");
    } catch (e) {
      print("Sign Out Error: $e");
    }
  }

  Future<AppUser?> getProfile() async {
    try {
      final response = await _apiService.get(ApiConstants.profile);
      print("Get Profile Response: ${response.data}");
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          if (data.containsKey('user')) {
            return AppUser.fromJson(data['user']);
          }
          if (data.containsKey('data')) {
            return AppUser.fromJson(data['data']);
          }
        }
        return AppUser.fromJson(data);
      }
      return null;
    } catch (e) {
      print("Get Profile Error: $e");
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = _storageService.getValue<String>(StorageKeys.userToken);
    if (token == null) {
      currentUser.value = null;
      return false;
    }
    final response = await getProfile();
    if (response != null) {
      currentUser.value = response;
      return true;
    } else {
      await signOut();
      return false;
    }
  }
}
