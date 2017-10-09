#!/bin/bash
set -e

        if [ -n "$MYSQL_PORT_3306_TCP" ]; then
                if [ -z "$WORDPRESS_DB_HOST" ]; then
                        WORDPRESS_DB_HOST='mysql'
                else
                        echo >&2 'warning: both WORDPRESS_DB_HOST and MYSQL_PORT_3306_TCP found'
                        echo >&2 "  Connecting to WORDPRESS_DB_HOST ($WORDPRESS_DB_HOST)"
                        echo >&2 '  instead of the linked mysql container'
                fi
        fi

        if [ -z "$WORDPRESS_DB_HOST" ]; then
                echo >&2 'error: missing WORDPRESS_DB_HOST and MYSQL_PORT_3306_TCP environment variables'
                echo >&2 '  Did you forget to --link some_mysql_container:mysql or set an external db'
                echo >&2 '  with -e WORDPRESS_DB_HOST=hostname:port?'
                exit 1
        fi

        # if we're linked to MySQL, and we're using the root user, and our linked
        # container has a default "root" password set up and passed through... :)
        : ${WORDPRESS_DB_USER:=root}
        if [ "$WORDPRESS_DB_USER" = 'root' ]; then
                : ${WORDPRESS_DB_PASSWORD:=$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
        fi
        : ${WORDPRESS_DB_NAME:=wordpress}

        if [ -z "$WORDPRESS_DB_PASSWORD" ]; then
                echo >&2 'error: missing required WORDPRESS_DB_PASSWORD environment variable'
                echo >&2 '  Did you forget to -e WORDPRESS_DB_PASSWORD=... ?'
                echo >&2
                echo >&2 '  (Also of interest might be WORDPRESS_DB_USER and WORDPRESS_DB_NAME.)'
                exit 1
        fi


        sed_escape_lhs() {
                echo "$@" | sed 's/[]\/$*.^|[]/\\&/g'
        }
        sed_escape_rhs() {
                echo "$@" | sed 's/[\/&]/\\&/g'
        }
        php_escape() {
                php -r 'var_export((string) $argv[1]);' "$1"
        }
        set_config() {
                key="$1"
                value="$2"
                regex="(['\"])$(sed_escape_lhs "$key")\2\s*,"
                if [ "${key:0:1}" = '$' ]; then
                        regex="^(\s*)$(sed_escape_lhs "$key")\s*="
                fi
                sed -ri "s/($regex\s*)(['\"]).*\3/\1$(sed_escape_rhs "$(php_escape "$value")")/" /usr/share/nginx/www/wp-config.php
        }

        set_config 'DB_HOST' "$WORDPRESS_DB_HOST"
        set_config 'DB_USER' "$WORDPRESS_DB_USER"
        set_config 'DB_PASSWORD' "$WORDPRESS_DB_PASSWORD"
        set_config 'DB_NAME' "$WORDPRESS_DB_NAME"

exec "$@"
