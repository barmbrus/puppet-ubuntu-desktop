class base::vim {
      package { [vim,
                 vim-puppet,
                 vim-syntax-docker,
                 vim-autopep8,
                 vim-ctrlp,
                 vim-lastplace,
                 vim-scripts,
                 vim-snipmate,
                 vim-snippets,
                 vim-syntastic,
                 vim-tabular,
                 vim-voom,
                 vim-youcompleteme
                ]:
        ensure => present,
      }

      file { "/etc/vim/vimrc":
        owner   => root,
        group   => root,
        mode    => "0644",
        source  => "puppet:///modules/base/vimrc",
        require => Package["vim"],
      }

      exec { "/usr/bin/update-alternatives --set editor /usr/bin/vim.basic":
        unless => "/usr/bin/test /etc/alternatives/editor -ef /usr/bin/vim.basic"
      }
}
