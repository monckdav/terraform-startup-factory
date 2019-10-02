const https = require('https');

exports.handler = async (event) => {
  const text = event.Records[0].Sns.Message;

  return sendSlackMessage(text)
  .then(result => {
    return result;
  })
  .catch(err => {
    console.log('Error: ', err);
    return err;
  });
};

const sendSlackMessage = (text) => {
  return new Promise((resolve, reject) => {

    const payload = JSON.stringify({
      text: text
    });

      console.log(payload);

      const options = {
        host: 'hooks.slack.com',
        path: '/services/T03PATMPV/BNZD82SRE/67fGmiGiVe4OMXrJwWwyUuX1',
        port: 443,
        method: 'POST',
      };

      const req = https.request(options, (res) => {
        res.on('data', () => {
          resolve();
        });
      });

      req.on('error', (e) => {
        reject(e.message);
      });

      req.write(payload);
      req.end();
    });
};
