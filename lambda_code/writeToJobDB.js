const AWS = require('aws-sdk');
const dynamodb = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {

  try {

    console.log('LAMBDA déclenchée !');

    // Récupérer le corps de la requête
    const requestBody = JSON.parse(event.body);
    console.log('requestBody --> ', requestBody);

    // Préparer les paramètres pour l'insertion dans DynamoDB
    const params = {
      TableName: 'actionTable', // Remplacez par le nom de votre table DynamoDB
      Item: {
        id: requestBody.id,
        job_type: requestBody.job_type,
        content: requestBody.content,
        is_done: requestBody.is_done
      }
    };
    console.log('params --> ', params);

    // Insérer les données dans DynamoDB
    const res = await dynamodb.put(params).promise();
    console.log('res --> ', res);
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