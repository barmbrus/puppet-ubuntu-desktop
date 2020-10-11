class base::user(String $user) {

  user { "$user":
    ensure => present,
    shell  => "/bin/zsh",
    require => Package["zsh"],
    groups => ["docker"],
  }

  file { "/home/$user/.zsh_init_prompt":
        mode => '0700',
        owner => "$user",
        group => "$user",
	source => 'puppet:///modules/base/.zsh_init_prompt',
	require => User["$user"],
  }

  file_line { "prompt":
    ensure  => present,
    line    => ". ~/.zsh_init_prompt",
    path    => "/home/$user/.zshrc",
    require => User["$user"],
  }

  file_line { "prompt":
    ensure  => present,
    line    => "setopt completealiases",
    path    => "/home/$user/.zshrc",
    require => User["$user"],
  }

  file_line { "prompt":
    ensure  => present,
    line    => "setopt globdots",
    path    => "/home/$user/.zshrc",
    require => User["$user"],
  }

  file { "/home/$user/.zsh_aliases":
        mode => '0700',
        owner => "$user",
        group => "$user",
	source => 'puppet:///modules/base/.zsh_aliases',
	require => User["$user"],
  }

  file_line { "aliases":
    ensure  => present,
    line    => ". ~/.zsh_aliases",
    path    => "/home/$user/.zshrc",
    require => User["$user"],
  }

  package { "zsh":
	ensure => 'installed',
  }
}
