<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** LOCAL DEV ENVIRONMENT ** //
if ( file_exists( dirname( __FILE__ ) . '/local-config.php' ) ) {

	/** Include Local Config */
	include( dirname( __FILE__ ) . '/local-config.php' );

	/** Turn Debugging ON */
	define( 'WP_DEBUG', true );
	
	
} else {

	/** Database Settings **/
	define( 'DB_NAME', 'live_database_name_here' );
	define( 'DB_USER', 'live_username_here' );
	define( 'DB_PASSWORD', 'live_password_here' );
	define( 'DB_HOST', 'localhost' );

	/** Turn Debugging OFF */
	define( 'WP_DEBUG', false );
}

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/******************
 * Other settings *
 ******************/

/* Memory Limit */
//define( 'WP_MEMORY_LIMIT', '64M' );

/* Specify maximum number of Revisions. */
define( 'WP_POST_REVISIONS', '5' );

/* Media Trash. */
// define( 'MEDIA_TRASH', true );

/* SSL */
// define( 'FORCE_SSL_LOGIN', true );
// define( 'FORCE_SSL_ADMIN', true );

/* Multisite. */
// define( 'WP_ALLOW_MULTISITE', true );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 * @link http://codex.wordpress.org/Debugging_in_WordPress
 */
if ( WP_DEBUG ) {
  /* Tells WordPress to log everything to the /wp-content/debug.log file */
  define( 'WP_DEBUG_LOG', true );

  /* Hides debug errors inside the HTML (using DEBUG_LOG instead) */
  define( 'WP_DEBUG_DISPLAY', false );
  @ini_set( 'display_errors', 0 );

  /* This will force WordPress to use the "dev" versions of core CSS and Javascript files rather than the minified versions that are normally loaded. This is useful when you are testing modifications to any built-in .js or .css files. Default is false. */
  define('SCRIPT_DEBUG', true);

  /* The SAVEQUERIES definition saves the database queries to an array and that array can be displayed to help analyze those queries. The information saves each query, what function called it, and how long that query took to execute. */
  define('SAVEQUERIES', true);  
}

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');