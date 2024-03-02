package android;

#if (!android && !native && macro)
#error 'extension-androidtools is not supported on your current platform'
#end

import lime.system.JNI;

/**
 * @author Mihai Alexandru (M.A. Jigsaw)
 */
#if !debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
@:access(lime.system.JNI)
class Permissions
{
	/**
	 * Checks whether the app already has the given permission.
	 * Returns the granted permissions.
	 */
	public static function getGrantedPermissions():Array<String>
	{
		var getGrantedPermissionsJNI:Dynamic = JNI.createStaticMethod('org/haxe/extension/Permissions', 'getGrantedPermissions', '()[Ljava/lang/String;');
		return getGrantedPermissionsJNI();
	}

	/**
	 * Displays a dialog requesting all of the given permissions at once.
	 * This dialog will be displayed even if the user already granted the permissions, allowing them to disable them if they like.
	 * 
	 * @param permissions the array of permissions.
	 * @param requestCode the code that should be requested.
	 */
	public static function requestPermissions(permissions:Array<String>, requestCode:Int = 1):Void
	{
		var requestPermissionsJNI:Dynamic = JNI.createStaticMethod('org/haxe/extension/Permissions', 'requestPermissions', '([Ljava/lang/String;I)V');
		requestPermissionsJNI(permissions, requestCode);
	}
}

/**
 * Almost all Android Permissions.
 */
enum abstract PermissionsList(String) to String from String
{
	public static final ACCEPT_HANDOVER = 'android.permission.ACCEPT_HANDOVER';
	public static final ACCESS_BACKGROUND_LOCATION = 'android.permission.ACCESS_BACKGROUND_LOCATION';
	public static final ACCESS_BLOBS_ACROSS_USERS = 'android.permission.ACCESS_BLOBS_ACROSS_USERS';
	public static final ACCESS_CHECKIN_PROPERTIES = 'android.permission.ACCESS_CHECKIN_PROPERTIES';
	public static final ACCESS_COARSE_LOCATION = 'android.permission.ACCESS_COARSE_LOCATION';
	public static final ACCESS_FINE_LOCATION = 'android.permission.ACCESS_FINE_LOCATION';
	public static final ACCESS_LOCATION_EXTRA_COMMANDS = 'android.permission.ACCESS_LOCATION_EXTRA_COMMANDS';
	public static final ACCESS_MEDIA_LOCATION = 'android.permission.ACCESS_MEDIA_LOCATION';
	public static final ACCESS_NETWORK_STATE = 'android.permission.ACCESS_NETWORK_STATE';
	public static final ACCESS_NOTIFICATION_POLICY = 'android.permission.ACCESS_NOTIFICATION_POLICY';
	public static final ACCESS_SUPPLEMENTAL_APIS = 'android.permission.ACCESS_SUPPLEMENTAL_APIS';
	public static final ACCESS_WIFI_STATE = 'android.permission.ACCESS_WIFI_STATE';
	public static final ACCOUNT_MANAGER = 'android.permission.ACCOUNT_MANAGER';
	public static final ACTIVITY_RECOGNITION = 'android.permission.ACTIVITY_RECOGNITION';
	public static final ADD_VOICEMAIL = 'android.permission.ADD_VOICEMAIL';
	public static final ANSWER_PHONE_CALLS = 'android.permission.ANSWER_PHONE_CALLS';
	public static final BATTERY_STATS = 'android.permission.BATTERY_STATS';
	public static final BIND_ACCESSIBILITY_SERVICE = 'android.permission.BIND_ACCESSIBILITY_SERVICE';
	public static final BIND_APPWIDGET = 'android.permission.BIND_APPWIDGET';
	public static final BIND_AUTOFILL_SERVICE = 'android.permission.BIND_AUTOFILL_SERVICE';
	public static final BIND_CALL_REDIRECTION_SERVICE = 'android.permission.BIND_CALL_REDIRECTION_SERVICE';
	public static final BIND_CARRIER_MESSAGING_CLIENT_SERVICE = 'android.permission.BIND_CARRIER_MESSAGING_CLIENT_SERVICE';
	public static final BIND_CARRIER_MESSAGING_SERVICE = 'android.permission.BIND_CARRIER_MESSAGING_SERVICE';
	public static final BIND_CARRIER_SERVICES = 'android.permission.BIND_CARRIER_SERVICES';
	public static final BIND_CHOOSER_TARGET_SERVICE = 'android.permission.BIND_CHOOSER_TARGET_SERVICE';
	public static final BIND_COMPANION_DEVICE_SERVICE = 'android.permission.BIND_COMPANION_DEVICE_SERVICE';
	public static final BIND_CONDITION_PROVIDER_SERVICE = 'android.permission.BIND_CONDITION_PROVIDER_SERVICE';
	public static final BIND_CONTROLS = 'android.permission.BIND_CONTROLS';
	public static final BIND_DEVICE_ADMIN = 'android.permission.BIND_DEVICE_ADMIN';
	public static final BIND_DREAM_SERVICE = 'android.permission.BIND_DREAM_SERVICE';
	public static final BIND_INCALL_SERVICE = 'android.permission.BIND_INCALL_SERVICE';
	public static final BIND_INPUT_METHOD = 'android.permission.BIND_INPUT_METHOD';
	public static final BIND_MIDI_DEVICE_SERVICE = 'android.permission.BIND_MIDI_DEVICE_SERVICE';
	public static final BIND_NFC_SERVICE = 'android.permission.BIND_NFC_SERVICE';
	public static final BIND_NOTIFICATION_LISTENER_SERVICE = 'android.permission.BIND_NOTIFICATION_LISTENER_SERVICE';
	public static final BIND_PRINT_SERVICE = 'android.permission.BIND_PRINT_SERVICE';
	public static final BIND_QUICK_ACCESS_WALLET_SERVICE = 'android.permission.BIND_QUICK_ACCESS_WALLET_SERVICE';
	public static final BIND_QUICK_SETTINGS_TILE = 'android.permission.BIND_QUICK_SETTINGS_TILE';
	public static final BIND_REMOTEVIEWS = 'android.permission.BIND_REMOTEVIEWS';
	public static final BIND_SCREENING_SERVICE = 'android.permission.BIND_SCREENING_SERVICE';
	public static final BIND_TELECOM_CONNECTION_SERVICE = 'android.permission.BIND_TELECOM_CONNECTION_SERVICE';
	public static final BIND_TEXT_SERVICE = 'android.permission.BIND_TEXT_SERVICE';
	public static final BIND_TV_INPUT = 'android.permission.BIND_TV_INPUT';
	public static final BIND_TV_INTERACTIVE_APP = 'android.permission.BIND_TV_INTERACTIVE_APP';
	public static final BIND_VISUAL_VOICEMAIL_SERVICE = 'android.permission.BIND_VISUAL_VOICEMAIL_SERVICE';
	public static final BIND_VOICE_INTERACTION = 'android.permission.BIND_VOICE_INTERACTION';
	public static final BIND_VPN_SERVICE = 'android.permission.BIND_VPN_SERVICE';
	public static final BIND_VR_LISTENER_SERVICE = 'android.permission.BIND_VR_LISTENER_SERVICE';
	public static final BIND_WALLPAPER = 'android.permission.BIND_WALLPAPER';
	public static final BLUETOOTH = 'android.permission.BLUETOOTH';
	public static final BLUETOOTH_ADMIN = 'android.permission.BLUETOOTH_ADMIN';
	public static final BLUETOOTH_ADVERTISE = 'android.permission.BLUETOOTH_ADVERTISE';
	public static final BLUETOOTH_CONNECT = 'android.permission.BLUETOOTH_CONNECT';
	public static final BLUETOOTH_PRIVILEGED = 'android.permission.BLUETOOTH_PRIVILEGED';
	public static final BLUETOOTH_SCAN = 'android.permission.BLUETOOTH_SCAN';
	public static final BODY_SENSORS = 'android.permission.BODY_SENSORS';
	public static final BODY_SENSORS_BACKGROUND = 'android.permission.BODY_SENSORS_BACKGROUND';
	public static final BROADCAST_PACKAGE_REMOVED = 'android.permission.BROADCAST_PACKAGE_REMOVED';
	public static final BROADCAST_SMS = 'android.permission.BROADCAST_SMS';
	public static final BROADCAST_STICKY = 'android.permission.BROADCAST_STICKY';
	public static final BROADCAST_WAP_PUSH = 'android.permission.BROADCAST_WAP_PUSH';
	public static final CALL_COMPANION_APP = 'android.permission.CALL_COMPANION_APP';
	public static final CALL_PHONE = 'android.permission.CALL_PHONE';
	public static final CALL_PRIVILEGED = 'android.permission.CALL_PRIVILEGED';
	public static final CAMERA = 'android.permission.CAMERA';
	public static final CAPTURE_AUDIO_OUTPUT = 'android.permission.CAPTURE_AUDIO_OUTPUT';
	public static final CHANGE_COMPONENT_ENABLED_STATE = 'android.permission.CHANGE_COMPONENT_ENABLED_STATE';
	public static final CHANGE_CONFIGURATION = 'android.permission.CHANGE_CONFIGURATION';
	public static final CHANGE_NETWORK_STATE = 'android.permission.CHANGE_NETWORK_STATE';
	public static final CHANGE_WIFI_MULTICAST_STATE = 'android.permission.CHANGE_WIFI_MULTICAST_STATE';
	public static final CHANGE_WIFI_STATE = 'android.permission.CHANGE_WIFI_STATE';
	public static final CLEAR_APP_CACHE = 'android.permission.CLEAR_APP_CACHE';
	public static final CONTROL_LOCATION_UPDATES = 'android.permission.CONTROL_LOCATION_UPDATES';
	public static final DELETE_CACHE_FILES = 'android.permission.DELETE_CACHE_FILES';
	public static final DELETE_PACKAGES = 'android.permission.DELETE_PACKAGES';
	public static final DELIVER_COMPANION_MESSAGES = 'android.permission.DELIVER_COMPANION_MESSAGES';
	public static final DIAGNOSTIC = 'android.permission.DIAGNOSTIC';
	public static final DISABLE_KEYGUARD = 'android.permission.DISABLE_KEYGUARD';
	public static final DUMP = 'android.permission.DUMP';
	public static final EXPAND_STATUS_BAR = 'android.permission.EXPAND_STATUS_BAR';
	public static final FACTORY_TEST = 'android.permission.FACTORY_TEST';
	public static final FOREGROUND_SERVICE = 'android.permission.FOREGROUND_SERVICE';
	public static final GET_ACCOUNTS = 'android.permission.GET_ACCOUNTS';
	public static final GET_ACCOUNTS_PRIVILEGED = 'android.permission.GET_ACCOUNTS_PRIVILEGED';
	public static final GET_PACKAGE_SIZE = 'android.permission.GET_PACKAGE_SIZE';
	public static final GET_TASKS = 'android.permission.GET_TASKS';
	public static final GLOBAL_SEARCH = 'android.permission.GLOBAL_SEARCH';
	public static final HIDE_OVERLAY_WINDOWS = 'android.permission.HIDE_OVERLAY_WINDOWS';
	public static final HIGH_SAMPLING_RATE_SENSORS = 'android.permission.HIGH_SAMPLING_RATE_SENSORS';
	public static final INSTALL_LOCATION_PROVIDER = 'android.permission.INSTALL_LOCATION_PROVIDER';
	public static final INSTALL_PACKAGES = 'android.permission.INSTALL_PACKAGES';
	public static final INSTALL_SHORTCUT = 'android.permission.INSTALL_SHORTCUT';
	public static final INSTANT_APP_FOREGROUND_SERVICE = 'android.permission.INSTANT_APP_FOREGROUND_SERVICE';
	public static final INTERACT_ACROSS_PROFILES = 'android.permission.INTERACT_ACROSS_PROFILES';
	public static final INTERNET = 'android.permission.INTERNET';
	public static final KILL_BACKGROUND_PROCESSES = 'android.permission.KILL_BACKGROUND_PROCESSES';
	public static final LAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK = 'android.permission.LAUNCH_MULTI_PANE_SETTINGS_DEEP_LINK';
	public static final LOADER_USAGE_STATS = 'android.permission.LOADER_USAGE_STATS';
	public static final LOCATION_HARDWARE = 'android.permission.LOCATION_HARDWARE';
	public static final MANAGE_DOCUMENTS = 'android.permission.MANAGE_DOCUMENTS';
	public static final MANAGE_EXTERNAL_STORAGE = 'android.permission.MANAGE_EXTERNAL_STORAGE';
	public static final MANAGE_MEDIA = 'android.permission.MANAGE_MEDIA';
	public static final MANAGE_ONGOING_CALLS = 'android.permission.MANAGE_ONGOING_CALLS';
	public static final MANAGE_OWN_CALLS = 'android.permission.MANAGE_OWN_CALLS';
	public static final MANAGE_WIFI_AUTO_JOIN = 'android.permission.MANAGE_WIFI_AUTO_JOIN';
	public static final MANAGE_WIFI_INTERFACES = 'android.permission.MANAGE_WIFI_INTERFACES';
	public static final MASTER_CLEAR = 'android.permission.MASTER_CLEAR';
	public static final MEDIA_CONTENT_CONTROL = 'android.permission.MEDIA_CONTENT_CONTROL';
	public static final MODIFY_AUDIO_SETTINGS = 'android.permission.MODIFY_AUDIO_SETTINGS';
	public static final MODIFY_PHONE_STATE = 'android.permission.MODIFY_PHONE_STATE';
	public static final MOUNT_FORMAT_FILESYSTEMS = 'android.permission.MOUNT_FORMAT_FILESYSTEMS';
	public static final MOUNT_UNMOUNT_FILESYSTEMS = 'android.permission.MOUNT_UNMOUNT_FILESYSTEMS';
	public static final NEARBY_WIFI_DEVICES = 'android.permission.NEARBY_WIFI_DEVICES';
	public static final NFC = 'android.permission.NFC';
	public static final NFC_PREFERRED_PAYMENT_INFO = 'android.permission.NFC_PREFERRED_PAYMENT_INFO';
	public static final NFC_TRANSACTION_EVENT = 'android.permission.NFC_TRANSACTION_EVENT';
	public static final OVERRIDE_WIFI_CONFIG = 'android.permission.OVERRIDE_WIFI_CONFIG';
	public static final PACKAGE_USAGE_STATS = 'android.permission.PACKAGE_USAGE_STATS';
	public static final PERSISTENT_ACTIVITY = 'android.permission.PERSISTENT_ACTIVITY';
	public static final POST_NOTIFICATIONS = 'android.permission.POST_NOTIFICATIONS';
	public static final PROCESS_OUTGOING_CALLS = 'android.permission.PROCESS_OUTGOING_CALLS';
	public static final QUERY_ALL_PACKAGES = 'android.permission.QUERY_ALL_PACKAGES';
	public static final READ_ASSISTANT_APP_SEARCH_DATA = 'android.permission.READ_ASSISTANT_APP_SEARCH_DATA';
	public static final READ_BASIC_PHONE_STATE = 'android.permission.READ_BASIC_PHONE_STATE';
	public static final READ_CALENDAR = 'android.permission.READ_CALENDAR';
	public static final READ_CALL_LOG = 'android.permission.READ_CALL_LOG';
	public static final READ_CONTACTS = 'android.permission.READ_CONTACTS';
	public static final READ_EXTERNAL_STORAGE = 'android.permission.READ_EXTERNAL_STORAGE';
	public static final READ_HOME_APP_SEARCH_DATA = 'android.permission.READ_HOME_APP_SEARCH_DATA';
	public static final READ_INPUT_STATE = 'android.permission.READ_INPUT_STATE';
	public static final READ_LOGS = 'android.permission.READ_LOGS';
	public static final READ_MEDIA_AUDIO = 'android.permission.READ_MEDIA_AUDIO';
	public static final READ_MEDIA_IMAGE = 'android.permission.READ_MEDIA_IMAGE';
	public static final READ_MEDIA_VIDEO = 'android.permission.READ_MEDIA_VIDEO';
	public static final READ_NEARBY_STREAMING_POLICY = 'android.permission.READ_NEARBY_STREAMING_POLICY';
	public static final READ_PHONE_NUMBERS = 'android.permission.READ_PHONE_NUMBERS';
	public static final READ_PHONE_STATE = 'android.permission.READ_PHONE_STATE';
	public static final READ_PRECISE_PHONE_STATE = 'android.permission.READ_PRECISE_PHONE_STATE';
	public static final READ_SMS = 'android.permission.READ_SMS';
	public static final READ_SYNC_SETTINGS = 'android.permission.READ_SYNC_SETTINGS';
	public static final READ_SYNC_STATS = 'android.permission.READ_SYNC_STATS';
	public static final READ_VOICEMAIL = 'android.permission.READ_VOICEMAIL';
	public static final REBOOT = 'android.permission.REBOOT';
	public static final RECEIVE_BOOT_COMPLETED = 'android.permission.RECEIVE_BOOT_COMPLETED';
	public static final RECEIVE_MMS = 'android.permission.RECEIVE_MMS';
	public static final RECEIVE_SMS = 'android.permission.RECEIVE_SMS';
	public static final RECEIVE_WAP_PUSH = 'android.permission.RECEIVE_WAP_PUSH';
	public static final RECORD_AUDIO = 'android.permission.RECORD_AUDIO';
	public static final REORDER_TASKS = 'android.permission.REORDER_TASKS';
	public static final REQUEST_COMPANION_PROFILE_APP_STREAMING = 'android.permission.REQUEST_COMPANION_PROFILE_APP_STREAMING';
	public static final REQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION = 'android.permission.REQUEST_COMPANION_PROFILE_AUTOMOTIVE_PROJECTION';
	public static final REQUEST_COMPANION_PROFILE_COMPUTER = 'android.permission.REQUEST_COMPANION_PROFILE_COMPUTER';
	public static final REQUEST_COMPANION_PROFILE_WATCH = 'android.permission.REQUEST_COMPANION_PROFILE_WATCH';
	public static final REQUEST_COMPANION_RUN_IN_BACKGROUND = 'android.permission.REQUEST_COMPANION_RUN_IN_BACKGROUND';
	public static final REQUEST_COMPANION_SELF_MANAGED = 'android.permission.REQUEST_COMPANION_SELF_MANAGED';
	public static final REQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND = 'android.permission.REQUEST_COMPANION_START_FOREGROUND_SERVICES_FROM_BACKGROUND';
	public static final REQUEST_COMPANION_USE_DATA_IN_BACKGROUND = 'android.permission.REQUEST_COMPANION_USE_DATA_IN_BACKGROUND';
	public static final REQUEST_DELETE_PACKAGES = 'android.permission.REQUEST_DELETE_PACKAGES';
	public static final REQUEST_IGNORE_BATTERY_OPTIMIZATIONS = 'android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS';
	public static final REQUEST_INSTALL_PACKAGES = 'android.permission.REQUEST_INSTALL_PACKAGES';
	public static final REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE = 'android.permission.REQUEST_OBSERVE_COMPANION_DEVICE_PRESENCE';
	public static final REQUEST_PASSWORD_COMPLEXITY = 'android.permission.REQUEST_PASSWORD_COMPLEXITY';
	public static final RESTART_PACKAGES = 'android.permission.RESTART_PACKAGES';
	public static final SCHEDULE_EXACT_ALARM = 'android.permission.SCHEDULE_EXACT_ALARM';
	public static final SEND_RESPOND_VIA_MESSAGE = 'android.permission.SEND_RESPOND_VIA_MESSAGE';
	public static final SEND_SMS = 'android.permission.SEND_SMS';
	public static final SET_ALARM = 'android.permission.SET_ALARM';
	public static final SET_ALWAYS_FINISH = 'android.permission.SET_ALWAYS_FINISH';
	public static final SET_ANIMATION_SCALE = 'android.permission.SET_ANIMATION_SCALE';
	public static final SET_DEBUG_APP = 'android.permission.SET_DEBUG_APP';
	public static final SET_PREFERRED_APPLICATIONS = 'android.permission.SET_PREFERRED_APPLICATIONS';
	public static final SET_PROCESS_LIMIT = 'android.permission.SET_PROCESS_LIMIT';
	public static final SET_TIME = 'android.permission.SET_TIME';
	public static final SET_TIME_ZONE = 'android.permission.SET_TIME_ZONE';
	public static final SET_WALLPAPER = 'android.permission.SET_WALLPAPER';
	public static final SET_WALLPAPER_HINTS = 'android.permission.SET_WALLPAPER_HINTS';
	public static final SIGNAL_PERSISTENT_PROCESSES = 'android.permission.SIGNAL_PERSISTENT_PROCESSES';
	public static final SMS_FINANCIAL_TRANSACTIONS = 'android.permission.SMS_FINANCIAL_TRANSACTIONS';
	public static final START_FOREGROUND_SERVICES_FROM_BACKGROUND = 'android.permission.START_FOREGROUND_SERVICES_FROM_BACKGROUND';
	public static final START_VIEW_APP_FEATURES = 'android.permission.START_VIEW_APP_FEATURES';
	public static final START_VIEW_PERMISSION_USAGE = 'android.permission.START_VIEW_PERMISSION_USAGE';
	public static final STATUS_BAR = 'android.permission.STATUS_BAR';
	public static final SYSTEM_ALERT_WINDOW = 'android.permission.SYSTEM_ALERT_WINDOW';
	public static final TRANSMIT_IR = 'android.permission.TRANSMIT_IR';
	public static final UNINSTALL_SHORTCUT = 'android.permission.UNINSTALL_SHORTCUT';
	public static final UPDATE_DEVICE_STATS = 'android.permission.UPDATE_DEVICE_STATS';
	public static final UPDATE_PACKAGES_WITHOUT_USER_ACTION = 'android.permission.UPDATE_PACKAGES_WITHOUT_USER_ACTION';
	public static final USE_BIOMETRIC = 'android.permission.USE_BIOMETRIC';
	public static final USE_EXACT_ALARM = 'android.permission.USE_EXACT_ALARM';
	public static final USE_FINGERPRINT = 'android.permission.USE_FINGERPRINT';
	public static final USE_FULL_SCREEN_INTENT = 'android.permission.USE_FULL_SCREEN_INTENT';
	public static final USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER = 'android.permission.USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER';
	public static final USE_SIP = 'android.permission.USE_SIP';
	public static final UWB_RANGING = 'android.permission.UWB_RANGING';
	public static final VIBRATE = 'android.permission.VIBRATE';
	public static final WAKE_LOCK = 'android.permission.WAKE_LOCK';
	public static final WRITE_APN_SETTINGS = 'android.permission.WRITE_APN_SETTINGS';
	public static final WRITE_CALENDAR = 'android.permission.WRITE_CALENDAR';
	public static final WRITE_CALL_LOG = 'android.permission.WRITE_CALL_LOG';
	public static final WRITE_CONTACTS = 'android.permission.WRITE_CONTACTS';
	public static final WRITE_EXTERNAL_STORAGE = 'android.permission.WRITE_EXTERNAL_STORAGE';
	public static final WRITE_GSERVICES = 'android.permission.WRITE_GSERVICES';
	public static final WRITE_SECURE_SETTINGS = 'android.permission.WRITE_SECURE_SETTINGS';
	public static final WRITE_SETTINGS = 'android.permission.WRITE_SETTINGS';
	public static final WRITE_SYNC_SETTINGS = 'android.permission.WRITE_SYNC_SETTINGS';
	public static final WRITE_VOICEMAIL = 'android.permission.WRITE_VOICEMAIL';
}