# chmod 755 ./macos-install.sh

ansible-playbook -i "localhost," -c local local.yml --ask-become-pass
