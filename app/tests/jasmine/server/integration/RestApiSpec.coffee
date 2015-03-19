Jasmine.onTest ->
	describe "REST api", ->
		GET = (path, options)->
			result = HTTP.get (Meteor.absoluteUrl path), options
			JSON.parse result.content
		POST = (path, options)->
			result = HTTP.post (Meteor.absoluteUrl path), options
			JSON.parse result.content
		PUT = (path, options)->
			result = HTTP.put (Meteor.absoluteUrl path), options
			JSON.parse result.content
		DELETE = (path, options)->
			result = HTTP.call "delete", (Meteor.absoluteUrl path), options
			JSON.parse result.content
		beforeEach ->
			Cards.find().forEach (card) ->
				Cards.remove card._id

		describe "GET api/cards", ->
			it "is successfull", ->
				expect GET("api/cards").status
				.toBe "success"	
			it "is empty at beginning", ->
				expect GET("api/cards").data.length
					.toBe 0

			describe "with samples", ->
				beforeEach ->
					Cards.insert Cards.SAMPLE
					Cards.insert Cards.SAMPLE_IN_PROGRESS
			
				it "delivers 2 samples", ->
					expect GET("api/cards").data.length
					.toBe 2
				it "contains SAMPLE", ->
					expect GET("api/cards").data
					.toContain Cards.SAMPLE
				it "contains SAMPLE_IN_PROGRESS", ->
					expect GET("api/cards").data
					.toContain Cards.SAMPLE_IN_PROGRESS
				it "not contains SAMPLE_DONE", ->
					expect GET("api/cards").data
					.not.toContain Cards.SAMPLE_DONE
				it "can deliver one sample", ->
					expect GET("api/cards/#{Cards.SAMPLE._id}").data
					.toEqual Cards.SAMPLE
					expect GET("api/cards/#{Cards.SAMPLE_IN_PROGRESS._id}").data
					.toEqual Cards.SAMPLE_IN_PROGRESS




		describe "POST api/cards", ->
			it "creates a new card", ->
				POST "api/cards", data: Cards.SAMPLE
				expect GET("api/cards").data
				.toContain Cards.SAMPLE
			it "requires title", ->
				expect ->
					POST "api/cards", data: 
						description: "bla"
				.toThrowError()
			it "does not allow empty data", ->
				expect ->
					POST "api/cards", data: {}
				.toThrowError()
			it "is satisfied with only the title", ->
				expect ->
					POST "api/cards", data: title: "test"
				.not.toThrowError()
			it "does not allow entries with same _id", ->
				expect ->
					POST "api/cards", data: Cards.SAMPLE
				.not.toThrowError()
				expect ->
					POST "api/cards", data: Cards.SAMPLE
				.toThrowError()

		describe "DELETE api/cards/:id", ->
			beforeEach ->
				Cards.insert Cards.SAMPLE
				Cards.insert Cards.SAMPLE_IN_PROGRESS
			it "deletes a card", ->
				expect GET("api/cards").data
					.toContain Cards.SAMPLE
				DELETE "api/cards/#{Cards.SAMPLE._id}"
				expect GET("api/cards").data
					.not.toContain Cards.SAMPLE
			it "throws error when deleting a non existing card", ->
		
				DELETE "api/cards/#{Cards.SAMPLE._id}"
				expect -> DELETE "api/cards/#{Cards.SAMPLE._id}"
				.toThrowError()
				
		describe "PUT api/cards/:id", ->
			beforeEach ->
				Cards.insert Cards.SAMPLE
				Cards.insert Cards.SAMPLE_IN_PROGRESS
			it "can updates fields", ->
				PUT "api/cards/#{Cards.SAMPLE._id}", data: $set: title: "my new title"
				PUT "api/cards/#{Cards.SAMPLE._id}", data: $set: 
					description: "my new description"
					state: "done"
				newCard = GET("api/cards/#{Cards.SAMPLE._id}").data
				expect newCard.title
				.toBe "my new title"
				expect newCard.description
				.toBe "my new description"
				expect newCard.state
				.toBe "done"
			it "does not allow invalid states", ->
				expect -> PUT "api/cards/#{Cards.SAMPLE._id}" , data: $set: state: "fooo"
				.toThrowError()
			it "throws an error if no id given", ->
				expect -> PUT "api/cards/" , data: $set: title: "fooo"
				.toThrowError()






