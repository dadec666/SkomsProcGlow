local _, ns = ...

-- Хелпер для получения локализованного имени спелла по ID с сохранением fallback-строки
local function Spell(spellID, fallback)
	local name = GetSpellInfo(spellID)
	return name or fallback
end

-- Default rules per class.
--   ability  the spell on the button (a macro counts when its #showtooltip spell is this one)
--   trigger  aura    = a buff on you (buff, stacks)
--            debuff  = a debuff of yours on the target (buff)
--            health  = the target's health is below `threshold` percent
--            power   = your rage / energy / mana / runic power is above `threshold`
--            usable  = the game says the spell is usable right now (Overpower, Revenge, Victory Rush, Kill Shot ...)
--   glow     none, border, pixel, shine, button, proc
ns.DefaultRules = {
	WARRIOR = {
		{ id = "WAR_EXE_SD",  ability = Spell(5308, "Execute"),            trigger = "aura",   buff = Spell(52437, "Sudden Death"),    glow = "proc" },
		{ id = "WAR_EXE_HP",  ability = Spell(5308, "Execute"),            trigger = "health", threshold = 20,                         glow = "button" },
		{ id = "WAR_OP",      ability = Spell(7384, "Overpower"),          trigger = "usable",                                         glow = "proc" },
		{ id = "WAR_OP_TFB",  ability = Spell(7384, "Overpower"),          trigger = "aura",   buff = Spell(60503, "Taste for Blood"), glow = "proc" },
		{ id = "WAR_REV",     ability = Spell(6572, "Revenge"),            trigger = "usable",                                         glow = "proc" },
		{ id = "WAR_VR",      ability = Spell(34428, "Victory Rush"),      trigger = "usable",                                         glow = "proc" },
		{ id = "WAR_SLAM",    ability = Spell(1464, "Slam"),               trigger = "aura",   buff = Spell(46916, "Slam!"),           glow = "proc" },
		{ id = "WAR_SS",      ability = Spell(23922, "Shield Slam"),       trigger = "aura",   buff = Spell(50227, "Sword and Board"), glow = "proc" },
		{ id = "WAR_HS",      ability = Spell(78, "Heroic Strike"),        trigger = "power",  threshold = 50,                         glow = "button" },
		{ id = "WAR_CLV",     ability = Spell(845, "Cleave"),              trigger = "power",  threshold = 50,                         glow = "button", enabled = false },
	},
	PALADIN = {
		{ id = "PAL_HOW",     ability = Spell(24275, "Hammer of Wrath"),   trigger = "usable",                                         glow = "button" },
		{ id = "PAL_EXO",     ability = Spell(879, "Exorcism"),            trigger = "aura",   buff = Spell(59578, "The Art of War"),  glow = "proc" },
	},
	HUNTER = {
		{ id = "HUN_KS",      ability = Spell(53351, "Kill Shot"),         trigger = "usable",                                         glow = "button" },
		{ id = "HUN_ES",      ability = Spell(53301, "Explosive Shot"),    trigger = "aura",   buff = Spell(56453, "Lock and Load"),   glow = "proc" },
		{ id = "HUN_AS",      ability = Spell(3044, "Arcane Shot"),        trigger = "aura",   buff = Spell(56453, "Lock and Load"),   glow = "proc" },
		{ id = "HUN_MB",      ability = Spell(1495, "Mongoose Bite"),      trigger = "usable",                                         glow = "proc" },
		{ id = "HUN_CA",      ability = Spell(19306, "Counterattack"),     trigger = "usable",                                         glow = "proc" },
	},
	ROGUE = {
		{ id = "ROG_RIP",     ability = Spell(14251, "Riposte"),           trigger = "usable",                                         glow = "proc" },
	},
	PRIEST = {
		{ id = "PRI_FH",      ability = Spell(2061, "Flash Heal"),         trigger = "aura",   buff = Spell(33151, "Surge of Light"),  glow = "proc" },
		{ id = "PRI_SWD",     ability = Spell(32379, "Shadow Word: Death"), trigger = "health", threshold = 35,                        glow = "button", enabled = false },
	},
	MAGE = {
		{ id = "MAG_PYRO",    ability = Spell(11366, "Pyroblast"),         trigger = "aura",   buff = Spell(48108, "Hot Streak"),      glow = "proc" },
		{ id = "MAG_AM",      ability = Spell(5143, "Arcane Missiles"),    trigger = "aura",   buff = Spell(44401, "Missile Barrage"), glow = "proc" },
		{ id = "MAG_FB",      ability = Spell(133, "Fireball"),            trigger = "aura",   buff = Spell(57761, "Brain Freeze"),    glow = "proc" },
		{ id = "MAG_FFB",     ability = Spell(44614, "Frostfire Bolt"),    trigger = "aura",   buff = Spell(57761, "Brain Freeze"),    glow = "proc" },
		{ id = "MAG_DF",      ability = Spell(44572, "Deep Freeze"),       trigger = "aura",   buff = Spell(44544, "Fingers of Frost"), glow = "proc" },
		{ id = "MAG_IL",      ability = Spell(30455, "Ice Lance"),         trigger = "aura",   buff = Spell(44544, "Fingers of Frost"), glow = "proc" },
	},
	WARLOCK = {
		{ id = "WLK_SB",      ability = Spell(686, "Shadow Bolt"),         trigger = "aura",   buff = Spell(17941, "Shadow Trance"),   glow = "proc" },
		{ id = "WLK_SB_BL",   ability = Spell(686, "Shadow Bolt"),         trigger = "aura",   buff = Spell(34939, "Backlash"),        glow = "proc" },
		{ id = "WLK_INC_BL",  ability = Spell(29722, "Incinerate"),        trigger = "aura",   buff = Spell(34939, "Backlash"),        glow = "proc" },
		{ id = "WLK_SF",      ability = Spell(6353, "Soul Fire"),          trigger = "aura",   buff = Spell(63167, "Decimation"),      glow = "proc" },
		{ id = "WLK_INC",     ability = Spell(29722, "Incinerate"),        trigger = "aura",   buff = Spell(71165, "Molten Core"),     glow = "proc" },
		{ id = "WLK_DS",      ability = Spell(1120, "Drain Soul"),         trigger = "health", threshold = 25,                         glow = "button" },
	},
	DRUID = {
		{ id = "DRU_SF",      ability = Spell(2912, "Starfire"),           trigger = "aura",   buff = Spell(48518, "Eclipse (Lunar)"), glow = "proc" },
		{ id = "DRU_WR",      ability = Spell(5176, "Wrath"),              trigger = "aura",   buff = Spell(48517, "Eclipse (Solar)"), glow = "proc" },
		{ id = "DRU_HT",      ability = Spell(5185, "Healing Touch"),      trigger = "aura",   buff = Spell(69369, "Predator's Swiftness"), glow = "proc" },
		{ id = "DRU_RG",      ability = Spell(8936, "Regrowth"),           trigger = "aura",   buff = Spell(69369, "Predator's Swiftness"), glow = "proc" },
		{ id = "DRU_NO",      ability = Spell(50464, "Nourish"),           trigger = "aura",   buff = Spell(69369, "Predator's Swiftness"), glow = "proc" },
	},
	SHAMAN = {
		{ id = "SHA_LB",      ability = Spell(403, "Lightning Bolt"),      trigger = "aura",   buff = Spell(53817, "Maelstrom Weapon"), stacks = 5, glow = "proc" },
		{ id = "SHA_CL",      ability = Spell(421, "Chain Lightning"),     trigger = "aura",   buff = Spell(53817, "Maelstrom Weapon"), stacks = 5, glow = "proc" },
		{ id = "SHA_HW",      ability = Spell(331, "Healing Wave"),        trigger = "aura",   buff = Spell(53817, "Maelstrom Weapon"), stacks = 5, glow = "proc" },
		{ id = "SHA_LHW",     ability = Spell(8004, "Lesser Healing Wave"), trigger = "aura",  buff = Spell(53817, "Maelstrom Weapon"), stacks = 5, glow = "proc" },
		{ id = "SHA_CH",      ability = Spell(1064, "Chain Heal"),         trigger = "aura",   buff = Spell(53817, "Maelstrom Weapon"), stacks = 5, glow = "proc" },
		{ id = "SHA_HEX",     ability = Spell(51514, "Hex"),               trigger = "aura",   buff = Spell(53817, "Maelstrom Weapon"), stacks = 5, glow = "proc" },
		{ id = "SHA_LVB",     ability = Spell(51505, "Lava Burst"),        trigger = "debuff", buff = Spell(8050, "Flame Shock"),      glow = "proc" },
	},
	DEATHKNIGHT = {
		{ id = "DK_HB",       ability = Spell(49184, "Howling Blast"),     trigger = "aura",   buff = Spell(59052, "Freezing Fog"),    glow = "proc" }, -- Rime дает бафф Freezing Fog (Иней)
		{ id = "DK_OBL",      ability = Spell(49020, "Obliterate"),        trigger = "aura",   buff = Spell(51124, "Killing Machine"), glow = "proc" },
		{ id = "DK_FS",       ability = Spell(49143, "Frost Strike"),      trigger = "aura",   buff = Spell(51124, "Killing Machine"), glow = "proc" },
		{ id = "DK_DC",       ability = Spell(47541, "Death Coil"),        trigger = "aura",   buff = Spell(49530, "Sudden Doom"),     glow = "proc" },
	},
}
