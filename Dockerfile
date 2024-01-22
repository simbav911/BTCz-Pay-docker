FROM	   --platform=linux/amd64 ubuntu:latest
#Clone & install project:
RUN       get-apt update
RUN       git clone https://github.com/simbav911/BTCz-Pay && cd BTCz-Pay
RUN       npm install
RUN       cp config.js.dev config.js

#Install & configure Couchdb:

RUN apt-get install couchdb
RUN curl -s -X PUT http://localhost:5984/_config/admins/User_Name -d '"Pass_Word"'
RUN curl -u User_Name -X PUT localhost:5984/btczpay


ENTRYPOINT ["/bin/bash"]
CMD ["nodejs btcz-pay.js","nodejs worker1.js","nodejs worker2.js","nodejs worker3.js","nodejs worker4.js","nodejs worker5.js"]
