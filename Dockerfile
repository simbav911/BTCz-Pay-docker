# Stage 1: Build BTCz-Pay application
FROM --platform=linux/amd64 node:14 AS builder



# Clone and install BTCz-Pay project
RUN git clone https://github.com/simbav911/BTCz-Pay
WORKDIR /BTCz-Pay

# Install development dependencies and build the application
RUN npm install && npm run build

# Stage 2: Create the final runtime image
FROM --platform=linux/amd64 couchdb:latest


# Copy CouchDB configuration script
COPY ./couchdb-setup.sh /opt/couchdb-setup.sh

# Make the script executable
RUN chmod +x /opt/couchdb-setup.sh

# Copy the built application from the builder stage
#COPY --from=builder /BTCz-Pay /opt/BTCz-Pay

# Configure CouchDB and edit config.js
# Uncomment and modify the following lines as needed
# RUN sed -i 's/your_couchdb_database/btczpay/' /opt/BTCz-Pay/config.js 
# RUN sed -i 's/your_bitcoinz_rpc_server/rpc_server_address/' /opt/BTCz-Pay/config.js 
# RUN sed -i 's/your_email_params/email_params/' /opt/BTCz-Pay/config.js

# Expose ports
EXPOSE 3000
EXPOSE 2222

# Run the CouchDB setup script and then the BTCz-Pay application
CMD ["/opt/couchdb-setup.sh"]
