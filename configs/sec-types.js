export const result = {
    SUCCESS: 0, // Success for all response if successful

    /** * 1 to 50 User related error codes ** */
    EMAIL_EXISTS: 1, // Email already exists
    MOBILE_EXISTS: 2, // Mobile already exists
    USER_NOT_EXISTS: 3, // User not exists
    USER_EXISTS: 4, // User exists
    USER_PASSWORD_INCORRECT: 5, // Password is wrong
    REGISTRATION_NOT_CONFIRMED: 6, // user Email is not conformed
    ACTIVATION_CODE_EXPIRED: 7,
    ACTIVATION_CODE_MISMATCH: 8,
    ALREADY_ACTIVE_MEMBER: 9,
    VALUE_NULL: 10,

    /** Document related service ** */
    DOCUMENT_N0T_EXISTS: 15,

    /** Firebase push notification service ** */
    FIREBASE_NOTIFICATION_ERROR: 20,

    /** * 351 t0 400 Google Api related error codes ** */
    ZERO_RESULTS: 351,
    OVER_QUERY_LIMIT: 352,
    REQUEST_DENIED: 353,
    INVALID_REQUEST: 354,
    UNKNOWN_ERROR: 355,

    /** * Response Types ** */
    OK: 200,
    BAD: 400,
    DENIED: 401,
    FORBIDDEN: 403,
    SERVER_ERROR: 500,
};

export const notificationType = {
    BROADCAST: 1,
    UNICAST: 2,
};

export const userRole = {
    PATIENT: "PATIENT",
    DOCTOR: "DOCTOR",
    HCF: "HCF",
    ADMIN: "ADMIN",
    SUPER_ADMIN: "SUPER_ADMIN",
};

export const userStatus = {
    ACTIVE: 0,
    IN_ACTIVE: 1,
    DELETED: 2,
    TRUNK: 3,
};

export const isPublished = {
    PUBLISHED: 0,
    UNPUBLISHED: 1,
};

export const isCompleted = {
    COMPLETED: 0,
    NOT_COMPLETED: 1,
};

export const mailType = {
    welcome: 0,
    resetPassword: 1,
    error: 999,
};

export const notificationStatus = {
    unRead: 1,
    read: 2,
};

export const isSent = {
    sent: 0,
    notSent: 1,
};

export const registration_type = {
    EMAIL: 1,
    SSO: 2,
};

export const registration_from = {
    WEB: 1,
    APP: 2,
};

export const expirationTime = {
    normal: {
        hours: 8,
        minutes: 2,
        seconds: 120,
        unit: "h",
    },
    remember: {
        hours: 12,
        minutes: 12 * 60 * 60,
        seconds: 60,
        unit: "h",
    },
};
