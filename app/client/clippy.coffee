Meteor.startup ->
	clippy.loadRandom (agent) ->
		agent.show()
		agent.speak "Hi, It looks like you try to do some SCRUM! \n Would you like help?"
		isObserving = no
		
			
		Cards.find().observe 
			added: (document) ->
				if isObserving
					agent.stop()
					agent.speak "Oh you added a new card. Do you need help doing this task?"
					agent.animate()
			
			changed: (newDocument, oldDocument) ->
				if isObserving
					agent.animate()
			 
			removed: (oldDocument) ->
				if isObserving
					agent.stop()
					agent.speak "It looks like you removed a card. Do you need some inspirations for new cards?"
		
		Meteor.setTimeout ->
			isObserving = yes
		,5000
		informedAboutDisconnect = no
		Tracker.autorun ->
			{connected} = Meteor.status()
			console.log "connected", connected
			
			unless connected
				unless informedAboutDisconnect
					agent.stop()
					agent.speak "Oh, it looks like you losed connection to the server. I can't help you, sorry!"
					informedAboutDisconnect = yes
			else
				if informedAboutDisconnect
					agent.stop()
					agent.speak "Oh, it looks like you are ONLINE again!"
				informedAboutDisconnect = no
			agent.animate()
		
		