Router.route "scrumboard",
	path: "/"
	template: "scrumboard"
	subscriptions: -> Meteor.subscribe "cards"
	data: ->
		states: -> _.values Cards.States

Template.scrumboard_cards.helpers
	cards: ->
		Cards.find state: @state

Template.scrumboard_column.events
	'dragover .column': (event) -> event.preventDefault()
	"drop .column": (event) ->
		event.preventDefault()
		cardId = event.originalEvent.dataTransfer.getData "cardId"
		Cards.update cardId, $set: state: Template.currentData().value


Meteor.startup ->
	clippy.loadRandom (agent) ->
		agent.show()
		agent.speak "Hi, It looks like you try to do some SCRUM! \n Would you like help?"
		isObserving = no
		
			
		Cards.find().observe 
			added: (document) ->
				if isObserving
					agent.speak "Oh you added a new card. Do you need help doing this task?"
					agent.animate()
			
			changed: (newDocument, oldDocument) ->
				if isObserving
					agent.animate()
			 
			removed: (oldDocument) ->
				if isObserving
					agent.speak "It looks like you removed a card. Do you need some inspirations for new cards?"
		
		Meteor.setTimeout ->
			isObserving = yes
		,5000
		Tracker.autorun ->
			{connected} = Meteor.status()
			agent.animate()
			unless connected
				agent.speak "Oh, it looks like you losed connection to the server. I can't help you, sorry!"
		
		
		
		

			