#!/bin/bash

# LOG_COLOR: set is log color rendered

log() {
    if [ ${LOG_COLOR:-1} -eq 1 ];then
        msg="\033[${3}[$2]\033[0m ${1}"
    else
        msg="[Info] ${1}"
    fi

    if [ x"$2" == xError -o x"$2" == xFatal ];then
        echo -e $msg 1>&2
    else
        echo -e $msg
    fi

    if [ x"$2" == xFatal ];then
        exit 1
    fi
}

log_info() {
    log "$1" Info 32m
}

log_error() {
    log "$1" Error 31m
}

log_fatal() {
    log "$1" Fatal "1;31m"
}

cmd() {
    log_info "exec cmd: $1"
    eval $1
    return $?
}

rvm_install() {
    log_info 'Start install rvm'
    cmd 'curl -sSL https://get.rvm.io | bash -s stable' || {
        log_fatal 'install rvm failed!'
    }

    log_info 'Active rvm'
    cmd 'source ~/.rvm/scripts/rvm'
    cmd 'source ~/.bash_profile'

    if [ x"$rvm_path" == x ];then
        log_fatal 'rvm installed, but not found rvm_path!'
    fi

    log_info 'replace rvm source to ruby.taobao.org'
    if [ x`uname -s` == xLinux ];then
        sed -i 's!cache.ruby-lang.org/pub/ruby!ruby.taobao.org/mirrors/ruby!' $rvm_path/config/db
    else
        sed -i .bak 's!cache.ruby-lang.org/pub/ruby!ruby.taobao.org/mirrors/ruby!' $rvm_path/config/db
    fi
}

ruby_install() {
    RUBY_VER=$1

    if [[ "`ruby -v 2>/dev/null`" == "ruby ${RUBY_VER}"* ]];then
        log_info 'ruby ${RUBY_VER} installed.'
        return 0
    fi

    log_info "Start install ruby ${RUBY_VER}"
    cmd 'rvm install ${RUBY_VER}'

    if [ $? -eq 0 ];then
        log_info 'ruby installed'
    else
        log_fatal 'ruby install failed!'
    fi

    rvm use $RUBY_VER
    rvm default $RUBY_VER
}

type rvm &>/dev/null || rvm_install

ruby_install 2.1.1

gem install bundle rake

bundle install
