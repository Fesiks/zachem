// Chili
/obj/item/seeds/chili
	name = "pack of chili seeds"
	desc = "These seeds grow into chili plants. HOT! HOT! HOT!"
	icon_state = "seed-chili"
	species = "chili"
	plantname = "Chili Plants"
	product = /obj/item/food/grown/chili
	lifespan = 20
	maturation = 5
	production = 5
	yield = 4
	potency = 20
	instability = 30
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "chili-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "chili-dead" // Same for the dead icon
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/chili/ice, /obj/item/seeds/chili/ghost)
	reagents_add = list(/datum/reagent/consumable/capsaicin = 0.25, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.04)

/obj/item/food/grown/chili
	seed = /obj/item/seeds/chili
	name = "chili"
	desc = "It's spicy! Wait... IT'S BURNING ME!!"
	icon_state = "chilipepper"
	bite_consumption_mod = 2
	foodtypes = FRUIT
	wine_power = 20

// Ice Chili
/obj/item/seeds/chili/ice
	name = "pack of chilly pepper seeds"
	desc = "Семена выросли в перец чили."
	icon_state = "seed-icepepper"
	species = "chiliice"
	plantname = "Chilly Pepper Plants"
	product = /obj/item/food/grown/icepepper
	lifespan = 25
	maturation = 4
	production = 4
	rarity = 20
	genes = list(/datum/plant_gene/trait/chem_cooling)
	mutatelist = list()
	reagents_add = list(/datum/reagent/consumable/frostoil = 0.25, /datum/reagent/consumable/nutriment/vitamin = 0.02, /datum/reagent/consumable/nutriment = 0.02)
	graft_gene = /datum/plant_gene/trait/chem_cooling

/obj/item/food/grown/icepepper
	seed = /obj/item/seeds/chili/ice
	name = "перец чили"
	desc = "Мутировавший сорт чили."
	icon_state = "icepepper"
	bite_consumption_mod = 2
	foodtypes = FRUIT
	wine_power = 30

// Ghost Chili
/obj/item/seeds/chili/ghost
	name = "Пачка семян призрачного чили"
	desc = "Эти семена вырастают в перец чили, который считается самым острым в этой галактике."
	icon_state = "seed-chilighost"
	species = "chilighost"
	plantname = "Ghost Chili Plants"
	product = /obj/item/food/grown/ghost_chili
	endurance = 10
	maturation = 10
	production = 10
	yield = 3
	rarity = 20
	genes = list(/datum/plant_gene/trait/chem_heating)
	mutatelist = list()
	reagents_add = list(/datum/reagent/consumable/condensedcapsaicin = 0.3, /datum/reagent/consumable/capsaicin = 0.55, /datum/reagent/consumable/nutriment = 0.04)
	graft_gene = /datum/plant_gene/trait/chem_heating

/obj/item/food/grown/ghost_chili
	seed = /obj/item/seeds/chili/ghost
	name = "призрачный чили"
	desc = "Кажется, он немного вибрирует"
	icon_state = "ghostchilipepper"
	var/mob/living/carbon/human/held_mob
	bite_consumption_mod = 4
	foodtypes = FRUIT
	wine_power = 50

/obj/item/food/grown/ghost_chili/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if( ismob(loc) )
		held_mob = loc
		START_PROCESSING(SSobj, src)

/obj/item/food/grown/ghost_chili/process(delta_time)
	if(held_mob && loc == held_mob)
		if(held_mob.is_holding(src))
			if(istype(held_mob) && held_mob.gloves)
				return
			held_mob.adjust_bodytemperature(7.5 * TEMPERATURE_DAMAGE_COEFFICIENT * delta_time)
			if(DT_PROB(5, delta_time))
				to_chat(held_mob, span_warning("Моя рука, держащая [src], обожглась!"))
	else
		held_mob = null
		..()
/obj/item/seeds/chili/bell_pepper
	name = "pack of bell pepper seeds"
	desc = "These seeds grow into bell pepper plants. MILD! MILD! MILD!"
	icon_state = "seed-bell-pepper"
	species = "bellpepper"
	plantname = "Bell Pepper Plants"
	product = /obj/item/food/grown/bell_pepper
	endurance = 10
	maturation = 10
	production = 10
	yield = 3
	rarity = 20
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.08, /datum/reagent/consumable/nutriment = 0.04)

/obj/item/food/grown/bell_pepper
	seed = /obj/item/seeds/chili/bell_pepper
	name = "bell pepper"
	desc = "A big mild pepper that's good for many things."
	icon_state = "bell_pepper"
	foodtypes = FRUIT

/obj/item/food/grown/bell_pepper/MakeBakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/roasted_bell_pepper, rand(15 SECONDS, 35 SECONDS), TRUE, TRUE)
