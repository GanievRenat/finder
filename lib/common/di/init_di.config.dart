// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:banana_client/banana_client.dart' as _i209;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:deepseek_client/deepseek_client.dart' as _i987;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_remote_config/firebase_remote_config.dart' as _i627;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:flirta/common/config/app_config.dart' as _i67;
import 'package:flirta/common/data/providers/admin/auth_admin_data_provider.dart'
    as _i752;
import 'package:flirta/common/data/providers/admin/person_data_provider.dart'
    as _i2;
import 'package:flirta/common/data/providers/admin/properties_data_provider.dart'
    as _i664;
import 'package:flirta/common/data/providers/chat_local_data_provider.dart'
    as _i800;
import 'package:flirta/common/data/providers/data_providers.dart' as _i443;
import 'package:flirta/common/data/providers/dating_data_provider.dart'
    as _i666;
import 'package:flirta/common/data/providers/filter_data_provider.dart'
    as _i713;
import 'package:flirta/common/data/providers/profile_data_provider.dart'
    as _i220;
import 'package:flirta/common/data/providers/prompts_data_provider.dart'
    as _i111;
import 'package:flirta/common/data/providers/registration_data_provider.dart'
    as _i566;
import 'package:flirta/common/data/providers/registration_form_data_provider.dart'
    as _i207;
import 'package:flirta/common/data/repository/admin/auth_admin_repository_impl.dart'
    as _i956;
import 'package:flirta/common/data/repository/admin/person_admin_repository_impl.dart'
    as _i208;
import 'package:flirta/common/data/repository/admin/properties_admin_repository_impl.dart'
    as _i146;
import 'package:flirta/common/data/repository/chat_repository_impl.dart'
    as _i190;
import 'package:flirta/common/data/repository/dating_repository_impl.dart'
    as _i625;
import 'package:flirta/common/data/repository/filter_repository_impl.dart'
    as _i120;
import 'package:flirta/common/data/repository/profile_repository_impl.dart'
    as _i473;
import 'package:flirta/common/data/repository/registration_form_repository_impl.dart'
    as _i789;
import 'package:flirta/common/data/repository/registration_repository_impl.dart'
    as _i558;
import 'package:flirta/common/data/repository/settings_repository_impl.dart'
    as _i131;
import 'package:flirta/common/di/third_party_module.dart' as _i362;
import 'package:flirta/common/domain/app_config.dart' as _i1048;
import 'package:flirta/common/domain/repository/admin/properties_admin_repository.dart'
    as _i733;
import 'package:flirta/common/domain/repository/repositories.dart' as _i243;
import 'package:flirta/common/domain/usecase/admin/auth/auth_by_admin_usecase.dart'
    as _i799;
import 'package:flirta/common/domain/usecase/admin/auth/forgot_password_usecase.dart'
    as _i666;
import 'package:flirta/common/domain/usecase/admin/auth/init_admin_usecase.dart'
    as _i398;
import 'package:flirta/common/domain/usecase/admin/auth/logout_usecase.dart'
    as _i182;
import 'package:flirta/common/domain/usecase/admin/person/create_new_person_usecase.dart'
    as _i145;
import 'package:flirta/common/domain/usecase/admin/person/get_person_list_usecase.dart'
    as _i134;
import 'package:flirta/common/domain/usecase/admin/person/remove_person_usecase.dart'
    as _i5;
import 'package:flirta/common/domain/usecase/admin/person/update_person_usecase.dart'
    as _i1062;
import 'package:flirta/common/domain/usecase/admin/properties/get_property_list_usecase.dart'
    as _i477;
import 'package:flirta/common/domain/usecase/admin/properties/update_property_usecase.dart'
    as _i64;
import 'package:flirta/common/domain/usecase/chat/create_new_chat_usecase.dart'
    as _i2;
import 'package:flirta/common/domain/usecase/chat/get_chat_list_usecase.dart'
    as _i984;
import 'package:flirta/common/domain/usecase/chat/get_detail_chat_usecase.dart'
    as _i830;
import 'package:flirta/common/domain/usecase/chat/load_queue_message_usecase.dart'
    as _i749;
import 'package:flirta/common/domain/usecase/chat/save_queue_message_usecase.dart'
    as _i894;
import 'package:flirta/common/domain/usecase/chat/send_message_to_chat_usecase.dart'
    as _i775;
import 'package:flirta/common/domain/usecase/chat/set_read_chat_usecase.dart'
    as _i558;
import 'package:flirta/common/domain/usecase/dating/delete_older_data_usecase.dart'
    as _i325;
import 'package:flirta/common/domain/usecase/dating/get_detail_of_person_usecase.dart'
    as _i344;
import 'package:flirta/common/domain/usecase/dating/get_list_dating_person_usecase.dart'
    as _i91;
import 'package:flirta/common/domain/usecase/dating/get_swipe_count_to_day_usecase.dart'
    as _i110;
import 'package:flirta/common/domain/usecase/dating/like_person_usecase.dart'
    as _i866;
import 'package:flirta/common/domain/usecase/dating/skip_person_usecase.dart'
    as _i981;
import 'package:flirta/common/domain/usecase/dating/undo_person_usecase.dart'
    as _i926;
import 'package:flirta/common/domain/usecase/filter/clear_filter_state_usecase.dart'
    as _i616;
import 'package:flirta/common/domain/usecase/filter/get_filter_state_usecase.dart'
    as _i751;
import 'package:flirta/common/domain/usecase/filter/save_filter_state_usecase.dart'
    as _i372;
import 'package:flirta/common/domain/usecase/profile/delete_profile_usecase.dart'
    as _i851;
import 'package:flirta/common/domain/usecase/profile/get_profile_usecase.dart'
    as _i194;
import 'package:flirta/common/domain/usecase/profile/update_profile_usecase.dart'
    as _i942;
import 'package:flirta/common/domain/usecase/prompt/get_prompts_usecase.dart'
    as _i8;
import 'package:flirta/common/domain/usecase/prompt/update_prompts_usecase.dart'
    as _i184;
import 'package:flirta/common/domain/usecase/registration_user/clear_registration_form_data_usecase.dart'
    as _i732;
import 'package:flirta/common/domain/usecase/registration_user/load_registration_form_data_usecase.dart'
    as _i344;
import 'package:flirta/common/domain/usecase/registration_user/registration_new_user_by_guest_usecase.dart'
    as _i671;
import 'package:flirta/common/domain/usecase/registration_user/save_registration_form_data_usecase.dart'
    as _i220;
import 'package:flirta/common/domain/usecase/usecases.dart' as _i25;
import 'package:flirta/common/router/modal_bottom_sheet.dart' as _i216;
import 'package:flirta/common/router/observers/auth_analytics_observer.dart'
    as _i845;
import 'package:flirta/common/router/observers/main_analytics_observer.dart'
    as _i151;
import 'package:flirta/common/router/toastification.dart' as _i534;
import 'package:flirta/common/service/ai_agent_service.dart' as _i845;
import 'package:flirta/common/service/analytics/analytics_service.dart'
    as _i957;
import 'package:flirta/common/service/app_state_service.dart' as _i523;
import 'package:flirta/common/service/crashlytics_service.dart' as _i551;
import 'package:flirta/common/service/language_service.dart' as _i39;
import 'package:flirta/common/service/notification_service.dart' as _i128;
import 'package:flirta/common/service/photo_picker_service.dart' as _i651;
import 'package:flirta/common/service/properties_service.dart' as _i588;
import 'package:flirta/common/service/remote_config_service.dart' as _i327;
import 'package:flirta/common/service/secure_storage_service.dart' as _i521;
import 'package:flirta/common/service/services.dart' as _i697;
import 'package:flirta/common/service/storage_services.dart' as _i726;
import 'package:flirta/common/source/database/database_manager.dart' as _i366;
import 'package:flirta/common/source/database/table/chat_messages_table.dart'
    as _i320;
import 'package:flirta/common/source/database/table/chat_table.dart' as _i1041;
import 'package:flirta/common/source/database/table/match_table.dart' as _i332;
import 'package:flirta/common/source/network/http_client/http_client_module.dart'
    as _i1066;
import 'package:flirta/common/source/network/interceptors/error_interceptor.dart'
    as _i534;
import 'package:flirta/common/source/network/interceptors/interceptors.dart'
    as _i97;
import 'package:flirta/common/source/network/interceptors/language_interceptor.dart'
    as _i864;
import 'package:flirta/common/source/network/interceptors/logger_interceptors.dart'
    as _i1072;
import 'package:flirta/common/source/network/interceptors/token_interceptor.dart'
    as _i970;
import 'package:flirta/common/state/queue_messages/bloc/queue_message_bloc.dart'
    as _i468;
import 'package:flirta/common/ui/widgets/photo/image_source_bottom_sheet.dart'
    as _i682;
import 'package:flirta/featuries/admin/persons/pages/list/state/person_list_cubit.dart'
    as _i76;
import 'package:flirta/featuries/chat/state/chat_cubit.dart' as _i310;
import 'package:flirta/featuries/dating/pages/dating/state/dating_cubit.dart'
    as _i367;
import 'package:flirta/featuries/dating/pages/filter/state/filter_cubit.dart'
    as _i103;
import 'package:flirta/featuries/paywall/state/paywall_cubit.dart' as _i403;
import 'package:flirta/featuries/profile/pages/profile/state/profile_cubit.dart'
    as _i227;
import 'package:flirta/featuries/registration/state/registration_cubit.dart'
    as _i761;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:spicyapi_client/spicyapi_client.dart' as _i146;
import 'package:venice_client/venice_client.dart' as _i693;

const String _test = 'test';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    final httpClientModule = _$HttpClientModule();
    gh.factory<_i973.InternetConnectionChecker>(
      () => thirdPartyModule.connectionChecker,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyModule.storage,
      preResolve: true,
    );
    gh.factory<_i59.FirebaseAuth>(() => thirdPartyModule.auth);
    gh.singleton<_i974.Logger>(() => thirdPartyModule.logger);
    gh.singleton<_i366.AppDatabase>(() => thirdPartyModule.dataBase);
    gh.singleton<_i974.FirebaseFirestore>(() => thirdPartyModule.firestore);
    gh.singleton<_i627.FirebaseRemoteConfig>(
      () => thirdPartyModule.remoteConfig,
    );
    gh.singleton<_i457.FirebaseStorage>(() => thirdPartyModule.firestorage);
    gh.singleton<_i987.DeepseekClient>(() => thirdPartyModule.deepseekClient);
    gh.singleton<_i693.VeniceClient>(() => thirdPartyModule.veniceClient);
    gh.singleton<_i209.BananaClient>(() => thirdPartyModule.bananaClient);
    gh.singleton<_i146.SpacyAPIClient>(() => thirdPartyModule.spacyClient);
    gh.singleton<_i216.AppModalBottomSheet>(() => _i216.AppModalBottomSheet());
    gh.singleton<_i534.AppToast>(() => _i534.AppToast());
    gh.singleton<_i523.AppStateService>(() => _i523.AppStateService());
    gh.singleton<_i551.CrashlyticsService>(() => _i551.CrashlyticsService());
    gh.singleton<_i128.NotificationService>(() => _i128.NotificationService());
    gh.singleton<_i651.PhotoPickerService>(() => _i651.PhotoPickerService());
    gh.singleton<_i521.SecureStorageService>(
      () => _i521.SecureStorageService(),
    );
    gh.singleton<_i682.ImageSourceBottomSheet>(
      () => _i682.ImageSourceBottomSheet(),
    );
    gh.singleton<_i403.PaywallCubit>(() => _i403.PaywallCubit());
    gh.singleton<_i111.PromptsDataProvider>(
      () => _i111.PropertiesDataProviderFireBase(
        fireStore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.singleton<_i320.ChatMessagesTable>(
      () => _i320.ChatMessagesTable(gh<_i366.AppDatabase>()),
    );
    gh.singleton<_i1041.ChatTable>(
      () => _i1041.ChatTable(gh<_i366.AppDatabase>()),
    );
    gh.singleton<_i332.MatchAndBlockTable>(
      () => _i332.MatchAndBlockTable(gh<_i366.AppDatabase>()),
    );
    gh.singleton<_i2.PersonDataProvider>(
      () => _i2.PersonDataProviderFireBase(
        fireStore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.singleton<_i327.RemoteConfigService>(
      () => _i327.RemoteConfigService(
        remoteConfig: gh<_i627.FirebaseRemoteConfig>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i1048.AppConfig>(
      () => _i67.TestAppConfig(),
      registerFor: {_test},
    );
    gh.singleton<_i243.SettingsRepository>(
      () => _i131.SettingsRepositoryImpl(),
    );
    gh.singleton<_i1048.AppConfig>(
      () => _i67.DevAppConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i1072.LoggerInterceptor>(
      () => _i1072.LoggerInterceptor(logger: gh<_i974.Logger>()),
    );
    gh.singleton<_i664.PropertiesDataProvider>(
      () => _i664.PropertiesDataProviderFireBase(
        fireStore: gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.singleton<_i534.ErrorInterceptor>(
      () => _i534.ErrorInterceptor(
        connectionChecker: gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.singleton<_i726.StorageServices>(
      () => _i726.StorageServices(gh<_i457.FirebaseStorage>()),
    );
    gh.singleton<_i8.GetPrompts>(
      () => _i8.GetPrompts(promptRepository: gh<_i243.PromptRepository>()),
    );
    gh.singleton<_i184.UpdatePrompts>(
      () => _i184.UpdatePrompts(promptRepository: gh<_i243.PromptRepository>()),
    );
    gh.singleton<_i864.LanguageInterceptor>(
      () => _i864.LanguageInterceptor(
        appStateService: gh<_i523.AppStateService>(),
      ),
    );
    gh.singleton<_i970.TokenInterceptor>(
      () =>
          _i970.TokenInterceptor(appStateService: gh<_i523.AppStateService>()),
    );
    gh.singleton<_i1048.AppConfig>(
      () => _i67.ProdAppConfig(),
      registerFor: {_prod},
    );
    gh.singleton<_i733.PropertiesAdminRepository>(
      () => _i146.PropertiesAdminRepositoryImpl(
        dataProvider: gh<_i664.PropertiesDataProvider>(),
      ),
    );
    gh.factory<_i361.Dio>(
      () => httpClientModule.dioWithoutAuth(
        gh<_i1048.AppConfig>(),
        gh<_i97.LoggerInterceptor>(),
        gh<_i97.ErrorInterceptor>(),
        gh<_i97.LanguageInterceptor>(),
      ),
      instanceName: 'dioWithNoAuth',
    );
    gh.singleton<_i243.PersonAdminRepository>(
      () => _i208.PersonAdminRepositoryImpl(
        dataProvider: gh<_i2.PersonDataProvider>(),
      ),
    );
    gh.singleton<_i566.RegistrationDataProvider>(
      () => _i566.RegistrationDataProviderLocal(
        sharedPreferences: gh<_i460.SharedPreferences>(),
        appConfig: gh<_i1048.AppConfig>(),
      ),
    );
    gh.factory<_i361.Dio>(
      () => httpClientModule.dioWithAuth(
        gh<_i1048.AppConfig>(),
        gh<_i97.LoggerInterceptor>(),
        gh<_i97.ErrorInterceptor>(),
        gh<_i97.TokenInterceptor>(),
        gh<_i97.LanguageInterceptor>(),
      ),
      instanceName: 'dioWithAuth',
    );
    gh.singleton<_i957.AnalyticsService>(
      () => _i957.AnalyticsService(
        logger: gh<_i974.Logger>(),
        config: gh<_i1048.AppConfig>(),
      ),
    );
    gh.singleton<_i800.ChatLocalDataProvider>(
      () => _i800.ChatLocalDataProviderImpl(
        chatTable: gh<_i1041.ChatTable>(),
        messageTable: gh<_i320.ChatMessagesTable>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
        appConfig: gh<_i1048.AppConfig>(),
      ),
    );
    gh.singleton<_i666.DatingDataProvider>(
      () => _i666.DatingDataProviderLocal(
        matchAndBlockTable: gh<_i332.MatchAndBlockTable>(),
        firestore: gh<_i974.FirebaseFirestore>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
        appConfig: gh<_i1048.AppConfig>(),
      ),
    );
    gh.singleton<_i243.ChatRepository>(
      () => _i190.ChatRepositoryImpl(
        localDataProvider: gh<_i800.ChatLocalDataProvider>(),
      ),
    );
    gh.singleton<_i477.GetPropertyList>(
      () => _i477.GetPropertyList(
        propertyRepository: gh<_i243.PropertiesAdminRepository>(),
      ),
    );
    gh.singleton<_i64.UpdateProperty>(
      () => _i64.UpdateProperty(
        propertyRepository: gh<_i243.PropertiesAdminRepository>(),
      ),
    );
    gh.singleton<_i752.AuthAdminDataProvider>(
      () => _i752.AuthAdminDataProviderLocal(
        auth: gh<_i59.FirebaseAuth>(),
        appConfig: gh<_i1048.AppConfig>(),
      ),
    );
    gh.singleton<_i243.DatingRepository>(
      () => _i625.DatingRepositoryImpl(
        dataProvider: gh<_i443.DatingDataProvider>(),
        storageServices: gh<_i726.StorageServices>(),
      ),
    );
    gh.factory<_i845.AuthAnalyticsObserver>(
      () => _i845.AuthAnalyticsObserver(
        analyticsService: gh<_i957.AnalyticsService>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.factory<_i151.MainAnalyticsObserver>(
      () => _i151.MainAnalyticsObserver(
        analyticsService: gh<_i957.AnalyticsService>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i39.LanguageService>(
      () => _i39.LanguageService(
        gh<_i460.SharedPreferences>(),
        gh<_i1048.AppConfig>(),
      ),
    );
    gh.singleton<_i2.CreateNewChat>(
      () => _i2.CreateNewChat(
        chatRepository: gh<_i243.ChatRepository>(),
        appStateService: gh<_i523.AppStateService>(),
      ),
    );
    gh.singleton<_i344.GetDetailOfPerson>(
      () => _i344.GetDetailOfPerson(
        datingRepository: gh<_i243.DatingRepository>(),
      ),
    );
    gh.singleton<_i145.CreateNewPerson>(
      () => _i145.CreateNewPerson(
        personRepository: gh<_i243.PersonAdminRepository>(),
      ),
    );
    gh.singleton<_i134.GetPersonList>(
      () => _i134.GetPersonList(
        personRepository: gh<_i243.PersonAdminRepository>(),
      ),
    );
    gh.singleton<_i5.RemovePerson>(
      () =>
          _i5.RemovePerson(personRepository: gh<_i243.PersonAdminRepository>()),
    );
    gh.singleton<_i1062.UpdatePerson>(
      () => _i1062.UpdatePerson(
        personRepository: gh<_i243.PersonAdminRepository>(),
      ),
    );
    gh.singleton<_i243.RegistrationRepository>(
      () => _i558.RegistrationRepositoryImpl(
        dataProvider: gh<_i443.RegistrationDataProvider>(),
      ),
    );
    gh.factory<_i583.GoRouter>(
      () => thirdPartyModule.router(gh<_i845.AuthAnalyticsObserver>()),
    );
    gh.singleton<_i207.RegistrationFormDataProvider>(
      () => _i207.RegistrationFormDataProviderLocal(
        sharedPreferences: gh<_i460.SharedPreferences>(),
        appConfig: gh<_i1048.AppConfig>(),
      ),
    );
    gh.singleton<_i713.FilterDataProvider>(
      () => _i713.FilterDataProviderLocal(
        sharedPreferences: gh<_i460.SharedPreferences>(),
        appConfig: gh<_i1048.AppConfig>(),
      ),
    );
    gh.singleton<_i671.RegistrationNewUserByGuest>(
      () => _i671.RegistrationNewUserByGuest(
        registrationRepository: gh<_i243.RegistrationRepository>(),
      ),
    );
    gh.singleton<_i588.PropertiesService>(
      () => _i588.PropertiesService(
        getPropertyList: gh<_i25.GetPropertyList>(),
        updateProperty: gh<_i25.UpdateProperty>(),
      ),
    );
    gh.singleton<_i220.ProfileDataProvider>(
      () => _i220.ProfileDataProviderLocal(
        sharedPreferences: gh<_i460.SharedPreferences>(),
        appConfig: gh<_i1048.AppConfig>(),
      ),
    );
    gh.singleton<_i845.AIAgentService>(
      () => _i845.AIAgentService(
        deepseekClient: gh<_i987.DeepseekClient>(),
        veniceClient: gh<_i693.VeniceClient>(),
        bananaClient: gh<_i209.BananaClient>(),
        spacyClient: gh<_i146.SpacyAPIClient>(),
        remoteConfig: gh<_i327.RemoteConfigService>(),
        storageServices: gh<_i726.StorageServices>(),
        appStateService: gh<_i523.AppStateService>(),
        secureStorageService: gh<_i521.SecureStorageService>(),
        appConfig: gh<_i1048.AppConfig>(),
      ),
    );
    gh.singleton<_i243.FilterRepository>(
      () => _i120.FilterRepositoryImpl(
        dataProvider: gh<_i443.FilterDataProvider>(),
      ),
    );
    gh.singleton<_i984.GetChatList>(
      () => _i984.GetChatList(
        chatRepository: gh<_i243.ChatRepository>(),
        appStateService: gh<_i697.AppStateService>(),
      ),
    );
    gh.singleton<_i830.GetDetailChat>(
      () => _i830.GetDetailChat(
        chatRepository: gh<_i243.ChatRepository>(),
        appStateService: gh<_i697.AppStateService>(),
      ),
    );
    gh.singleton<_i775.SendMessageToChat>(
      () => _i775.SendMessageToChat(
        chatRepository: gh<_i243.ChatRepository>(),
        appStateService: gh<_i697.AppStateService>(),
      ),
    );
    gh.singleton<_i558.SetReadChat>(
      () => _i558.SetReadChat(
        chatRepository: gh<_i243.ChatRepository>(),
        appStateService: gh<_i697.AppStateService>(),
      ),
    );
    gh.singleton<_i749.LoadQueueMessage>(
      () => _i749.LoadQueueMessage(chatRepository: gh<_i243.ChatRepository>()),
    );
    gh.singleton<_i894.SaveQueueMessage>(
      () => _i894.SaveQueueMessage(chatRepository: gh<_i243.ChatRepository>()),
    );
    gh.lazySingleton<_i76.PersonListCubit>(
      () => _i76.PersonListCubit(
        getPersonList: gh<_i25.GetPersonList>(),
        propertiesService: gh<_i588.PropertiesService>(),
        createNewPerson: gh<_i25.CreateNewPerson>(),
      ),
    );
    gh.singleton<_i91.GetListDatingPerson>(
      () => _i91.GetListDatingPerson(
        datingRepository: gh<_i243.DatingRepository>(),
        appStateService: gh<_i523.AppStateService>(),
      ),
    );
    gh.singleton<_i616.ClearFilterState>(
      () => _i616.ClearFilterState(
        filterRepository: gh<_i243.FilterRepository>(),
      ),
    );
    gh.singleton<_i751.GetFilterState>(
      () =>
          _i751.GetFilterState(filterRepository: gh<_i243.FilterRepository>()),
    );
    gh.singleton<_i372.SaveFilterState>(
      () =>
          _i372.SaveFilterState(filterRepository: gh<_i243.FilterRepository>()),
    );
    gh.singleton<_i325.DeleteOlderData>(
      () => _i325.DeleteOlderData(
        appStateService: gh<_i523.AppStateService>(),
        datingRepository: gh<_i243.DatingRepository>(),
      ),
    );
    gh.singleton<_i110.GetSwipeCountToDay>(
      () => _i110.GetSwipeCountToDay(
        appStateService: gh<_i523.AppStateService>(),
        datingRepository: gh<_i243.DatingRepository>(),
      ),
    );
    gh.singleton<_i866.LikePerson>(
      () => _i866.LikePerson(
        appStateService: gh<_i523.AppStateService>(),
        datingRepository: gh<_i243.DatingRepository>(),
      ),
    );
    gh.singleton<_i981.SkipPerson>(
      () => _i981.SkipPerson(
        appStateService: gh<_i523.AppStateService>(),
        datingRepository: gh<_i243.DatingRepository>(),
      ),
    );
    gh.singleton<_i926.UndoLast>(
      () => _i926.UndoLast(
        appStateService: gh<_i523.AppStateService>(),
        datingRepository: gh<_i243.DatingRepository>(),
      ),
    );
    gh.singleton<_i243.AuthAdminRepository>(
      () => _i956.AuthAdminRepositoryImpl(
        dataProvider: gh<_i752.AuthAdminDataProvider>(),
        appStateService: gh<_i523.AppStateService>(),
      ),
    );
    gh.lazySingleton<_i103.FilterCubit>(
      () => _i103.FilterCubit(
        getFilterState: gh<_i25.GetFilterState>(),
        saveFilterState: gh<_i25.SaveFilterState>(),
        clearFilterState: gh<_i25.ClearFilterState>(),
      ),
    );
    gh.singleton<_i243.RegistrationFormRepository>(
      () => _i789.RegistrationFormRepositoryImpl(
        dataProvider: gh<_i443.RegistrationFormDataProvider>(),
      ),
    );
    gh.singleton<_i310.ChatCubit>(
      () => _i310.ChatCubit(
        cretaeNewChat: gh<_i25.CreateNewChat>(),
        getChatList: gh<_i25.GetChatList>(),
        sendMessageToChat: gh<_i25.SendMessageToChat>(),
        detailOfPerson: gh<_i25.GetDetailOfPerson>(),
        aiAgentService: gh<_i845.AIAgentService>(),
        setReadChat: gh<_i25.SetReadChat>(),
      ),
    );
    gh.singleton<_i468.TickerBloc>(
      () => _i468.TickerBloc(
        spacyClient: gh<_i146.SpacyAPIClient>(),
        remoteConfig: gh<_i327.RemoteConfigService>(),
        securiteStore: gh<_i521.SecureStorageService>(),
        loadQueueMessage: gh<_i25.LoadQueueMessage>(),
        saveQueueMessage: gh<_i25.SaveQueueMessage>(),
        chatCubit: gh<_i310.ChatCubit>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.singleton<_i243.ProfileRepository>(
      () => _i473.ProfileRepositoryImpl(
        dataProvider: gh<_i443.ProfileDataProvider>(),
      ),
    );
    gh.singleton<_i367.DatingCubit>(
      () => _i367.DatingCubit(
        getListDatingPerson: gh<_i25.GetListDatingPerson>(),
        likePerson: gh<_i25.LikePerson>(),
        skipPerson: gh<_i25.SkipPerson>(),
        undoLast: gh<_i25.UndoLast>(),
        countToDay: gh<_i25.GetSwipeCountToDay>(),
        deleteOlderData: gh<_i25.DeleteOlderData>(),
        appStateService: gh<_i523.AppStateService>(),
        chatCubit: gh<_i310.ChatCubit>(),
      ),
    );
    gh.singleton<_i194.GetProfile>(
      () => _i194.GetProfile(
        profileRepository: gh<_i243.ProfileRepository>(),
        appStateService: gh<_i523.AppStateService>(),
      ),
    );
    gh.singleton<_i732.ClearRegistrationFormData>(
      () => _i732.ClearRegistrationFormData(
        registrationFormRepository: gh<_i243.RegistrationFormRepository>(),
      ),
    );
    gh.singleton<_i344.LoadRegistrationFormData>(
      () => _i344.LoadRegistrationFormData(
        registrationFormRepository: gh<_i243.RegistrationFormRepository>(),
      ),
    );
    gh.singleton<_i220.SaveRegistrationFormData>(
      () => _i220.SaveRegistrationFormData(
        registrationFormRepository: gh<_i243.RegistrationFormRepository>(),
      ),
    );
    gh.singleton<_i799.AuthByAdmin>(
      () => _i799.AuthByAdmin(
        authAdminRepository: gh<_i243.AuthAdminRepository>(),
        appStateService: gh<_i523.AppStateService>(),
      ),
    );
    gh.singleton<_i398.InitAdmin>(
      () => _i398.InitAdmin(
        authAdminRepository: gh<_i243.AuthAdminRepository>(),
        appStateService: gh<_i523.AppStateService>(),
      ),
    );
    gh.singleton<_i182.LogoutAdmin>(
      () => _i182.LogoutAdmin(
        authAdminRepository: gh<_i243.AuthAdminRepository>(),
        appStateService: gh<_i523.AppStateService>(),
      ),
    );
    gh.singleton<_i666.ForgotAdminPassword>(
      () => _i666.ForgotAdminPassword(
        authAdminRepository: gh<_i243.AuthAdminRepository>(),
      ),
    );
    gh.singleton<_i942.UpdateProfile>(
      () => _i942.UpdateProfile(
        profileRepository: gh<_i243.ProfileRepository>(),
        appStateService: gh<_i697.AppStateService>(),
      ),
    );
    gh.singleton<_i851.DeleteProfile>(
      () => _i851.DeleteProfile(
        appStateService: gh<_i523.AppStateService>(),
        profileRepository: gh<_i243.ProfileRepository>(),
        chatRepository: gh<_i243.ChatRepository>(),
        datingRepository: gh<_i243.DatingRepository>(),
        filterRepository: gh<_i243.FilterRepository>(),
        settingsRepository: gh<_i243.SettingsRepository>(),
        registrationFormRepository: gh<_i243.RegistrationFormRepository>(),
      ),
    );
    gh.singleton<_i761.RegistrationCubit>(
      () => _i761.RegistrationCubit(
        saveRegistrationData: gh<_i25.SaveRegistrationFormData>(),
        loadRegistrationData: gh<_i25.LoadRegistrationFormData>(),
        clearRegistrationData: gh<_i25.ClearRegistrationFormData>(),
        registrationNewUserByGuest: gh<_i25.RegistrationNewUserByGuest>(),
        saveFilterState: gh<_i25.SaveFilterState>(),
        clearFilterState: gh<_i25.ClearFilterState>(),
        getProfile: gh<_i25.GetProfile>(),
      ),
    );
    gh.singleton<_i227.ProfileCubit>(
      () => _i227.ProfileCubit(
        getProfileGuest: gh<_i25.GetProfile>(),
        deleteProfile: gh<_i25.DeleteProfile>(),
        updateProfile: gh<_i25.UpdateProfile>(),
        registrationCubit: gh<_i761.RegistrationCubit>(),
      ),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i362.ThirdPartyModule {}

class _$HttpClientModule extends _i1066.HttpClientModule {}
