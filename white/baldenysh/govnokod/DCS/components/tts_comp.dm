/datum/component/tts
	var/mob/owner

	var/creation = 0 //create tts on hear
	var/tts_speaker

	var/maxchars = 140 //sasai kudosai

	var/assigned_channel
	var/frequency = 1

/datum/component/tts/Initialize(mapload)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	owner = parent
	assigned_channel = open_sound_channel_for_tts()
	. = ..()

/datum/component/tts/RegisterWithParent()
	RegisterSignal(owner, COMSIG_MOB_SAY, .proc/handle_speech)

/datum/component/tts/UnregisterFromParent()
	UnregisterSignal(owner, COMSIG_MOB_SAY)

/datum/component/tts/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	if(GLOB.tts || creation)
		INVOKE_ASYNC(src, .proc/prikolize, speech_args[SPEECH_MESSAGE])

/datum/component/tts/proc/prikolize(msg)
	msg = trim(msg, maxchars)
	if(tts_speaker)
		owner.tts(msg, tts_speaker, freq = frequency)
