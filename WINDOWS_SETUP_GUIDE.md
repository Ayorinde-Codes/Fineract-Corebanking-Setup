# Fineract Setup Guide for Windows

This guide will help you run the Fineract application on your Windows machine.

## Prerequisites

### 1. Java 17 or Higher
- Download and install Java 17+ from [Adoptium](https://adoptium.net/) or [OpenJDK](https://openjdk.org/)
- After installation, verify Java is installed correctly:
  ```cmd
  java -version
  ```
  You should see something like: `openjdk version "17.0.x"`

### 2. MySQL 8.0+
- Download and install MySQL from [MySQL Downloads](https://dev.mysql.com/downloads/mysql/)
- During installation, **IMPORTANT**: Set up the root user with **NO PASSWORD** (leave password field empty)
- Make sure MySQL service is running (it usually starts automatically)

## Database Setup

1. Open MySQL Command Line Client or MySQL Workbench
2. Connect as root user (no password required)
3. Create the required databases:
   ```sql
   CREATE DATABASE fineract_tenants;
   CREATE DATABASE fineract_default;
   ```

## Running the Application

### Step 1: Prepare the JAR File
1. Create a folder on your computer (e.g., `C:\fineract\`)
2. Copy the `fineract-provider.jar` file to this folder

### Step 2: Run the Application
1. Open Command Prompt (cmd) or PowerShell
2. Navigate to the folder where you placed the JAR file:
   ```cmd
   cd C:\fineract\
   ```
3. Run the application:
   ```cmd
   java -jar fineract-provider.jar
   ```

### Step 3: Wait for Startup
- The application will take 1-2 minutes to start
- You'll see logs in the console
- Wait until you see a message like: `Started ProviderApplication`

### Step 4: Access the Application
- Open your web browser
- Go to: `https://localhost:8443`
- **Note**: You'll get a security warning about the SSL certificate - click "Advanced" and "Proceed to localhost" (this is normal for development)

## Login Credentials
- **Username**: `mifos`
- **Password**: `password`

## Troubleshooting

### Port Already in Use Error
If you get an error that port 8443 is already in use, run with a different port:
```cmd
java -Dserver.port=8080 -jar fineract-provider.jar
```
Then access via: `http://localhost:8080` (note: HTTP instead of HTTPS)

### Database Connection Issues
- Verify MySQL is running:
  - Open Task Manager → Services tab → Look for "MySQL" service
- Make sure you can connect to MySQL without a password:
  ```cmd
  mysql -u root
  ```

### Java Not Found Error
- Make sure Java is properly installed and added to your PATH
- Try using the full path to Java:
  ```cmd
  "C:\Program Files\Eclipse Adoptium\jdk-17.x.x-hotspot\bin\java.exe" -jar fineract-provider.jar
  ```

### Firewall Issues
- Windows might block Java from accessing the network
- If prompted, allow Java through Windows Firewall
- Or manually add Java to firewall exceptions in Windows Security settings

### Memory Issues
If the application runs out of memory, increase heap size:
```cmd
java -Xmx2g -jar fineract-provider.jar
```

## Stopping the Application
- In the Command Prompt where the application is running, press `Ctrl+C`
- Wait for the application to shut down gracefully

## Additional Notes
- The application includes a built-in SSL certificate for development use
- All configuration is embedded in the JAR file
- The application will create necessary database tables automatically on first run
- Keep the Command Prompt window open while using the application

## Support
If you encounter any issues not covered in this guide, please contact the person who provided you with this JAR file. 