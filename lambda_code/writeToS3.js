var AWS = require('aws-sdk');

var s3 = new AWS.S3();

exports.handler = async (event) => {
    console.log('event --> ', event);
    console.log('LAMBDA declenchée ! ');
    try {
        const queryBody = JSON.parse(event.body)

        const objectToWrite = {
            Bucket: process.env.BUCKET_NAME,
            Key: queryBody.Key,
            Body: queryBody.Body,
        };

        const response = await s3.upload(objectToWrite).promise();
        const apiResponse = {
            statusCode: 200,
            body: JSON.stringify({message: `Successfull S3 written in ${queryBody.Key}`}),
        };
        return apiResponse;

    } catch (err) {
        const apiResponse = {
            statusCode: 500,
            body: JSON.stringify('Client.send ERROR : ', err),
        };
        return apiResponse;
    }

};
