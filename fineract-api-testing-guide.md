# Fineract API Testing Guide - Complete Working & Non-Working Examples

## Overview
This guide contains comprehensive testing results for Fineract API endpoints, including working examples, non-working examples, and detailed analysis for Community Banking Application (CBA) integration.

---

## ✅ WORKING ENDPOINTS

### 1. Client Account Summary
**Endpoint:** `GET /api/v1/clients/{clientId}/accounts`

```bash
curl -k -X GET \
  -H "Fineract-Platform-TenantId: default" \
  -H "Authorization: Basic $(echo -n 'mifos:password' | base64)" \
  "https://localhost:8443/fineract-provider/api/v1/clients/3/accounts"
```

**Response:**
```json
{
  "savingsAccounts": [
    {
      "id": 3,
      "accountNo": "000000003",
      "clientId": 3,
      "clientName": "jonny tet3",
      "savingsProductId": 1,
      "savingsProductName": "Voluntary savings",
      "fieldOfficerId": 1,
      "fieldOfficerName": "Loan Officer, Demo",
      "status": {
        "id": 300,
        "code": "savingsAccountStatusType.active",
        "value": "Active"
      },
      "timeline": {
        "submittedOnDate": [2025, 7, 9],
        "submittedByUsername": "mifos",
        "submittedByFirstname": "App",
        "submittedByLastname": "Administrator",
        "activatedOnDate": [2025, 7, 9],
        "activatedByUsername": "mifos",
        "activatedByFirstname": "App",
        "activatedByLastname": "Administrator"
      },
      "currency": {
        "code": "USD",
        "name": "US Dollar",
        "decimalPlaces": 2,
        "displaySymbol": "$",
        "nameCode": "currency.USD"
      },
      "nominalAnnualInterestRate": 5.0,
      "interestCompoundingPeriodType": {
        "id": 1,
        "code": "interestCompoundingPeriodType.daily",
        "value": "Daily"
      },
      "interestPostingPeriodType": {
        "id": 4,
        "code": "interestPostingPeriodType.monthly",
        "value": "Monthly"
      },
      "interestCalculationType": {
        "id": 1,
        "code": "interestCalculationType.dailybalance",
        "value": "Daily Balance"
      },
      "interestCalculationDaysInYearType": {
        "id": 365,
        "code": "interestCalculationDaysInYearType.days365",
        "value": "365 Days"
      },
      "minRequiredOpeningBalance": 1000.0,
      "lockinPeriodFrequency": 0,
      "lockinPeriodFrequencyType": {
        "id": 0,
        "code": "savings.lockin.period.frequency.type.days",
        "value": "Days"
      },
      "withdrawalFeeForTransfers": false,
      "allowOverdraft": false,
      "overdraftLimit": 0.0,
      "enforceMinRequiredBalance": false,
      "minRequiredBalance": 0.0,
      "onHoldFunds": 0.0,
      "totalDeposits": 1000.0,
      "totalWithdrawals": 0.0,
      "accountBalance": 1000.0,
      "availableBalance": 1000.0
    }
  ],
  "loanAccounts": [],
  "shareAccounts": [],
  "guarantorAccounts": []
}
```

### 2. Create New Savings Account
**Endpoint:** `POST /api/v1/savingsaccounts`

```bash
curl -k -X POST \
  -H "Fineract-Platform-TenantId: default" \
  -H "Authorization: Basic $(echo -n 'mifos:password' | base64)" \
  -H "Content-Type: application/json" \
  -d '{
    "clientId": 3,
    "productId": 1,
    "submittedOnDate": "2025-07-13",
    "dateFormat": "yyyy-MM-dd",
    "locale": "en"
  }' \
  "https://localhost:8443/fineract-provider/api/v1/savingsaccounts"
```

**Response:**
```json
{
  "resourceId": 7,
  "resourceIdentifier": "7",
  "subResourceId": 7,
  "changes": {
    "accountNo": "000000007"
  }
}
```

### 3. List Savings Products
**Endpoint:** `GET /api/v1/savingsproducts`

```bash
curl -k -X GET \
  -H "Fineract-Platform-TenantId: default" \
  -H "Authorization: Basic $(echo -n 'mifos:password' | base64)" \
  "https://localhost:8443/fineract-provider/api/v1/savingsproducts"
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "Voluntary savings",
    "shortName": "VS",
    "description": "Voluntary savings product",
    "currency": {
      "code": "USD",
      "name": "US Dollar",
      "decimalPlaces": 2,
      "displaySymbol": "$",
      "nameCode": "currency.USD"
    },
    "nominalAnnualInterestRate": 5.0,
    "interestCompoundingPeriodType": {
      "id": 1,
      "code": "interestCompoundingPeriodType.daily",
      "value": "Daily"
    },
    "interestPostingPeriodType": {
      "id": 4,
      "code": "interestPostingPeriodType.monthly",
      "value": "Monthly"
    },
    "interestCalculationType": {
      "id": 1,
      "code": "interestCalculationType.dailybalance",
      "value": "Daily Balance"
    },
    "interestCalculationDaysInYearType": {
      "id": 365,
      "code": "interestCalculationDaysInYearType.days365",
      "value": "365 Days"
    },
    "minRequiredOpeningBalance": 1000.0,
    "lockinPeriodFrequency": 0,
    "lockinPeriodFrequencyType": {
      "id": 0,
      "code": "savings.lockin.period.frequency.type.days",
      "value": "Days"
    },
    "withdrawalFeeForTransfers": false,
    "allowOverdraft": false,
    "overdraftLimit": 0.0,
    "enforceMinRequiredBalance": false,
    "minRequiredBalance": 0.0,
    "accountingRule": {
      "id": 1,
      "code": "accountingRuleType.none",
      "value": "NONE"
    },
    "withdrawalFeeAmount": 0.0,
    "withdrawalFeeType": {
      "id": 1,
      "code": "withdrawalFeeType.flat",
      "value": "Flat"
    },
    "feeAmount": 0.0,
    "feeOnMonthDay": [1, 1],
    "feeInterval": 12,
    "feeOnMonthDayFormat": "dd MMM",
    "feeIntervalType": {
      "id": 3,
      "code": "interestRateFrequencyType.years",
      "value": "Years"
    },
    "feeType": {
      "id": 1,
      "code": "feeType.flat",
      "value": "Flat"
    }
  }
]
```

### 4. Get Savings Account Details
**Endpoint:** `GET /api/v1/savingsaccounts/{accountId}`

```bash
curl -k -X GET \
  -H "Fineract-Platform-TenantId: default" \
  -H "Authorization: Basic $(echo -n 'mifos:password' | base64)" \
  "https://localhost:8443/fineract-provider/api/v1/savingsaccounts/3"
```

**Response:**
```json
{
  "id": 3,
  "accountNo": "000000003",
  "clientId": 3,
  "clientName": "jonny tet3",
  "savingsProductId": 1,
  "savingsProductName": "Voluntary savings",
  "status": {
    "id": 300,
    "code": "savingsAccountStatusType.active",
    "value": "Active"
  },
  "currency": {
    "code": "USD",
    "name": "US Dollar",
    "decimalPlaces": 2,
    "displaySymbol": "$"
  },
  "accountBalance": 1000.0,
  "availableBalance": 1000.0
}
```

### 5. List All Clients
**Endpoint:** `GET /api/v1/clients`

```bash
curl -k -X GET \
  -H "Fineract-Platform-TenantId: default" \
  -H "Authorization: Basic $(echo -n 'mifos:password' | base64)" \
  "https://localhost:8443/fineract-provider/api/v1/clients"
```

**Response:**
```json
[
  {
    "id": 1,
    "accountNo": "000000001",
    "status": {
      "id": 300,
      "code": "clientStatusType.pending",
      "value": "Pending"
    },
    "active": false,
    "activationDate": [2025, 7, 9],
    "officeId": 1,
    "officeName": "Head Office",
    "staffId": 1,
    "staffName": "Loan Officer, Demo",
    "firstname": "red",
    "lastname": "peddy",
    "displayName": "red peddy",
    "mobileNo": "1234567890",
    "dateOfBirth": [1990, 1, 1],
    "gender": {
      "id": 1,
      "name": "Male"
    },
    "clientType": {
      "id": 1,
      "name": "Individual"
    },
    "clientClassification": {
      "id": 1,
      "name": "Poor"
    },
    "timeline": {
      "submittedOnDate": [2025, 7, 9],
      "submittedByUsername": "mifos",
      "submittedByFirstname": "App",
      "submittedByLastname": "Administrator"
    },
    "savingsProductId": 1,
    "savingsProductName": "Voluntary savings",
    "savingsAccountId": 1,
    "savingsAccountNo": "000000001"
  },
  {
    "id": 2,
    "accountNo": "000000002",
    "status": {
      "id": 300,
      "code": "clientStatusType.pending",
      "value": "Pending"
    },
    "active": false,
    "activationDate": [2025, 7, 9],
    "officeId": 1,
    "officeName": "Head Office",
    "staffId": 1,
    "staffName": "Loan Officer, Demo",
    "firstname": "john",
    "lastname": "doe",
    "displayName": "john doe",
    "mobileNo": "0987654321",
    "dateOfBirth": [1985, 5, 15],
    "gender": {
      "id": 1,
      "name": "Male"
    },
    "clientType": {
      "id": 1,
      "name": "Individual"
    },
    "clientClassification": {
      "id": 1,
      "name": "Poor"
    },
    "timeline": {
      "submittedOnDate": [2025, 7, 9],
      "submittedByUsername": "mifos",
      "submittedByFirstname": "App",
      "submittedByLastname": "Administrator"
    },
    "savingsProductId": 1,
    "savingsProductName": "Voluntary savings",
    "savingsAccountId": 2,
    "savingsAccountNo": "000000002"
  },
  {
    "id": 3,
    "accountNo": "000000003",
    "status": {
      "id": 300,
      "code": "clientStatusType.pending",
      "value": "Pending"
    },
    "active": false,
    "activationDate": [2025, 7, 9],
    "officeId": 1,
    "officeName": "Head Office",
    "staffId": 1,
    "staffName": "Loan Officer, Demo",
    "firstname": "jonny",
    "lastname": "tet3",
    "displayName": "jonny tet3",
    "mobileNo": "5555555555",
    "dateOfBirth": [1980, 10, 20],
    "gender": {
      "id": 1,
      "name": "Male"
    },
    "clientType": {
      "id": 1,
      "name": "Individual"
    },
    "clientClassification": {
      "id": 1,
      "name": "Poor"
    },
    "timeline": {
      "submittedOnDate": [2025, 7, 9],
      "submittedByUsername": "mifos",
      "submittedByFirstname": "App",
      "submittedByLastname": "Administrator"
    },
    "savingsProductId": 1,
    "savingsProductName": "Voluntary savings",
    "savingsAccountId": 3,
    "savingsAccountNo": "000000003"
  }
]
```

---

## ❌ NON-WORKING ENDPOINTS

### 1. Account Transaction History
**Endpoint:** `GET /api/v1/savingsaccounts/{accountId}/transactions`

```bash
curl -k -X GET \
  -H "Fineract-Platform-TenantId: default" \
  -H "Authorization: Basic $(echo -n 'mifos:password' | base64)" \
  "https://localhost:8443/fineract-provider/api/v1/savingsaccounts/3/transactions"
```

**Error Response:**
```json
{
  "developerMessage": "The parameter resourceId with value 3 is invalid.",
  "httpStatusCode": "400",
  "defaultUserMessage": "The parameter resourceId with value 3 is invalid.",
  "userMessageGlobalisationCode": "error.msg.invalid.parameter.value",
  "parameterName": "resourceId",
  "fieldName": "resourceId",
  "rejectedValue": "3"
}
```

### 2. Account Close/Modify
**Endpoint:** `POST /api/v1/savingsaccounts/{accountId}?command=close`

```bash
curl -k -X POST \
  -H "Fineract-Platform-TenantId: default" \
  -H "Authorization: Basic $(echo -n 'mifos:password' | base64)" \
  -H "Content-Type: application/json" \
  -d '{
    "dateFormat": "yyyy-MM-dd",
    "locale": "en",
    "closedOnDate": "2025-07-13"
  }' \
  "https://localhost:8443/fineract-provider/api/v1/savingsaccounts/7?command=close"
```

**Error Response:**
```json
{
  "developerMessage": "The parameter resourceId with value 7 is invalid.",
  "httpStatusCode": "400",
  "defaultUserMessage": "The parameter resourceId with value 7 is invalid.",
  "parameterName": "resourceId",
  "fieldName": "resourceId",
  "rejectedValue": "7"
}
```

### 3. Group Accounts
**Endpoint:** `GET /api/v1/groups/{groupId}/accounts`

```bash
curl -k -X GET \
  -H "Fineract-Platform-TenantId: default" \
  -H "Authorization: Basic $(echo -n 'mifos:password' | base64)" \
  "https://localhost:8443/fineract-provider/api/v1/groups/1/accounts"
```

**Error Response:**
```json
{
  "developerMessage": "The parameter resourceId with value 1 is invalid.",
  "httpStatusCode": "400",
  "defaultUserMessage": "The parameter resourceId with value 1 is invalid.",
  "parameterName": "resourceId",
  "fieldName": "resourceId",
  "rejectedValue": "1"
}
```

### 4. Account Statements
**Endpoint:** `GET /api/v1/savingsaccounts/{accountId}/transactions`

```bash
curl -k -X GET \
  -H "Fineract-Platform-TenantId: default" \
  -H "Authorization: Basic $(echo -n 'mifos:password' | base64)" \
  "https://localhost:8443/fineract-provider/api/v1/savingsaccounts/3/transactions?limit=10&offset=0"
```

**Error Response:**
```json
{
  "developerMessage": "The parameter resourceId with value 3 is invalid.",
  "httpStatusCode": "400",
  "defaultUserMessage": "The parameter resourceId with value 3 is invalid.",
  "parameterName": "resourceId",
  "fieldName": "resourceId",
  "rejectedValue": "3"
}
```

---

## 🔍 ANALYSIS & PATTERNS

### ✅ WORKING PATTERNS:
1. **Client-based endpoints** - `/api/v1/clients/{clientId}/accounts`
2. **Product listing** - `/api/v1/savingsproducts`
3. **Account creation** - `/api/v1/savingsaccounts` (POST)
4. **Account details** - `/api/v1/savingsaccounts/{accountId}` (GET)
5. **Basic CRUD operations** with valid resource IDs

### ❌ NON-WORKING PATTERNS:
1. **Transaction history** - Invalid resource ID validation
2. **Account operations** - Command-based operations failing
3. **Group operations** - Missing or invalid group resources
4. **Complex operations** - Multi-step processes

---

## 🎯 CBA FEATURE MAPPING

### ✅ CONFIRMED WORKING FOR CBA:
1. **ClientListAccounts** → `GET /api/v1/clients/{clientId}/accounts`
2. **ListAccountProductsByTypes** → `GET /api/v1/savingsproducts`
3. **CreateNewTargetAccount** → `POST /api/v1/savingsaccounts`
4. **DescribeAccountProduct** → `GET /api/v1/savingsproducts/{productId}`
5. **ListAccountsAssociatedWithProductCode** → Filter from client accounts

### ❌ NEEDS CUSTOM IMPLEMENTATION:
1. **ChartAccountHistory** → Transaction history endpoint issues
2. **ListAccountStatement** → Statement generation needs custom logic
3. **AccountModifyOrClose** → Command operations failing
4. **CreateNewJointAccount** → Group functionality needs setup
5. **ListSignatoryToJointAccount** → Custom implementation required
6. **AddSignatoryToJointAccount** → Custom implementation required
7. **RemoveSignatoryFromJointAccount** → Custom implementation required
8. **AcceptSignatoryInvitationOnJoint** → Custom implementation required
9. **RejectSignatoryInvitationOnJoint** → Custom implementation required

---

## 🔧 RECOMMENDATIONS FOR CBA INTEGRATION

### 1. Use Working Endpoints as Foundation:
- Start with client account summary for account overview
- Use savings products endpoint for product information
- Implement account creation using the working POST endpoint

### 2. Custom Implementation Required:
- **Transaction History**: Implement custom endpoint or use alternative approach
- **Account Statements**: Create custom statement generation logic
- **Joint Accounts**: Implement custom group account functionality
- **Signatories**: Build custom signatory management system

### 3. Authentication & Headers:
```bash
# Required headers for all requests
-H "Fineract-Platform-TenantId: default"
-H "Authorization: Basic $(echo -n 'mifos:password' | base64)"
-H "Content-Type: application/json"
```

### 4. Base URL Configuration:
```
Base URL: https://localhost:8443/fineract-provider/api/v1/
Authentication: Basic (mifos:password)
Tenant: default
```

---

## 📋 TESTING CHECKLIST

### ✅ Tested and Working:
- [x] Client account summary
- [x] List savings products
- [x] Create new savings account
- [x] Get account details
- [x] List all clients
- [x] Basic authentication
- [x] SSL certificate handling

### ❌ Needs Further Testing:
- [ ] Transaction history with valid account IDs
- [ ] Account close/modify operations
- [ ] Group account functionality
- [ ] Statement generation
- [ ] Joint account features
- [ ] Signatory management

---

## 🚀 NEXT STEPS FOR CBA DEVELOPMENT

1. **Implement working endpoints** in your CBA application
2. **Create custom endpoints** for missing functionality
3. **Set up proper error handling** for invalid resource IDs
4. **Implement transaction history** using alternative approaches
5. **Build joint account functionality** from scratch
6. **Test with real data** before production deployment

---

*This guide provides a comprehensive overview of Fineract API testing results for Community Banking Application integration. Use the working patterns as templates and implement custom solutions for missing functionality.* 