/datum/blobstrain/reagent/replicating_foam
	name = "Воспроизводящая пена"
	description = "будет наносить средний грубый урон и иногда снова расширяться при расширении."
	shortdesc = "нанесет средний грубый урон."
	effectdesc = "также будет расширяться при атаке ожоговым уроном, но получает больше грубого урона."
	color = "#7B5A57"
	complementary_color = "#57787B"
	analyzerdescdamage = "Наносит средний грубый урон."
	analyzerdesceffect = "Расширяется при атаке ожоговым повреждением, иногда снова расширяется при расширении и уязвим для грубого урона."
	reagent = /datum/reagent/blob/replicating_foam


/datum/blobstrain/reagent/replicating_foam/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if(damage_type == BRUTE)
		damage = damage * 2
	else if(damage_type == BURN && damage > 0 && B.obj_integrity - damage > 0 && prob(60))
		var/obj/structure/blob/newB = B.expand(null, null, 0)
		if(newB)
			newB.obj_integrity = B.obj_integrity - damage
			newB.update_icon()
	return ..()


/datum/blobstrain/reagent/replicating_foam/expand_reaction(obj/structure/blob/B, obj/structure/blob/newB, turf/T, mob/camera/blob/O)
	if(prob(30))
		newB.expand(null, null, 0) //do it again!

/datum/reagent/blob/replicating_foam
	name = "Воспроизводящая пена"
	enname = "Replicating Foam"
	taste_description = "дублирование"
	color = "#7B5A57"

/datum/reagent/blob/replicating_foam/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/camera/blob/overmind)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	exposed_mob.apply_damage(0.7*reac_volume, BRUTE, wound_bonus=CANT_WOUND)
