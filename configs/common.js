"strict mode";

export const randomNumber = {
    length: 6,
    containers: "7028361495",
    minutes: 20,
};

export const OTP = {
    length: 8,
    containers: "D01U2JKQZMNO56RST789LAB4CFGE3HIPVWXY",
};

export const thumbnail = {
    width: 250,
    height: 250,
};

export const sendInBlue = {
    apiKey: process.env.SEND_IN_BLUE_API_KEY,
    timeOut: 5000,
};

export const SMSmessages = {
    activation_code_message: "Your Shareecare verification Code is {0}. #ShareECare",
};

export const aws = {
    s3: {
        params: {
            Bucket: "{0}.shareecare.documents",
            Domain: "{0}.documents.shareecare.com",
        },
    },
    settings: {
        root_path: "user_documents/{0}", // {0} UserId
        feedback_path: "user_feedbacks/{0}", // {0} UserId
        image_path: "/images",
        file_path: "/files",
    },
};

export const app = {
    jwtSecret: process.env.JWT_SECRET,
};

export const envMapping = {
    development: "dev",
    production: "prod",
    test: "test",
};

export const totalFilesSize = 20480;
