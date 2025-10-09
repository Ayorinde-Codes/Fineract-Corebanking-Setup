FINERACT COREBANKING SETUP - QUICK REFERENCE

This application has both the frontend and backend components.

For Business Intelligence / Data Analytics, Use Pentaho Community Edition

APACHE FINERACT SETUP (Backend)

1. Clone the repository
2. Set permissions: sudo chmod -R 777 fineract/
3. Create databases:
   mysql -u root
   CREATE DATABASE fineract_tenants;
   CREATE DATABASE fineract_default;

4. Configure application.properties:
   - Set password to empty: spring.datasource.hikari.password=
   - Use MySQL driver: com.mysql.cj.jdbc.Driver
   - Enable SSL: server.ssl.enabled=true
   - Port: server.port=8443

5. Generate SSL certificate:
   keytool -genkey -alias fineract -keyalg RSA -keystore fineract-provider/src/main/resources/keystore.jks -keysize 2048 -storepass openmf -keypass openmf

6. Build application:
   ./gradlew clean bootJar

7. Run application:
   java -jar fineract-provider/build/libs/fineract-provider.jar

Access: https://localhost:8443

MIFOS X SETUP (Frontend)

1. Navigate to fineract-frontend directory
2. Install dependencies: npm install
3. Use Node.js 18: nvm use 18
4. Install Angular CLI: npm install -g @angular/cli@15.2.11
5. Create env.js file in src/assets/ (copy from env.template.js)
6. Configure proxy.conf.js for API routing
7. Run development server:
   ng serve --proxy-config proxy.conf.js --open

Access: http://localhost:4200

DEFAULT LOGIN CREDENTIALS:
Username: mifos
Password: password

For detailed setup instructions, see readme.md
