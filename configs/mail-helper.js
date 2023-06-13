"strict mode";

import sendinblue from "sib-api-v3-sdk";
import { sendInBlue, randomNumber } from "./common";

const defaultClient = sendinblue.ApiClient.instance;
const apiKey = defaultClient.authentications["api-key"];
apiKey.apiKey = sendInBlue.apiKey;

/**

Sends an email via Sendinblue SMTP API.
@param {object} sendSmtpEmail - Email details to be sent.
@returns {Promise<void>} - Promise that resolves with no value.
@throws {Error} - If an error occurs while sending the email.
*/

const sendViaSendInBlue = async (sendSmtpEmail) => {
    const apiInstance = new sendinblue.TransactionalEmailsApi();

    try {
        const data = await apiInstance.sendTransacEmail(sendSmtpEmail);
        console.log(`API called successfully. Returned data: ${JSON.stringify(data)}`);
    } catch (err) {
        console.error("Error occured in sending email due to", err);
    }
};

/**

Sends an activation code email to the provided email address with the given activation code.
@async
@param {string} email - The email address to send the activation code email to.
@param {string} code - The activation code to include in the email.
@param {string} [externalText=""] - Additional text to include in the email body.
@throws {Error} Throws an error if there was an issue sending the email.
@returns {Promise<void>} - A Promise that resolves when the email has been sent successfully.
*/

export const sendActivationCode = async (email, code, externalText = "") => {
    const sendSmtpEmail = new sendinblue.SendSmtpEmail();

    sendSmtpEmail.subject = "{{params.subject}}";
    sendSmtpEmail.htmlContent =
        "<html> \
                        <head> \
                            <title>{{params.title}} </title> \
                        </head> \
                        <body> \
                            <div>{{params.bodyText}} {{params.code}} and will expire in {{params.minutes}}minutes</div> \
                        </body> \
                        </html>";
    sendSmtpEmail.sender = {
        name: "Shareecare",
        email: "no-reply@shareecare.com",
    };
    sendSmtpEmail.to = [{ email }];
    sendSmtpEmail.headers = {
        "Content-Type": "text/html",
        charset: "iso-8859-1",
    };
    sendSmtpEmail.params = {
        subject: "Shareecare activation code",
        title: "Welcome to Shareecare",
        code,
        bodyText:
            externalText !== ""
                ? externalText
                : "Please use this code to activate your account. Your activation code is",
        minutes: randomNumber.minutes,
    };

    try {
        await sendViaSendInBlue(sendSmtpEmail);
        console.log("Code has been sent to ", email);
    } catch (err) {
        console.log("Error occured in sending activation code due to", err);
        throw err;
    }
};
