const https = require('https');

exports.handler = async () => {

  try {
    var loans = await getLoans();
    loans.body.forEach(item => {
      if (item.revenueRate > '0.04' && item.termInMonths < 36) {
        console.log(
            "ID: " + item.id +
            ", Revenue rate: " + item.revenueRate +
            ", Term in months: " + item.termInMonths);
      }
    });
  } catch (err) {
    console.error(err);
  }
};


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
