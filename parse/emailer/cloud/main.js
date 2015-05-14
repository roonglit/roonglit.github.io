Parse.Cloud.define("sendEmail", function(request, response) {
  var Mandrill = require('mandrill');
  Mandrill.initialize('');

  var name = request.params.name;
  var email = request.params.email;
  var subject = request.params.subject;
  var message = request.params.message;

  Mandrill.sendEmail({
    message: {
      text: message,
      subject: subject,
      from_email: email,
      from_name: name,
      to: [
        {
          email: 'info@tripler.co.th',
          name: 'Tripler'
        }
      ]
    },
    async: true
  }, {
    success: function(httpResponse) {
      console.log(httpResponse);
      response.success('Email sent!');
    },
    error: function(httpResponse) {
      console.error(httpResponse);
      response.error('Uh oh, something went wrong');
    }
  })
});
