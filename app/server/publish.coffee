Meteor.startup ->

		
	Meteor.publish "cards", -> Cards.find()