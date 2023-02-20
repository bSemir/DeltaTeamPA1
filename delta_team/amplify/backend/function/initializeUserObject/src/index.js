/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */

const AWS = require("aws-sdk");
const dynamoDb = new AWS.DynamoDB.DocumentClient({
    region: "us-east-1",
});

exports.handler = async (event) => {
    console.log(`EVENT: ${JSON.stringify(event)}`);

    let body = JSON.parse(event.body);
    console.log(body);

    // get roles from the body user sent
    let roles = body.roles;
    roles = roles.map((role) => `${role}Lectures`);
    let projection = roles.join(" , ");

    let lectures, questions;
    try {
        const getRL = dynamoDb
            .query({
                TableName: "roles-lectures-d",
                KeyConditionExpression: "startdate = :date",
                ExpressionAttributeValues: {
                    ":date": body.date,
                },
                ProjectionExpression: projection,
            })
            .promise();
        const getOnb = dynamoDb
            .query({
                TableName: "onboardingdelta",
                KeyConditionExpression: "startdate = :date",
                ExpressionAttributeValues: {
                    ":date": body.date,
                },
            })
            .promise();

        const [result1, result2] = await Promise.all([getRL, getOnb]);
        lectures = result1.Items[0];
        questions = result2.Items[0].questions;
    } catch (err) {
        return {
            statusCode: 500,
            //  Uncomment below to enable CORS requests
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({
                err,
                info: "can't find lectures with given date",
            }),
        };
    }

    // Combine lectures from every role selected without duplicates
    let lecturesCombined = [];
    for (let key in lectures) {
        lecturesCombined = [...lecturesCombined, ...lectures[key]];
    }

    // get necessary data and create user object
    const joinedArray = lecturesCombined.reduce((acc, curr) => {
        const found = acc.find((item) => item.name === curr.name);
        if (!found) {
            acc.push(curr);
        }
        return acc;
    }, []);
    console.log(joinedArray);

    let userLectures = joinedArray.reduce((acc, curr, i) => {
        acc[curr.name] = curr;
        return acc;
    }, {});

    // get and check answers
    const answers = body.answers;
    let questionAnswers;
    try {
        questionAnswers = questions.map((item, i) => {
            if (!item.choices) {
                return {
                    ...item,
                    answer: answers[i],
                };
            }
            if (!item.choices.includes(answers[i])) {
                throw new Error("Invalid answer");
            }
            return {
                ...item,
                answer: answers[i],
            };
        });
    } catch (err) {
        return {
            statusCode: 400,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({
                err: "Invalid answer, it must be from given choices",
            }),
        };
    }

    // create user record
    let record = {
        id_username: event.requestContext.identity.cognitoAuthenticationProvider
            .split(":")
            .slice(-1)[0],
    };

    record[body.date] = {
        lectures: userLectures,
        onboarding: questionAnswers,
    };

    try {
        // Save the record to the table
        await dynamoDb
            .put({
                TableName: "User_delta",
                Item: record,
            })
            .promise();
        console.log("Record saved to DynamoDB");
        return {
            statusCode: 201,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({ lectures: record[body.date].lectures }),
        };
    } catch (error) {
        console.error(`Error saving record to DynamoDB: ${error}`);
        return {
            statusCode: 500,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*",
            },
            body: JSON.stringify({ error }),
        };
    }
};
