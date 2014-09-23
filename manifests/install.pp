

class screen::install 
       (
		$version = '4.2.1',
		$url	 = 'wget http://ftp.gnu.org/gnu/screen/screen-4.2.1.tar.gz -O /tmp/screen.gz',
	)
{

	#########################################
	#
	#  install screen and use files from puppet files
	#
	#########################################

	package {'ncurses-devel':
		ensure 		=> present,,,
		}

	exec {'screen-download':
		command		=> $url,
		cwd		=> '/tmp',
		unless 		=>'which pk',
		path		=> [ '/bin' , '/usr/bin' ],
		require 	=> Package['ncurses-devel'],
	     }

	exec { 'screen-unzip':
		command		=> 'tar -zxf /tmp/screen.gz',
		cwd		=> '/tmp',
		unless		=> 'which pk',
		path		=> [ '/bin' , '/usr/bin' ],
		require		=> Exec['screen-download'],
	      }

	exec { 'screen-configure':
		command		=> '/tmp/screen-4.2.1/configure && make install && install -m 644 etc/etcscreenrc /etc/screenrc ',
		cwd		=>'/tmp/screen-4.2.1',
		unless		=> 'which pk',
		path		=> [ '/bin' , '/usr/bin' ],
		require		=> Exec['screen-unzip'],
	      }
}
