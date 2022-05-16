App =
	oncreate: !->
		url = \https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/index.json
		@flags = await (await fetch url)json!
		for flag in @flags
			name = flag.unicode.toLowerCase!replace /u\+/g "" .replace " " \-
			flag.twemoji = "https://cdn.jsdelivr.net/gh/twitter/twemoji@14.0.2/assets/svg/#name.svg"
		m.redraw!

	view: ->
		if @flags
			m \.grid.p-2,
				style:
					gridTemplateColumns: "repeat(auto-fill,minmax(80px,1fr))"
				@flags.map (flag) ~>
					m \.flex.flex-col.items-center.text-center.text-sm.cursor-copy.hover:outline.hover:outline-dotted.hover:outline-2,
						onclick: !~>
							navigator.clipboard.writeText flag.emoji
						m \img.h-10,
							src: flag.twemoji
						flag.name

m.mount document.body, App
