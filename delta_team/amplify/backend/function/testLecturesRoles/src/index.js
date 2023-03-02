

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */


const AWS = require('aws-sdk');
const dynamoDb = new AWS.DynamoDB.DocumentClient({
    region: 'us-east-1'
});

exports.handler = async (event) => {
    console.log(`EVENT: ${JSON.stringify(event)}`);
    // TODO: test, get all lectures...
    const params = {
        TableName: 'roles-lectures-d',
        Key: {
            'startdate': 'Jan2023'
        }
    };

    try {
        const result = await dynamoDb.get(params).promise();
        console.log("result: ", result);
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
};
