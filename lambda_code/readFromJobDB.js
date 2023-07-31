const AWS = require('aws-sdk');
const dynamodb = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  try {
    const params = {
      TableName: 'actionTable', 
    };
    const result = await dynamodb.scan(params).promise();
    console.log('params --> ', result.items);
   
    const response = {
      statusCode: 200,
      body: JSON.stringify({data: result.items}),
    };
    return response;
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify(error)
    }
  }
};