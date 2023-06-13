#!/usr/bin/env node
/* eslint-disable no-useless-escape */

"strict mode";

import jwt from "jsonwebtoken";
import https from "https";
import fs from "fs";

import crypto from "crypto";
import { expirationTime } from "./sec-types";
import { randomNumber, OTP, app } from "./common";

const cryptoAlgorithm = "aes-256-ctr"; // Do not alter
const cryptoPassword = Buffer.from(process.env.CRYPTO_PASSWORD, "base64"); // Do not alter
const IV_LENGTH = 16;

const randomStringLength = randomNumber.length;
const chars = randomNumber.containers;

const OTPlength = OTP.length;
const OTPchars = OTP.containers;

/**
 * Generates a random number of specified length using the specified characters
 * @returns {string} - The generated random number
 */
export const getRandomNumber = () => {
    let result = "";
    for (let i = randomStringLength; i > 0; --i)
        result += chars[Math.round(Math.random() * (chars.length - 1))];
    return result;
};

/**
 * Generates a one-time password (OTP) of specified length using the specified characters
 * @returns {string} - The generated OTP
 */
export const getOTP = () => {
    let result = "";
    for (let i = OTPlength; i > 0; --i)
        result += OTPchars[Math.round(Math.random() * (OTPchars.length - 1))];
    return result;
};

/**
 * Encrypts a password using AES-256-CTR encryption
 * @param {string} password - The password to be encrypted
 * @returns {string} - The encrypted password, prefixed by the initialization vector used in encryption
 */
export const hashString = (password) => {
    // const cipher = crypto.createCipher(cryptoAlgorithm, cryptoPassword);
    // let crypted = cipher.update(password, "utf8", "hex");
    // crypted += cipher.final("hex");
    // return crypted.toString();
    const iv = crypto.randomBytes(IV_LENGTH);
    const cipher = crypto.createCipheriv(cryptoAlgorithm, Buffer.from(cryptoPassword, "hex"), iv);
    let encrypted = cipher.update(password);
    encrypted = Buffer.concat([encrypted, cipher.final()]);
    return `${iv.toString("hex")}:${encrypted.toString("hex")}`;
};

/**
 * Decrypts an encrypted password using AES-256-CTR encryption
 * @param {string} password - The encrypted password, prefixed by the initialization vector used in encryption
 * @returns {string} - The decrypted password
 */
export const descryptHashString = (password) => {
    const textParts = password.split(":");
    const iv = Buffer.from(textParts.shift(), "hex");
    const encryptedText = Buffer.from(textParts.join(":"), "hex");
    const decipher = crypto.createDecipheriv(
        cryptoAlgorithm,
        Buffer.from(cryptoPassword, "hex"),
        iv,
    );
    let decrypted = decipher.update(encryptedText);
    decrypted = Buffer.concat([decrypted, decipher.final()]);
    return decrypted.toString();
};

/**
 * Generates a JSON web token (JWT) for the specified user ID
 * @param {string} user_id - The user ID for which the JWT is to be generated
 * @param {boolean} remember_me - Whether or not to generate a long-lived JWT for "remember me" functionality
 * @returns {Promise<string>} - A Promise that resolves to the generated JWT
 */
export const generateJWT = async (user_id, remember_me) => {
    return await jwt.sign({ user_id }, app.jwtSecret, {
        expiresIn: remember_me
            ? `${expirationTime.remember.hours}${expirationTime.normal.unit}`
            : `${expirationTime.normal.hours}${expirationTime.normal.unit}`,
    });
};

/**
 * Decodes a JWT and returns the user ID it contains
 * @param {string} token - The JWT to be decoded
 * @returns {Promise<string>} - A Promise that resolves to the user ID contained in the JWT
 */
export const decodeJWT = async (token) => {
    try {
        const decoded = await jwt.verify(token, app.jwtSecret);
        return decoded.user_id;
    } catch (err) {
        throw err;
    }
};

/**
 * Adds the specified number of hours to a given date
 * @param {Date} date - The date to which hours are to be added
 * @param {number} hours - The number of hours to add to the date
 * @returns {Date} - The resulting date
 */
export const addHoursToDate = (date, hours) => {
    return new Date(new Date(date).setHours(date.getHours() + hours));
};

/**
 * Adds the specified number of minutes to a given date
 * @param {Date} date - The date to which minutes are to be added
 * @param {number} minutes - The number of minutes to add to the date
 * @returns {Date} - The resulting date
 */
export const addMinutesToDate = (date, minutes) => {
    return new Date(new Date(date).setMinutes(date.getMinutes() + minutes));
};

/**
 * Gets the filename and extension from a given path/filename string
 * @param {string} pathfilename - The path/filename string from which to extract the filename and extension
 * @returns {string[]} - An array containing the filename and extension, respectively
 */
export const getFilenameAndExtension = (pathfilename) => {
    const filenameextension = pathfilename.replace(/^.*[\\\/]/, "");
    const filename = filenameextension.substring(0, filenameextension.lastIndexOf("."));
    const ext = filenameextension.split(".").pop();

    return [filename, ext];
};

/**
 * Groups an array of objects by the specified key
 * @param {Object[]} arr - The array of objects to be grouped
 * @param {string} key - The key by which to group the objects
 * @returns {Object} - An object containing the groups of objects, with keys corresponding to the grouping key values
 */
export const groupBy = (arr, key) => {
    const initialValue = {};
    return arr.reduce((acc, cval) => {
        const myAttribute = cval[key];
        acc[myAttribute] = [...(acc[myAttribute] || []), cval];
        return acc;
    }, initialValue);
};

/**
 * Creates a success response object for use in AWS Lambda functions
 * @param {Object|string} body - The body of the response object; can be an object or a string
 * @param {number} statusCode - The HTTP status code of the response
 * @returns {Object} - The response object, including headers necessary for CORS and content type
 */
export const createSuccessResponse = (body, statusCode) => {
    const bodyString = typeof body === "object" ? JSON.stringify(body) : body;
    return {
        statusCode,
        body: bodyString,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json ",
        },
    };
};

/**
 * Creates an error response object with a given message and status code
 *
 * @param {string} message - The error message
 * @param {number} statusCode - The HTTP status code
 * @returns {Object} - The error response object
 */
export const createErrorResponse = (message, statusCode) => ({
    statusCode,
    message: message || "Internal Server Error",
    headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json ",
    },
});

/**
 * Converts a readable stream to a string
 *
 * @param {stream.Readable} stream - The stream to convert
 * @returns {Promise<string>} - A promise that resolves to the stream content as a string
 */
export const streamToString = (stream) =>
    new Promise((resolve, reject) => {
        const chunks = [];
        stream.on("data", (chunk) => chunks.push(chunk));
        stream.on("error", reject);
        stream.on("end", () => resolve(Buffer.concat(chunks).toString("utf8")));
    });

/**
 * Parses cookies from a given request object
 *
 * @param {Object} request - The request object
 * @returns {Object} - An object with the parsed cookies
 */
export const parseCookies = (request) => {
    const list = {};
    try {
        const cookieHeader =
            request.queryStringParameters && request.queryStringParameters.cookie
                ? request.queryStringParameters.cookie.split(";")
                : request.cookies
                ? request.cookies
                : request.headers.Cookie
                ? request.headers.Cookie.split(";")
                : request.headers.cookie
                ? request.headers.cookie.split(";")
                : request.headers.authorization
                ? request.headers.authorization.split(";")
                : request.headers.Authorization.split(";");

        if (!cookieHeader) return list;

        cookieHeader.forEach((cookie) => {
            const [name, ...rest] = cookie.split(`=`);
            const trimedName = name?.trim();
            if (!trimedName) return;
            const value = rest.join(`=`).trim();
            if (!value) return;
            list[trimedName] = decodeURIComponent(value);
        });
    } catch (err) {
        console.log("Some error occured in parsing cookies", err);
    }

    return list;
};

/**
 * Formats a date string to the format 'MM/DD/YYYY'
 *
 * @param {string} date - The date string to format
 * @returns {string} - The formatted date string
 */
export const formatDate = (date) => {
    const newDate = new Date(date);
    return `${newDate.getMonth() > 8 ? newDate.getMonth() + 1 : `0${newDate.getMonth() + 1}`}/${
        newDate.getDate() > 9 ? newDate.getDate() : `0${newDate.getDate()}`
    }/${newDate.getFullYear()}`;
};

/**
 * Creates a directory at the given path
 *
 * @param {string} path - The path of the directory to create
 * @returns {Promise<void>} - A promise that resolves when the directory is created
 */
export const createDirectory = async (path) => {
    try {
        if (!fs.existsSync(path)) {
            fs.mkdirSync(path);
        }
    } catch (err) {
        console.log("Error occured in creating directory", err);
    }
};

/**
 * Downloads a file from the given URL and saves it to the given file path
 *
 * @param {string} url - The URL of the file to download
 * @param {string} filePath - The path of the file to save to
 * @returns {Promise<void>} - A promise that resolves when the file is downloaded
 */
export const downloadFile = async (url, filePath) => {
    return await new Promise((resolve, reject) => {
        console.log("Downloading file from ", url, "to", filePath);
        https
            .get(url, (response) => {
                const code = response.statusCode ? response.statusCode : 0;

                if (code >= 400) {
                    return reject(new Error(response.statusMessage));
                }

                // handle redirects
                if (code > 300 && code < 400 && !!response.headers.location) {
                    return downloadFile(response.headers.location, filePath);
                }

                // save the file to disk
                const fileWriter = fs.createWriteStream(filePath).on("finish", () => {
                    console.log("Download Completed!");
                    resolve({});
                });

                response.pipe(fileWriter);
                return "File written";
            })
            .on("error", (error) => {
                console.log("Error occured in downloading file", error);
                reject(error);
            });
    });
};

/**
 * Returns the top-level domain of a given URL without any subdomains.
 * @param {string} domain - The full domain to extract the top-level domain from.
 * @returns {string} - The top-level domain of the given domain without any subdomains.
 * @throws {Error} - Throws an error if the domain cannot be processed.
 */
export const getDomainWithoutSubdomain = (domain) => {
    try {
        const domainCharacters = domain.split("").reverse();
        let domainReversed = "";
        let dotCount = 0;

        do {
            if (domainCharacters[0] === ".") {
                dotCount++;
                if (dotCount === 2) break;
            }
            domainReversed += domainCharacters[0];
            domainCharacters.splice(0, 1);
        } while (dotCount < 2 && domainCharacters.length > 0);

        return domainReversed.split("").reverse().join("");
    } catch (err) {
        console.log("Error occured while getting domain without sub domain", err);
        throw err;
    }
};

/**
 * Returns the size of a file in bytes given the file's path.
 * @param {string} filename - The path to the file to get the size of.
 * @returns {number} - The size of the file in bytes.
 */
export const getFilesizeInBytes = (filename) => {
    const stats = fs.statSync(filename);
    return stats.size;
};

/**
 * Returns the start and end dates of a specified period based on a given date.
 * @param {string} periodType - The type of period to get ("day", "month", "months", or "year").
 * @param {string[]} date - The date to calculate the period start and end from.
 * @param {number} value - The number of months to subtract when the periodType is "months".
 * @returns {Date[]} - An array containing the start and end dates of the specified period.
 * @throws {Error} - Throws an error if the periodType is not one of the specified types.
 */
export const getPeriodStartEnd = (periodType, date, value) => {
    if (periodType === "date_range") return [new Date(date[0]), new Date(date[1])];

    const startDate = new Date(date[0]);
    const endDate = new Date(date[0]);

    if (periodType === "day") {
        startDate.setHours(0, 0, 0, 0);
        endDate.setHours(23, 59, 59, 999);
    } else if (periodType === "month") {
        startDate.setDate(1);
        endDate.setMonth(endDate.getMonth() + 1);
        endDate.setDate(0);
        endDate.setHours(23, 59, 59, 999);
    } else if (periodType === "months") {
        startDate.setMonth(startDate.getMonth() - value);
        startDate.setDate(0);
        endDate.setMonth(endDate.getMonth() + 1);
        endDate.setDate(0);
        endDate.setHours(23, 59, 59, 999);
    } else if (periodType === "year") {
        startDate.setFullYear(startDate.getFullYear() - 1);
        startDate.setMonth(startDate.getMonth());
        endDate.setMonth(startDate.getMonth());
        endDate.setHours(23, 59, 59, 999);
    } else {
        throw new Error("Invalid period type");
    }

    return [startDate, endDate];
};
