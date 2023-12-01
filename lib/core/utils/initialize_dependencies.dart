import 'package:event_bus/event_bus.dart';
import 'package:minisitewalkapp/core/wrappers/injector.dart';

Future<void> initialiseDependencies() async {
  DI().getIt.registerSingleton<EventBus>(EventBus());
  // DI().getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  // DI().registerSingleton<ApiClient>(ApiClientImpl());
  // DI().registerSingleton<RESTClient>(RESTClientImpl());
  // DI().registerSingleton<FilePicker>(FilePickerImpl());
  // DI().registerSingleton<NoSqlStorage>(NoSqlStorageImpl.instance());
  // DI().registerSingleton<PermissionRequester>(PermissionRequesterImpl());
  // DI().registerSingleton<FileManager>(FileManager.instance());
  // DI().registerSingleton<Downloader>(Downloader.getInstance());
  // DI().registerSingleton<SecureStorageHelper>(SecureStorageHelper.instance);
  // DI().registerSingleton<InMemory>(InMemory());
  // DI().registerSingleton<JwtHelper>(JwtHelper.instance());
  // DI().registerSingleton<CrashLogger>(CrashLogger.instance);
  // DI().registerSingleton<UsageAnalytics>(UsageAnalyticsImpl.instance);
  // DI().registerSingleton<NotificationUtils>(NotificationUtils.instance);
  // await DI().resolve<NoSqlStorage>().init();
  // await DI().resolve<UsageAnalytics>().init();
}

// void initialiseErrorHandlers() {
//   FlutterError.onError = (details) {
//     //LOG errors to console or any error tracking tools
//     DI().resolve<CrashLogger>().recordFlutterError(details);
//     logger.e("in Flutter Error",
//         error: details.exception,
//         stackTrace: details.stack,
//         recordError: false);
//   };
//   PlatformDispatcher.instance.onError = (error, stack) {
//     //LOG errors to console or any error tracking tools
//     logger.e('in dispatcher error',
//         error: error, stackTrace: stack, recordError: false);
//     DI().resolve<CrashLogger>().recordError(error, stack, fatal: false);
//     return true;
//   };
//   ErrorWidget.builder = (FlutterErrorDetails details) {
//     //this triggers when FlutterErrors are thrown in UI
//     return RenderingErrorWidget(errorDetails: details);
//   };
//   DI().resolve<EventBus>().on<ExceptionEvent>().listen((event) {
//     logger.e(event.e, recordError: false);
//     DI().resolve<CrashLogger>().recordError(event.e, null, fatal: false);
//   });
// }
