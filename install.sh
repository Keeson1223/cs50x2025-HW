#!/bin/sh

# Installs libcs50.
#
# For instructions, see https://cs50.readthedocs.io/library/c/.
#
# Per https://github.com/koalaman/shellcheck/wiki/SC2164, use `cd ... || exit`.
# Per https://github.com/koalaman/shellcheck/wiki/SC2086, double-quote variables.

# Exit on error
set -e

# Define version
CS50_VERSION="11.0.2"

# Remember sudo user if originally running as root
if [ "$(id -u)" -eq 0 ] && [ -n "$SUDO_USER" ]; then
    USER="$SUDO_USER"
else
    USER="$(logname 2>/dev/null || echo "${SUDO_USER:-$USER}")"
fi

main() {

    # Determine OS
    if [ "$(uname)" = "Darwin" ]; then
        OS="macOS"
    elif [ "$(uname)" = "Linux" ]; then
        if [ -f /etc/os-release ]; then
            # freedesktop.org and systemd
            # shellcheck disable=SC1091
            . /etc/os-release
            OS="$NAME"
        elif type lsb_release >/dev/null 2>&1; then
            # linuxbase.org
            OS=$(lsb_release -si)
        elif [ -f /etc/lsb-release ]; then
            # For some versions of Debian/Ubuntu without lsb_release command
            # shellcheck disable=SC1091
            . /etc/lsb-release
            OS=$DISTRIB_ID
        fi
    fi

    # Pre-flight checks
    if [ -z "$OS" ]; then
        echo "Could not determine OS."
        exit 1
    fi
    case "$OS" in
        "Amazon Linux" | "CentOS Linux" | "Fedora" | "Fedora Linux" | "Red Hat Enterprise Linux")
            if ! command -v "dnf" >/dev/null 2>&1; then
                echo "dnf not found. Please install dnf."
                exit 1
            fi
            if ! command -v "git" >/dev/null 2>&1; then
                echo "git not found. Please install git."
                exit 1
            fi
            ;;
        "Debian GNU/Linux" | "Ubuntu")
            if ! command -v "apt-get" >/dev/null 2>&1; then
                echo "apt-get not found. Please install apt-get."
                exit 1
            fi
            if ! command -v "git" >/dev/null 2>&1; then
                echo "git not found. Please install git."
                exit 1
            fi
            ;;
        "macOS")
            ;;
        *)
            echo "libcs50 is not officially supported on $OS."
            read -p "Install anyway? [y/N] "
            if [ "$REPLY" != "y" ] && [ "$REPLY" != "Y" ]; then
                exit 0
            fi
            ;;
    esac

    # Install libcs50
    cd /tmp || exit
    # Use proxy for git clone
    git clone https://ghproxy.com/https://github.com/cs50/libcs50.git
    cd libcs50 || exit
    git checkout "v$CS50_VERSION"
    case "$OS" in
        "Amazon Linux" | "CentOS Linux" | "Fedora" | "Fedora Linux" | "Red Hat Enterprise Linux")
            sudo dnf install -y clang make
            sudo make install
            ;;
        "Debian GNU/Linux" | "Ubuntu")
            sudo apt-get install -y clang make
            sudo make install
            ;;
        "macOS")
            sudo make install
            ;;
        *)
            # Hope for the best
            sudo make install
            ;;
    esac
    cd /tmp || exit
    rm -rf libcs50

    # Update dynamic linker run-time bindings
    case "$OS" in
        "Amazon Linux" | "CentOS Linux" | "Fedora" | "Fedora Linux" | "Red Hat Enterprise Linux" | "Debian GNU/Linux" | "Ubuntu")
            if command -v "ldconfig" > /dev/null 2>&1; then
                sudo ldconfig
            fi
            ;;
        *)
            ;;
    esac
}

main