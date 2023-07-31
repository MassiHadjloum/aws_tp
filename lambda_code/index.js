const AWS = require('aws-sdk');


exports.handler = async (event) => {
  const LogError = (msg, err, data) => {
    if (err) {
      console.log("Une erreur est détectée ".red.underline, err)
    } else {
      console.log(msg)
    }
  }

  try {
    const s3 = new AWS.S3()
    console.log('LAMBDA déclenchée !');

    // Récupérer le corps de la requête
    const requestBody = event?.body;
    console.log('requestBody --> ', requestBody);

    const { file_name, content } = requestBody
    const UpDateBucket = (name_buket, file_name, content) => {
      s3?.putObject(
        { Bucket: name_buket, Key: file_name, Body: content },
        (err, data) => LogError("Le bucket is updated successfully", err, data)
      )
    }

    UpDateBucket("massi-esi", file_name, content, s3)
    
    const response = {
      statusCode: 200,
      body: JSON.stringify({message :`file ${file_name} added successfully`}),
    };
    return response;

  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify(error)
    }
  }
};