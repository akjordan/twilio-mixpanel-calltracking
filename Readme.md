# twilio-mixpanel-calltracking

This app is an excercise in creating a functional call tracking application with as little code as possible. It leans on Mixpanel in lieu of a database.

This demo takes inbound calls from a Twilio number and routes them to the root URL. There it generates TwiML to record the call and forward it on to an agent who's number you set as agent_number.

At the end of the call, Twilio makes a POST to /callback where the paramaters of that POST are pushed into Mixpanel.

## To deploy your own

Clone this repo locally and navigate to it's directory. Open up config.yml and change the config settings as needed.

Once your config is set up, run these commands:

    $ bundle install
    $ heroku create
    $ git add .
    $ git commit -m "push to heroku"
    $ git push heroku master

Once you've got it running, point your Twilio numbers to it and enjoy Mixpanels analytics.