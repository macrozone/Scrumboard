share.TestHelpers = 
	checkColumnForSampleCard: ($cards) ->
		$card = $cards.find("li").eq(0)
		expect $card.find(".title").text()
		.toBe Cards.SAMPLE.title
		expect $card.find(".description").text()
		.toBe Cards.SAMPLE.description
		expect $card.find(".estimate").text()
		.toBe Cards.SAMPLE.estimate.toString()
		expect $card.find(".responsible").text()
		.toBe Cards.SAMPLE.responsible