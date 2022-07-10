import { DynamoDBClient, ListTablesCommand } from "@aws-sdk/client-dynamodb"; // ES Modules import

const configDevLocal = {
  region: "us-east-1",
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  },
  // https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-dynamodb/modules/credentials.html
};

const configDev = {
  region: "us-east-1",
};

const client = new DynamoDBClient(
  process.env.AWS_ACCESS_KEY_ID && process.env.AWS_SECRET_ACCESS_KEY
    ? configDevLocal
    : configDev
);

const params = {};
// both values are optional as per documentation, so passing an empty object will do

const command = new ListTablesCommand(params);

export default async () => {
  try {
    const response = await client.send(command);
    console.log(response.TableNames);
    return response.TableNames;
  } catch (error) {
    console.log(error);
  }
};

// https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-dynamodb/classes/listtablescommand.html
// https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-dynamodb/interfaces/listtablescommandinput.html
