Meteor.startup ->
	Restivus.configure
		useAuth: yes
		prettyJson: yes
	Restivus.addCollection Cards
	