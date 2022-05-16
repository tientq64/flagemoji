App =
	oncreate: !->
		url = \https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/index.json
		@flags = await (await fetch url)json!
		for flag in @flags
			name = flag.unicode.toLowerCase!replace /u\+/g "" .replace " " \-
			flag.twemoji = "https://cdn.jsdelivr.net/gh/twitter/twemoji@14.0.2/assets/svg/#name.svg"
			flag.title = """
				Name: #{flag.name}
				Code: #{flag.code}
			"""
		m.redraw!

	onclickFlag: (flag) !->
		navigator.clipboard.writeText flag.emoji

	view: ->
		if @flags
			m \.flags,
				@flags.map (flag) ~>
					m \.flag,
						title: flag.title
						onclick: !~>
							@onclickFlag flag
						m \img.flag-img,
							src: flag.twemoji
						m \.flag-name,
							flag.name

m.mount document.body, App
