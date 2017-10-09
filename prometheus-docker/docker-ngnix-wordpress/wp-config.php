<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'database_name_here');

/** MySQL database username */
define('DB_USER', 'username_here');

/** MySQL database password */
define('DB_PASSWORD', 'password_here');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'xaeViephiesh5var7peix1ea1guNgiengetozaiw0eiGhaupaiPh0eitet8eicaem');
define('SECURE_AUTH_KEY',  'thaisoo3QuouzaJeengaeleedeih1ereiwe6ahse0Veevoi4Cei5shoc1Vie0roon');
define('LOGGED_IN_KEY',    'phaa0quoh4ooKieShahb5aoXep1oothaiWah3eechoo1be1bohsie6oecoovoo6fi');
define('NONCE_KEY',        'ahlaequieBai6kaiveishaeleiNgoophie2eingo2oa1thushi5aimoosievuu6ai');
define('AUTH_SALT',        'giek1Fuu3ooy4Cahj9iep3roo1zooMaithahnge3ei3eiGhoot5Iekac9ahh6Jei8');
define('SECURE_AUTH_SALT', 'oshaoGei1yahCaizie8noo9ohcoo6der9Ais6fuxi9aoMee7guip0ohquah0sooyo');
define('LOGGED_IN_SALT',   'Eizie3Yoh7Oovib0yah9rooshe8go7shai6eicoo5AaNgaitoh0cho6ua3quilaht');
define('NONCE_SALT',       'quai5eiphiPh2phahj6thoo6eih9TaNgingih8teePiehaith0ii4phae8yof6chu');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/* Multisite */
define( 'WP_ALLOW_MULTISITE', true );

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
$plugins = get_option( 'active_plugins' );
if ( count( $plugins ) === 0 ) {
  require_once(ABSPATH .'/wp-admin/includes/plugin.php');
  $pluginsToActivate = array( 'nginx-helper/nginx-helper.php' );
  foreach ( $pluginsToActivate as $plugin ) {
    if ( !in_array( $plugin, $plugins ) ) {
      activate_plugin( '/usr/share/nginx/www/wp-content/plugins/' . $plugin );
    }
  }
}
