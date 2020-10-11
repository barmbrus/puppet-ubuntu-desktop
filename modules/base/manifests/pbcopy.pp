class base::pbcopy(String $user) {

  package { "xclip":
    ensure => present
  }

  file_line { "pbcopy_zsh":
    ensure  => present,
    match   => "^\s*alias pbcopy=.*$",
    line    => "alias pbcopy='xclip -selection clipboard'",
    path    => "/home/$user/.zshrc",
  }

  file_line { "pbpaste_zsh":
    ensure  => present,
    match   => "^\s*alias pbpaste=.*$",
    line    => "alias pbpaste='xclip -selection clipboard -o'",
    path    => "/home/$user/.zshrc",
  }

}
