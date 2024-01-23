FROM	   --platform=linux/amd64 archlinux:multilib-devel
# Update and install OS dependencies
RUN	 	 pacman-key --init
RUN	 	 pacman -Syu --noconfirm
RUN	 	 pacman -S base-devel --noconfirm
RUN      pacman -S nano git curl sed zip unzip couchdb --noconfirm

# Add an user as sudoer to e able to use makepkg and npm install as non root user
RUN	 	 useradd -m adminbtcz
RUN	 	 passwd -d adminbtcz
RUN 	 chmod 0440 /etc/sudoers
RUN 	 echo "adminbtcz ALL=(ALL)  ALL" >> /etc/sudoers


# Switch as adminbtcz (sudoer) user to continue
USER 	 adminbtcz

# Clone and build YAY packager
WORKDIR  /home/adminbtcz/
RUN	 	 git clone https://aur.archlinux.org/yay.git
WORKDIR	 /home/adminbtcz/yay/
RUN	 	 makepkg -si --noconfirm
RUN 	 rm -R /home/adminbtcz/yay/

# Install the BTCZ binaries
RUN	 	 mkdir /home/adminbtcz/bitcoinz
WORKDIR  /home/adminbtcz/bitcoinz

# Install nodejs 
#ENV      NVM_DIR /BTCz-Pay     
#ENV      NODE_VERSION 8.17.0 
#RUN      sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
#         && . $NVM_DIR/nvm.sh \
#         && nvm install $NODE_VERSION \
#         && nvm alias default $NODE_VERSION \
#         && nvm use default
#ENV      NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
#ENV      PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
#RUN 	 npm config set registry https://registry.npmjs.org/
#
RUN		 npm install -g yarn
RUN      npm -g install pm2
RUN 	 ln -sfn /home/adminbtcz/.nvm/versions/node/v8.17.0/bin/pm2  /usr/bin/pm2
RUN	 	 ln -sfn /home/adminbtcz/.nvm/versions/node/v8.17.0/bin/node  /usr/bin/node
RUN	 	 ln -sfn /home/adminbtcz/.nvm/versions/node/v8.17.0/bin/npm  /usr/bin/npm

RUN       git clone https://github.com/simbav911/BTCz-Pay 
WORKDIR   BTCz-Pay
RUN     cp config.js.dev config.js






RUN curl -X PUT http://localhost:5984/_config/admins/User_Name -d '"Pass_Word"'
RUN curl -u User_Name -X PUT localhost:5984/btczpay 


ENTRYPOINT ["/bin/bash"]
CMD ["nodejs btcz-pay.js","nodejs worker1.js","nodejs worker2.js","nodejs worker3.js","nodejs worker4.js","nodejs worker5.js"]
