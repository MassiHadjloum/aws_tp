const AWS = require('aws-sdk');
const dynamodb = new AWS.DynamoDB.DocumentClient();

var s3 = new AWS.S3();

exports.handler = async (event) => {
  try {
    console.log('Dernière insertion: ======================================= ', event.Records[0].dynamodb.NewImage);
    // Récupérer le corps de la requête
    if (event.Records[0].dynamodb.NewImage.job_type.S === "S3") {
      const objectToWrite = {
        Bucket: process.env.BUCKET_NAME,
        Key: `${event.Records[0].dynamodb.NewImage.id.S}.txt`,
        Body: event.Records[0].dynamodb.NewImage.content.S,
      };

      const response = await s3.upload(objectToWrite).promise();
    } else {
      // Préparer les paramètres pour l'insertion dans DynamoDB
      const params = {
        TableName: 'contentTable', 
        Item: {
          id: event.Records[0].dynamodb.NewImage.id.S,
          job_type: event.Records[0].dynamodb.NewImage.job_type.S,
          is_done: event.Records[0].dynamodb.NewImage.is_done.S,
          content: event.Records[0].dynamodb.NewImage.content.S
        }
      };
      console.log('params --> ', params);
      // Insérer les données dans DynamoDB
      const res = await dynamodb.put(params).promise();
    }
    const response = {
      statusCode: 200,
      body: JSON.stringify('element inserted in dynamoDB'),
    };
    return response;
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify(error)
    }
  }
};