/datum/hud/proc/add_multiz_buttons(mob/owner)
	var/atom/movable/screen/using

	using = new /atom/movable/screen/multiz_up_button()
	using.screen_loc = retro_hud ? UI_MULTIZ_UP_RETRO : UI_MULTIZ_UP
	using.icon = retro_hud ? ui_style : using.icon
	if(isAI(owner))
		using.screen_loc = UI_MULTIZ_UP_AI
	using.hud = src
	infodisplay += using

	using = new /atom/movable/screen/multiz_down_button()
	using.screen_loc = retro_hud ? UI_MULTIZ_DOWN_RETRO : UI_MULTIZ_DOWN
	using.icon = retro_hud ? ui_style : using.icon
	if(isobserver(owner))
		using.screen_loc = retro_hud ? UI_MULTIZ_DOWN_OBSERVER_RETRO : UI_MULTIZ_DOWN_OBSERVER
	else if(isAI(owner))
		using.screen_loc = UI_MULTIZ_DOWN_AI
	using.hud = src
	infodisplay += using

/atom/movable/screen/multiz_up_button
	name = "Вверх"
	icon = 'icons/hud/neoscreen.dmi'
	icon_state = "multiz_up"

/atom/movable/screen/multiz_down_button
	name = "Вниз"
	icon = 'icons/hud/neoscreen.dmi'
	icon_state = "multiz_down"

/atom/movable/screen/multiz_up_button/Click()
	usr.up()

/atom/movable/screen/multiz_down_button/Click()
	usr.down()
