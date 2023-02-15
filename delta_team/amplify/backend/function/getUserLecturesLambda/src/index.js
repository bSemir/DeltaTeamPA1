

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

const AWS = require("aws-sdk");
const dynamoDb = new AWS.DynamoDB.DocumentClient({
    region: "us-east-1",
});

// this api returns all lectures that user is taking
exports.handler = async (event) => {
    // console.log(`EVENT: ${JSON.stringify(event)}`);
    let date = event.queryStringParameters.paDate;
    // name is optional (returns single lecture)
    let lecture_name = event.queryStringParameters.name;
    if (!date) {
        return {
            statusCode: 400,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({
                error: "You need to provide the paDate",
            }),
        };
    }
    // console.log('body: ', event.body);
    let user_data, user_lectures;
    const user_id = event.requestContext.identity.cognitoAuthenticationProvider.split(
        ":CognitoSignIn:"
    )[1];

    try {
        // TODO: improve the quality of this code!
        if (lecture_name) {
            user_data = await dynamoDb
                .query({
                    TableName: "User_delta",
                    KeyConditionExpression: "id_username = :user_id",
                    ExpressionAttributeValues: {
                        ":user_id": user_id,
                    },
                    ProjectionExpression: `#date.lectures.#name`,
                    ExpressionAttributeNames: {
                        "#name": lecture_name,
                        "#date": date,
                    }
                })
                .promise();
            console.log(user_data);
            user_lectures = user_data.Items[0][date].lectures;
            return {
                statusCode: 200,
                //  Uncomment below to enable CORS requests
                headers: {
                    "Access-Control-Allow-Origin": "*",
                    "Access-Control-Allow-Headers": "*"
                },
                body: JSON.stringify({ user_lectures: Object.values(user_lectures) })
            };
        }
        else {
            user_data = await dynamoDb
                .query({
                    TableName: "User_delta",
                    KeyConditionExpression: "id_username = :user_id",
                    ExpressionAttributeValues: {
                        ":user_id": user_id,
                    },
                    ProjectionExpression: `#date.lectures`,
                    ExpressionAttributeNames: {
                        "#date": date,
                    }
                })
                .promise();
            console.log(user_data);
            user_lectures = user_data.Items[0][date].lectures;
            return {
                statusCode: 200,
                //  Uncomment below to enable CORS requests
                headers: {
                    "Access-Control-Allow-Origin": "*",
                    "Access-Control-Allow-Headers": "*"
                },
                body: JSON.stringify({ user_lectures: Object.values(user_lectures) })
            };
        }
    } catch (err) {
        console.log(err)
        return {
            statusCode: 500,
            //  Uncomment below to enable CORS requests
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({
                err,
                info: "cannot find lectures with that date",
            }),
        };
    }
}
