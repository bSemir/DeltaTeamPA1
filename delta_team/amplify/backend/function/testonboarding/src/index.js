/* Amplify Params - DO NOT EDIT
    AUTH_OMEGAPA4E0A3671_USERPOOLID
    ENV
    REGION
Amplify Params - DO NOT EDIT */

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

const AWS = require('aws-sdk');
const dynamoDb = new AWS.DynamoDB.DocumentClient({
    region: 'us-east-1'
});

exports.handler = async (event) => {
    console.log(`EVENT: ${JSON.stringify(event)}`);

    const params = {
        TableName: 'onboardingdelta',
        Key: {
            'startdate': 'Jan2023'
        }
    };

    try {
        const result = await dynamoDb.get(params).promise();
        console.log(result)
        return {
            statusCode: 200,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*"
            },
            body: JSON.stringify(result.Item)
        };
    } catch (error) {
        return {
            statusCode: 500,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*"
            },
            body: JSON.stringify(error)
        };
    }
    // return {
    //     statusCode: 200,
    // //  Uncomment below to enable CORS requests
    //  headers: {
    //      "Access-Control-Allow-Origin": "*",
    //      "Access-Control-Allow-Headers": "*"
    //  }, 
    //     body: JSON.stringify('Hello from Lambda!'),
    // };
};
