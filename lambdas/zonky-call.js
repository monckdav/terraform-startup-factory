const https = require('https');
const AWS = require("aws-sdk");
const sns = new AWS.SNS();

exports.handler = async () => {

  try {
    var loans = await getLoans();
    var numberOfLoans = 0;
    loans.body.forEach(item => {
      if (item.revenueRate > '0.04' && item.termInMonths < 36) {
        console.log(
            "ID: " + item.id +
            ", Revenue rate: " + item.revenueRate +
            ", Term in months: " + item.termInMonths);
        ++numberOfLoans;
      }
    });
    await publishToSns(numberOfLoans);
  } catch (err) {
    console.error(err);
  }
};

function publishToSns(numberOfLoans) {
  const params = {
    Message: "There are " + numberOfLoans + " interesting loan(s) in Zonky",
    Subject: "Zonky loans",
    TopicArn: "arn:aws:sns:eu-west-1:406030180379:dev-topic"
  };

  return sns.publish(params).promise();
}

function getLoans() {
  return new Promise((resolve, reject) => {
    const options = {
        host: 'private-anon-fbc62d6cac-zonky.apiary-proxy.com',
        path: '/loans/marketplace',
        method: 'GET',
    };

    const req = https.request(options, res => {
      var body = []

      res.on('data', data => {
        body.push(data);
      })

      res.on('end', () => {
        body = JSON.parse(Buffer.concat(body).toString());
        resolve({statusCode: res.statusCode, headers: res.headers, body: body})
      })
    });

    req.on('error', (e) => {
      reject(e.message);
    });

    req.end();
  });
}
