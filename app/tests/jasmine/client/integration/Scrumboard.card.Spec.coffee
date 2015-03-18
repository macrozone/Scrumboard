describe "Scrumboard", ->
	describe "Card", ->
		$card = null
		$cardInProgress = null
		$cardDone = null
		beforeEach ->
			Cards.find().forEach (card) ->
				Cards.remove card._id
			Cards.insert Cards.SAMPLE
			Cards.insert Cards.SAMPLE_IN_PROGRESS
			Cards.insert Cards.SAMPLE_DONE
			
			Tracker.flush()
			$card = $ ".scrumboard .column-todo ul.cards .card"
			$cardInProgress = $ ".scrumboard .column-in-progress ul.cards .card"
			$cardDone = $ ".scrumboard .column-done ul.cards .card"
			
		

		it "shows title", ->
			expect $card.find(".title").text()
			.toBe Cards.SAMPLE.title
		it "shows description", ->
			expect $card.find(".description").text()
			.toBe Cards.SAMPLE.description
		it "shows estimate", ->
			expect $card.find(".estimate").text()
			.toBe Cards.SAMPLE.estimate.toString()
		it "shows responsible", ->
			expect $card.find(".responsible").text()
			.toBe Cards.SAMPLE.responsible
		it "is draggable", ->
			expect $card.prop "draggable"
			.toBe true
		it "has a delete button", ->
				expect $card.find(".btn-delete").length
				.toBe 1
				
		describe "delete-button", ->
			it "deletes the card on click", ->
				$card.find(".btn-delete").trigger "click"
				Tracker.flush()
				expect Cards.findOne Cards.SAMPLE._id
				.not.toBeDefined()
			it "deletes no other card on click", ->
				$card.find(".btn-delete").trigger "click"
				Tracker.flush()
				expect Cards.findOne Cards.SAMPLE_IN_PROGRESS._id
				.toBeDefined()
				expect Cards.findOne Cards.SAMPLE_DONE._id
				.toBeDefined()


		describe "card-todo", ->
			it "shows button to select done or in-progress", ->
				expect($card.find(".btn-state-todo").length).toBe 0
				expect($card.find(".btn-state-in-progress").length).toBe 1
				expect($card.find(".btn-state-done").length).toBe 1
				
		describe "card-in-progress", ->
			it "shows button to select todo or done", ->
				expect($cardInProgress.find(".btn-state-todo").length).toBe 1
				expect($cardInProgress.find(".btn-state-in-progress").length).toBe 0
				expect($cardInProgress.find(".btn-state-done").length).toBe 1
		describe "card-done", ->
			it "shows button to select todo or in-progress", ->
				expect($cardDone.find(".btn-state-todo").length).toBe 1
				expect($cardDone.find(".btn-state-in-progress").length).toBe 1
				expect($cardDone.find(".btn-state-done").length).toBe 0



			
			


		
