class base {
    $user = '<ENTER_YOUR_USERNAME_HERE>'

    class {'base::user': user => $user}
    class {'base::pbcopy': user => $user}

    include base::vim
    include ::snapd
    include base::hibernate_mode

    class {'base::tmux': user => $user}

    $enhancers = [
    'aptitude',
    'chromium-browser',
    'google-chrome-stable',
    'csvkit',
    'cups',
    'curl',
    'default-jdk',
    'default-jre',
    'diffutils',
    'docker',
    'docker.io',
    'docker-compose',
    'dos2unix',
    'firefox',
    'gdal-bin',
    'gdal-data',
    'gdb',
    'gdbserver',
    'gimp',
    'git',
    # Terminal Mouse Support
    'gpm',
    'gscan2pdf',
    'imagemagick',
    'puppet',
    'jq',
    'krusader',
    # Java Dev only
    'maven',
    #  For ifconfig (docker .zsh extensions, should b replaced by ip command)
    'net-tools',
    'nginx',
    'ntfs-3g',
    # VPN Cisco
    'network-manager-openconnect',
    'network-manager-openconnect-gnome',
    'openjdk-8-jdk',
    'openjdk-11-jdk',
    'python3',
    'python3-pip',
    'postgresql-client',
    'skypeforlinux',
    'sqlite3',
    'teams',
    'teamviewer',
    'tesseract-ocr',
    'tesseract-ocr-eng',
    'tesseract-ocr-osd',
    # 'vim', --> in own declaration in base::vim
    'vlc',
    'wget',
    ]

      package {
        $enhancers: ensure => 'installed',
        require => [
          Apt::Source['skype'],
          Apt::Source['teams'],
          Apt::Source['teamviewer'],
          Apt::Source['chrome'],
        ],
      }



  package { [
    'intellij-idea-ultimate',
    'spotify',
      # Visual Studio Code
    'code',
      # in ubuntu repo
    'dbeaver-ce',
      # Needs to be started as Desktop App and then defined what is to be
      # installed
    'android-studio',
    'postman',
    'node',
    'eclipse'
  ]:
  ensure   => latest,
  provider => snap,
  }

  apt::source { 'skype':
    comment  => 'Microsoft Skype Debian Repo',
             location => 'https://repo.skype.com/deb',
             release  => 'stable',
             repos    => 'main',
             key      => {
               'id'     => 'D4040146BE3972509FD57FC71F3045A5DF7587C3',
#      'server' => 'subkeys.pgp.net',
             },
             include  => {
               'src' => false,
               'deb' => true,
             },
  }


  apt::source { 'teams':
    comment  => 'Microsoft Teams Debian Repo',
             location => 'https://packages.microsoft.com/repos/ms-teams',
             release  => 'stable',
             repos    => 'main',
             key      => {
               'id'     => 'D4040146BE3972509FD57FC71F3045A5DF7587C3',
#      'server' => 'subkeys.pgp.net',
             },
             include  => {
               'src' => false,
               'deb' => true,
             },
  }

  apt::source { 'teamviewer':
    comment  => 'Teamviewer Repo',
             location => 'http://linux.teamviewer.com/deb',
             release  => 'stable',
             repos    => 'main',
             key      => {
               'id'     => '8CAE012EBFAC38B17A937CD8C5E224500C1289C0',
#      'server' => 'subkeys.pgp.net',
             },
             include  => {
               'src' => false,
               'deb' => true,
             },
  }

  apt::source { 'chrome':
    comment  => 'Chrome Repo',
             location => 'http://dl.google.com/linux/chrome/deb',
             release  => 'stable',
             repos    => 'main',
             include  => {
               'src' => false,
               'deb' => true,
             },
             require => [Exec['chrome-add-repository-key']],
  }

  exec { 'chrome-add-repository-key' :
    command => "/usr/bin/wget -q -O - 'https://dl-ssl.google.com/linux/linux_signing_key.pub' | /usr/bin/apt-key add -"
  }
}
