FROM	   --platform=linux/amd64 archlinux:multilib-devel
# Update and install OS dependencies
RUN	 	 pacman-key --init
RUN	 	 pacman -Syu --noconfirm
RUN	 	 pacman -S base-devel --noconfirm
RUN      pacman -S nano git curl sed zip unzip nodejs npm couchdb --noconfirm

RUN       git clone https://github.com/simbav911/BTCz-Pay 
WORKDIR   BTCz-Pay
RUN     cp config.js.dev config.js

# Install nodejs 8
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
#RUN		 npm install -g yarn
#RUN      npm -g install pm2





#RUN curl -X PUT http://localhost:5984/_config/admins/User_Name -d '"Pass_Word"'
#RUN curl -u User_Name -X PUT localhost:5984/btczpay 


ENTRYPOINT ["/bin/bash"]
#CMD ["nodejs btcz-pay.js","nodejs worker1.js","nodejs worker2.js","nodejs worker3.js","nodejs worker4.js","nodejs worker5.js"]
