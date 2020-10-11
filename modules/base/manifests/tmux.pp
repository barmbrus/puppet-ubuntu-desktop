class base::tmux(String $user) {
      package { tmux:
        ensure => present,
      }

      file { "/home/$user/.tmux.config":
        owner   => $user,
        group   => $user,
        mode    => "0600",
        source  => "puppet:///modules/base/tmux.conf",
        require => Package["tmux"],
        replace => "no",
      }
}
