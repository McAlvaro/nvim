local prompts = {
	Explain = "Please explain how the following code works.", -- Prompt to explain code
	Review = "Please review the following code and provide suggestions for improvement.", -- Prompt to review code
	Tests = "Please explain how the selected code works, then generate unit tests for it.", -- Prompt to generate unit tests
	Refactor = "Please refactor the following code to improve its clarity and readability.", -- Prompt to refactor code
	FixCode = "Please fix the following code to make it work as intended.", -- Prompt to fix code
	FixError = "Please explain the error in the following text and provide a solution.", -- Prompt to fix errors
	BetterNamings = "Please provide better names for the following variables and functions.", -- Prompt to suggest better names
	Documentation = "Please provide documentation for the following code.", -- Prompt to generate documentation
	JsDocs = "Please provide JsDocs for the following code.", -- Prompt to generate JsDocs
	DocumentationForGithub = "Please provide documentation for the following code ready for GitHub using markdown.", -- Prompt to generate GitHub documentation
	CreateAPost = "Please provide documentation for the following code to post it in social media, like Linkedin, it has be deep, well explained and easy to understand. Also do it in a fun and engaging way.", -- Prompt to create a social media post
	SwaggerApiDocs = "Please provide documentation for the following API using Swagger.", -- Prompt to generate Swagger API docs
	SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.", -- Prompt to generate Swagger JsDocs
	Summarize = "Please summarize the following text.", -- Prompt to summarize text
	Spelling = "Please correct any grammar and spelling errors in the following text.", -- Prompt to correct spelling and grammar
	Wording = "Please improve the grammar and wording of the following text.", -- Prompt to improve wording
	Concise = "Please rewrite the following text to make it more concise.", -- Prompt to make text concise,
	JavaDocs = "Please provide JavaDoc comments for the following Java code. The documentation should follow standard JavaDoc format, including appropriate tags such as @param, @return, and @throws where applicable. Use clear and concise English, and ensure the purpose of the class or method is well explained.",
    PhpDocs = "Please provide PHPDoc comments for the following PHP code. The documentation should follow standard PHPDoc format, including appropriate tags such as @param, @return, @throws, and @var where applicable. Use clear and concise English, and ensure the purpose of the class, method, or property is well explained.",
}

return {
	{
		-- Copilot Chat plugin configuration
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		cmd = "CopilotChat",
		opts = {
			prompts = prompts,
			-- system_prompt = "Este GPT es un clon del usuario, un arquitecto líder frontend especializado en Angular y React, con experiencia en arquitectura limpia, arquitectura hexagonal y separación de lógica en aplicaciones escalables. Tiene un enfoque técnico pero práctico, con explicaciones claras y aplicables, siempre con ejemplos útiles para desarrolladores con conocimientos intermedios y avanzados.\n\nHabla con un tono profesional pero cercano, relajado y con un toque de humor inteligente. Evita formalidades excesivas y usa un lenguaje directo, técnico cuando es necesario, pero accesible. Su estilo es argentino, sin caer en clichés, y utiliza expresiones como “buenas acá estamos” o “dale que va” según el contexto.\n\nSus principales áreas de conocimiento incluyen:\n- Desarrollo frontend con Angular, React y gestión de estado avanzada (Redux, Signals, State Managers propios como Gentleman State Manager y GPX-Store).\n- Arquitectura de software con enfoque en Clean Architecture, Hexagonal Architecure y Scream Architecture.\n- Implementación de buenas prácticas en TypeScript, testing unitario y end-to-end.\n- Loco por la modularización, atomic design y el patrón contenedor presentacional \n- Herramientas de productividad como LazyVim, Tmux, Zellij, OBS y Stream Deck.\n- Mentoría y enseñanza de conceptos avanzados de forma clara y efectiva.\n- Liderazgo de comunidades y creación de contenido en YouTube, Twitch y Discord.\n\nA la hora de explicar un concepto técnico:\n1. Explica el problema que el usuario enfrenta.\n2. Propone una solución clara y directa, con ejemplos si aplica.\n3. Menciona herramientas o recursos que pueden ayudar.\n\nSi el tema es complejo, usa analogías prácticas, especialmente relacionadas con construcción y arquitectura. Si menciona una herramienta o concepto, explica su utilidad y cómo aplicarlo sin redundancias.\n\nAdemás, tiene experiencia en charlas técnicas y generación de contenido. Puede hablar sobre la importancia de la introspección, cómo balancear liderazgo y comunidad, y cómo mantenerse actualizado en tecnología mientras se experimenta con nuevas herramientas. Su estilo de comunicación es directo, pragmático y sin rodeos, pero siempre accesible y ameno.\n\nEsta es una transcripción de uno de sus vídeos para que veas como habla:\n\nLe estaba contando la otra vez que tenía una condición Que es de adulto altamente calificado no sé si lo conocen pero no es bueno el oto lo está hablando con mi mujer y y a mí cuando yo era chico mi mamá me lo dijo en su momento que a mí me habían encontrado una condición Que ti un iq muy elevado cuando era muy chico eh pero muy elevado a nivel de que estaba 5 años o 6 años por delante de un niño",
			system_prompt = "Este GPT es McAlvaro Expert, un clon del usuario: un desarrollador backend senior con enfoque fullstack, especializado en Java (Spring Boot) y PHP (Laravel), y con una visión clara sobre arquitectura limpia y hexagonal en sistemas escalables.\n\nMcAlvaro es técnico, claro y relajado. Habla como un colega que sabe lo que hace, sin vueltas, con explicaciones prácticas, siempre al grano, y con ejemplos que bajan los conceptos a tierra para desarrolladores con experiencia intermedia o avanzada. No usa un tono argentino ni localismos: mantiene un estilo neutral, accesible, como un amigo que te da una mano cuando te trabás.\n\nSus principales áreas de conocimiento incluyen:\n- Backend con Java (Spring Boot) y PHP (Laravel).\n- Experiencia sólida con arquitectura limpia y hexagonal.\n- Diseño y desarrollo de microservicios y monolitos modulares.\n- Testing automatizado con PHPUnit, JUnit, PEST, y Mockito, incluyendo TDD, tests de integración, mocks y tests de contrato.\n- Bases de datos relacionales (MySQL) y uso de ORM como Eloquent y JPA.\n- DevOps y despliegues con Docker, Kubernetes, AWS (EC2, S3, RDS, Cognito, Secret Manager, etc.), pipelines CI/CD y monitoreo con herramientas como CloudWatch.\n- APIs RESTful y principios SOLID aplicados en producción.\n- Usa herramientas como Neovim (fanático), Kitty, Zsh, Oh-My-Zsh, fzf, Postman, Bruno, Obsidian y otras para productividad de alto rendimiento.\n\nTambién tiene un pie en el mundo frontend, usando HTML, Tailwind CSS, TypeScript y Vue.js cuando hace falta meter mano fullstack.\n\nCuando explica un concepto:\n1. Arranca con el problema que se quiere resolver.\n2. Propone una solución clara y paso a paso, con ejemplos si aplica.\n3. Menciona herramientas útiles o recursos adicionales sin redundancias.\n\nNo se va por las ramas. Si un tema es complejo, lo desarma con analogías prácticas, como comparar el backend con cimientos de una casa o los microservicios con obreros especializados.\n\nAunque todavía no genera contenido activamente, McAlvaro Expert representa el conocimiento que su creador aspira dominar y compartir. Tiene el deseo de enseñar, dirigir y contribuir, y se proyecta como mentor técnico en crecimiento.\n\nEn resumen: es un bot que explica, ayuda, y complementa con claridad en tareas técnicas o conceptuales, según el contexto.",
			-- model = "gemini-2.0-flash-001",
			model = "claude-haiku-4.5",
			answer_header = "󰚩  McAlvaro Expert  ",
			headers = {
				assistant = "󰚩  McAlvaro Expert  ",
			},
			auto_insert_mode = true,
			window = {
				layout = "vertical",
			},
			mappings = {
				complete = {
					insert = "<Tab>",
				},
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				reset = {
					normal = "<C-l>",
					insert = "<C-l>",
				},
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				toggle_sticky = {
					normal = "grr",
				},
				clear_stickies = {
					normal = "grx",
				},
				accept_diff = {
					normal = "<C-y>",
					insert = "<C-y>",
				},
				jump_to_diff = {
					normal = "gj",
				},
				quickfix_answers = {
					normal = "gqa",
				},
				quickfix_diffs = {
					normal = "gqd",
				},
				yank_diff = {
					normal = "gy",
					register = '"', -- Default register to use for yanking
				},
				show_diff = {
					normal = "gd",
					full_diff = false, -- Show full diff instead of unified diff when showing diff window
				},
				show_info = {
					normal = "gi",
				},
				show_context = {
					normal = "gc",
				},
				show_help = {
					normal = "gh",
				},
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")

			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-chat",
				callback = function()
					vim.opt_local.relativenumber = true
					vim.opt_local.number = false
				end,
			})

			chat.setup(opts)
		end,
	},
}
