#!/bin/bash
# CouchDB setup
curl -s -X PUT http://localhost:5984/_config/admins/User_Name -d '"Pass_Word"'
curl -u User_Name -X PUT localhost:5984/btczpay

# Run the BTCz-Pay application
nodejs btcz-pay.js
nodejs worker1.js
nodejs worker2.js
nodejs worker3.js
nodejs worker4.js
nodejs worker5.js
