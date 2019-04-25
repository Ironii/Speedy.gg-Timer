local addonName, ns = ...

local dungeons = {
	-- Classic
	[409] = { -- Molten Core - 741
		{ejID = 1519, eID = 663}, -- Lucifron
		{ejID = 1520, eID = 664}, -- Magmadar
		{ejID = 1521, eID = 665}, -- Gehennas
		{ejID = 1522, eID = 666}, -- Garr
		{ejID = 1523, eID = 667}, -- Shazzrah
		{ejID = 1524, eID = 668}, -- Baron Geddon
		{ejID = 1525, eID = 669}, -- Sulfuron Harbinger
		{ejID = 1526, eID = 670}, -- Golemagg the Incinerator
		{ejID = 1527, eID = 671}, -- Majordomo Executus
		{ejID = 1528, eID = 672}, -- Ragnaros
	},
	[469] = { -- Blackwing Lair - 742
		{ejID = 1529, eID = 610}, -- Razorgore the Untamed
		{ejID = 1530, eID = 611}, -- Vaelastrasz the Corrupt
		{ejID = 1531, eID = 612}, -- Broodlord Lashlayer
		{ejID = 1532, eID = 613}, -- Firemaw
		{ejID = 1533, eID = 614}, -- Ebonroc
		{ejID = 1534, eID = 615}, -- Flamegor
		{ejID = 1535, eID = 616}, -- Chromaggus
		{ejID = 1536, eID = 617}, -- Nefarian
	},
	[509] = { -- Ruins of Ahn'Qiraj - 743
		{ejID = 1537, eID = 718}, -- Kurinnaxx
		{ejID = 1538, eID = 719}, -- General Rajaxx
		{ejID = 1539, eID = 720}, -- Moam
		{ejID = 1540, eID = 721}, -- Buru the Gorger
		{ejID = 1541, eID = 722}, -- Ayamiss the Hunter
		{ejID = 1542, eID = 723}, -- Ossirian the Unscarred
	},
	[531] = { -- Temple of Ahn'Qiraj - 744
		{ejID = 1543, eID = 709}, -- The Prophet Skeram
		{ejID = 1547, eID = 710}, -- Silithid Royalty
		{ejID = 1544, eID = 711}, -- Battleguard Sartura
		{ejID = 1548, eID = 712}, -- Fankriss the Unyielding
		{ejID = 1548, eID = 713}, -- Viscidus
		{ejID = 1546, eID = 714}, -- Princess Huhuran
		{ejID = 1549, eID = 715}, -- The Twin Emperors
		{ejID = 1550, eID = 716}, -- Ouro
		{ejID = 1551, eID = 717}, -- C'thun
	},

	-- TBC
	[565] = { -- Gruul's Lair - 746
		{ejID = 1564, eID = 649}, -- High King Maulgar
		{ejID = 1565, eID = 717}, -- Gruul the Dragonkiller
	},
	[544] = { -- Magtheridon's Lair - 747
		{ejID = 1566, eID = 723}, -- Magtheridon
	},
	[532] = { -- Karazhan - 745
		--{ejID = 1552, eID = 0}, -- Servant's Quarters
		{ejID = 1553, eID = 652}, -- Attumen the Huntsman
		{ejID = 1554, eID = 653}, -- Moroes
		{ejID = 1555, eID = 654}, -- Maiden of Virtue
		{ejID = 1556, eID = 655}, -- Opera Hall
		{ejID = 1557, eID = 656}, -- The Curator
		{ejID = 1560, eID = 657}, -- Terestian Illhoof
		{ejID = 1559, eID = 658}, -- Shade of Aran
		{ejID = 1561, eID = 0}, -- Netherspite
		{ejID = 1764, eID = 660}, -- Chess Event
		{ejID = 1563, eID = 661}, -- Prince Malchezaar
	},
	[548] = { -- Serpentshrine Cavern - 748
		{ejID = 1567, eID = 623}, -- Hydross the Unstable
		{ejID = 1568, eID = 624}, -- The Lurker Below
		{ejID = 1569, eID = 625}, -- Leotheras the Blind
		{ejID = 1570, eID = 626}, -- Fathom-Lord Karathress
		{ejID = 1571, eID = 627}, -- Morogrim Tidewalker
		{ejID = 1572, eID = 628}, -- Lady Vashj
	},
	[550] = { -- The Eye - 749
		{ejID = 1573, eID = 730}, -- Al'ar
		{ejID = 1574, eID = 731}, -- Void Reaver
		{ejID = 1575, eID = 732}, -- High Astromancer Solarian
		{ejID = 1576, eID = 733}, -- Kael'thas Sunstrider
	},
	[534] = { -- The Battle for Mount Hyjal - 750
		{ejID = 1577, eID = 618}, -- Rage Winterchill
		{ejID = 1578, eID = 619}, -- Anetheron
		{ejID = 1579, eID = 620}, -- Kaz'rogal
		{ejID = 1580, eID = 621}, -- Azgalor
		{ejID = 1581, eID = 622}, -- Archimonde
	},
	[564] = { -- The Black Temple - 751
		{ejID = 1582, eID = 601}, -- High Warlord Naj'entus
		{ejID = 1583, eID = 602}, -- Supremus
		{ejID = 1584, eID = 603}, -- Shade of Akama
		{ejID = 1585, eID = 604}, -- Teron Gorefiend
		{ejID = 1586, eID = 605}, -- Gurtogg Bloodboil
		{ejID = 1587, eID = 606}, -- Reliquary of Souls
		{ejID = 1588, eID = 607}, -- Mother Shahraz
		{ejID = 1589, eID = 608}, -- The Illidari Council
		{ejID = 1590, eID = 609}, -- Illidan Stormrage
	},
	[580] = { -- Sunwell Plateau - 752
		{ejID = 1591, eID = 724}, -- Kalecgos
		{ejID = 1592, eID = 725}, -- Brutallus
		{ejID = 1593, eID = 726}, -- Felmyst
		{ejID = 1594, eID = 727}, -- The Eredar Twins
		{ejID = 1595, eID = 728}, -- M'uru
		{ejID = 1596, eID = 729}, -- Kil'jaeden
	},

	-- Wotlk
	[624] = { -- Vault of Archavon - 753
		{ejID = 1600, eID = 1129}, -- Toravon the Ice Watcher
		{ejID = 1597, eID = 1126}, -- Archavon the Stone Watcher
		{ejID = 1598, eID = 1127}, -- Emalon the Storm Watcher
		{ejID = 1599, eID = 1128}, -- Koralon the Flame Watcher
	},
	[533] = { -- Naxxramas - 754
		{ejID = 1601, eID = 1107}, -- Anub'Rekhan
		{ejID = 1602, eID = 1110}, -- Grand Widow Faerlina
		{ejID = 1603, eID = 1116}, -- Maexxna
		{ejID = 1604, eID = 1117}, -- Noth the Plaguebringer
		{ejID = 1605, eID = 1112}, -- Heigan the Unclean
		{ejID = 1606, eID = 1115}, -- Loatheb
		{ejID = 1607, eID = 1113}, -- Instructor Razuvious
		{ejID = 1608, eID = 1109}, -- Gothik the Harvester
		{ejID = 1609, eID = 1121}, -- The Four Horsemen
		{ejID = 1610, eID = 1118}, -- Patchwerk
		{ejID = 1611, eID = 1111}, -- Grobbulus
		{ejID = 1612, eID = 1108}, -- Gluth
		{ejID = 1613, eID = 1120}, -- Thaddius
		{ejID = 1614, eID = 1119}, -- Sapphiron
		{ejID = 1615, eID = 1114}, -- Kel'Thuzad
	},
	[616] = { -- Malygos - 756
		{ejID = 1617, eID = 1094}, -- Malygos
	},
	[615] = { -- The Obsidian Sanctum - 755
		{ejID = 1616, eID = 1090}, -- Sartharion
	},
	[649] = { -- Trial of the Crusader - 757
		{ejID = 1618, eID = 1088}, -- The Northrend Beasts
		{ejID = 1619, eID = 1087}, -- Lord Jaraxxus
		{ejID = 1620, eID = 1086}, -- Champions of the Alliance
		{ejID = 1622, eID = 1089}, -- Twin Val'kyr
		{ejID = 1623, eID = 1085}, -- Anub'arak
	},
	[249] = { -- Onyxia's Lair - 760
		{ejID = 1651, eID = 1084}, -- Onyxia
	},
	[603] = { -- Ulduar - 759
		{ejID = 1637, eID = 1132}, -- Flame Leviathan
		{ejID = 1638, eID = 1136}, -- Ignis the Furnace Master
		{ejID = 1639, eID = 1139}, -- Razorscale
		{ejID = 1640, eID = 1142}, -- XT-002 Deconstructor
		{ejID = 1641, eID = 1140}, -- The Assembly of Iron
		{ejID = 1642, eID = 1137}, -- Kologarn
		{ejID = 1643, eID = 1131}, -- Auriaya
		{ejID = 1644, eID = 1135}, -- Hodir
		{ejID = 1645, eID = 1141}, -- Thorim
		{ejID = 1646, eID = 1133}, -- Freya
		{ejID = 1647, eID = 1138}, -- Mimiron
		{ejID = 1648, eID = 1134}, -- General Vezax
		{ejID = 1649, eID = 1143}, -- Yogg-Saron
		--{ejID = 1650, eID = 1130, specificDif = {[14] = true}, -- Algalon
	},
	[631] = { -- Icecrown Citadel - 758
		{ejID = 1624, eID = 1101}, -- Lord Marrowgar
		{ejID = 1625, eID = 1100}, -- Lady Deathwhisper
		{ejID = 1627, eID = 1099}, -- Icecrown Gunship Battle
		{ejID = 1628, eID = 1096}, -- Deathbringer Saurfang
		{ejID = 1632, eID = 1095}, -- Blood Prince Council
		{ejID = 1633, eID = 1103}, -- Blood-Queen Lana'thel
		{ejID = 1629, eID = 1097}, -- Festergut
		{ejID = 1630, eID = 1104}, -- Rotface
		{ejID = 1631, eID = 1102}, -- Professor Putricide
		{ejID = 1634, eID = 1098}, -- Valithria Dreamwalker
		{ejID = 1635, eID = 1105}, -- Sindragosa
		{ejID = 1636, eID = 1106}, -- The Lich King
	},
	[724] = { -- The Ruby Sanctum - 761
		{ejID = 1652, eID = 1150}, -- Halion
	},

	-- Cataclysm
	[757] = { -- Baradin Hold - 75
		{ejID = 140, eID = 1250}, -- Occu'thar
		{ejID = 339, eID = 1332}, -- Alizabal, Mistress of Hate
		{ejID = 139, eID = 1033}, -- Argaloth
	},
	[669] = { -- Blackwing Descent - 73
		{ejID = 169, eID = 1027}, -- Omnotron Defense System
		{ejID = 170, eID = 1024}, -- Magmaw
		{ejID = 173, eID = 1025}, -- Maloriak
		{ejID = 171, eID = 1022}, -- Atramedes
		{ejID = 172, eID = 1023}, -- Chimaeron
		{ejID = 174, eID = 1026}, -- Nefarian's End
	},
	[671] = { -- The Bastion of Twilight - 72
		{ejID = 156, eID = 1030}, -- Halfus Wyrmbreaker
		{ejID = 157, eID = 1032}, -- Theralion and Valiona
		{ejID = 158, eID = 1028}, -- Ascendant Council
		{ejID = 167, eID = 1029, npcID = 43324}, -- Cho'gall
		{ejID = 168, eID = 1083, specificDif = {[5] = true, [6] = true}, npcID = 45213}, -- Sinestra
	},
	[754] = { -- Throne of the Four Winds - 74
		{ejID = 154, eID = 1035}, -- The Conclave of Wind
		{ejID = 155, eID = 1034}, -- Al'Akir
	},
	[720] = { -- Firelands - 78
		{ejID = 195, eID = 1205}, -- Shannox
		{ejID = 192, eID = 1197}, -- Beth'tilac
		{ejID = 193, eID = 1204}, -- Lord Rhyolith
		{ejID = 194, eID = 1206}, -- Alysrazor
		{ejID = 196, eID = 1200}, -- Baleroc, the Gatekeeper
		{ejID = 197, eID = 1185}, -- Majordomo Staghelm
		{ejID = 198, eID = 1203}, -- Ragnaros
	},
	[967] = { -- Dragon Souls - 187
		{ejID = 311, eID = 1292}, -- Morchok
		{ejID = 324, eID = 1294}, -- Warlord Zon'ozz
		{ejID = 325, eID = 1295}, -- Yor'sahj the Unsleeping
		{ejID = 317, eID = 1296}, -- Hagara the Stormbinder
		{ejID = 331, eID = 1297}, -- Ultraxion
		{ejID = 332, eID = 1298}, -- Warmaster Blackhorn
		{ejID = 318, eID = 1291}, -- Spine of Deathwing
		{ejID = 333, eID = 1299}, -- Madness of Deathwing
	},

	-- MoP
	[1008] = { -- Mogu'shan Vaults - 317
		{ejID = 679, eID = 1395}, -- The Stone Guard
		{ejID = 689, eID = 1390}, -- Feng the Accursed
		{ejID = 682, eID = 1434}, -- Gara'jal the Spiritbinder
		{ejID = 687, eID = 1436}, -- The Spirit Kings
		{ejID = 726, eID = 1500}, -- Elegon
		{ejID = 677, eID = 1407}, -- Will of the Emperor
	},
	[1009] = { -- Heart of Fear - 330
		{ejID = 745, eID = 1507}, -- Imperial Vizier Zor'lok
		{ejID = 744, eID = 1504}, -- Blade Lord Ta'yak
		{ejID = 713, eID = 1463}, -- Garalon
		{ejID = 741, eID = 1498}, -- Wind Lord Mel'jarak
		{ejID = 737, eID = 1499}, -- Amber-Shaper Un'sok
		{ejID = 743, eID = 1501}, -- Grand Empress Shek'zeer
	},
	[996] = { -- Terrace of Endless Spring - 320
		{ejID = 683, eID = 1409}, -- Protectors of the Endless
		{ejID = 742, eID = 1505}, -- Tsulong
		{ejID = 729, eID = 1506}, -- Lei Shi
		{ejID = 709, eID = 1431}, -- Sha of Fear
	},
	[1098] = { -- Throne of Thunder - 362
		{ejID = 827, eID = 1577}, -- Jin'rokh the Breaker
		{ejID = 819, eID = 1575}, -- Horridon
		{ejID = 816, eID = 1570}, -- Council of Elders
		{ejID = 825, eID = 1565}, -- Tortos
		{ejID = 821, eID = 1578}, -- Megaera
		{ejID = 828, eID = 1573}, -- Ji-Kun
		{ejID = 818, eID = 1572}, -- Durumu the Forgotten
		{ejID = 820, eID = 1574}, -- Primordius
		{ejID = 824, eID = 1576}, -- Dark Animus
		{ejID = 817, eID = 1559}, -- Iron Qon
		{ejID = 829, eID = 1560}, -- Twin Consorts
		{ejID = 832, eID = 1579}, -- Lei Shen
		{ejID = 831, eID = 1581, specificDif = {[5] = true, [6] = true}}, -- Ra-den TODO re check eid
	},
	[1136] = { -- Siege of Orgrimmar - 369
		{ejID = 852, eID = 1602}, -- Immerseus
		{ejID = 849, eID = 1598}, -- The Fallen Protectors
		{ejID = 866, eID = 1624}, -- Norushen
		{ejID = 867, eID = 1604}, -- Sha of Pride
		{ejID = 868, eID = 1622}, -- Galakras
		{ejID = 864, eID = 1600}, -- Iron Juggernaut
		{ejID = 856, eID = 1606}, -- Kor'kron Dark Shaman
		{ejID = 850, eID = 1623}, -- General Nazgrim
		{ejID = 846, eID = 1595}, -- Malkorok
		{ejID = 870, eID = 1594}, -- Spoils of Pandaria
		{ejID = 851, eID = 1599}, -- Thok the Bloodthirsty
		{ejID = 865, eID = 1601}, -- Siegecrafter Blackfuse
		{ejID = 853, eID = 1593}, -- Paragons of the Klaxxi
		{ejID = 869, eID = 1623}, -- Garrosh Hellscream
	},

	-- WoD
	[1228] = { -- Highmaul - 477
		{ejID = 1128, eID = 1721}, -- Kargath Bladefist
		{ejID = 1195, eID = 1722}, -- Tectus
		{ejID = 1196, eID = 1720}, -- Brackenspore
		{ejID = 971, eID = 1706}, -- The Butcher
		{ejID = 1148, eID = 1719}, -- Twin Ogron
		{ejID = 1153, eID = 1723}, -- Ko'ragh
		{ejID = 1197, eID = 1705}, -- Imperator Mar'gok
	},
	[1205] = { -- Blackrock Foundry - 457
		{ejID = 1155, eID = 1693}, -- Hans'gar and Franzok
		{ejID = 1123, eID = 1689}, -- Flamebender Ka'graz
		{ejID = 1162, eID = 1713}, -- Kromog
		{ejID = 1122, eID = 1694}, -- Beastlord Darmac
		{ejID = 1147, eID = 1692}, -- Operator Thogar
		{ejID = 1203, eID = 1695}, -- The Iron Maidens
		{ejID = 1161, eID = 1691}, -- Gruul
		{ejID = 1202, eID = 1696}, -- Oregorger
		{ejID = 1154, eID = 1690}, -- The Blast Furnace
		{ejID = 959, eID = 1704}, -- Blackhand
	},
	[1448] = { -- Hellfire Citadel - 669
		{ejID = 1426, eID = 1778}, -- Hellfire Assault
		{ejID = 1425, eID = 1785}, -- Iron Reaver
		{ejID = 1392, eID = 1787}, -- Kormrok
		{ejID = 1432, eID = 1798}, -- Hellfire High Council
		{ejID = 1396, eID = 1786}, -- Kilrogg Deadeye
		{ejID = 1372, eID = 1783}, -- Gorefiend
		{ejID = 1433, eID = 1785}, -- Shadow-Lord Iskar
		{ejID = 1427, eID = 1794}, -- Socrethar the Eternal
		{ejID = 1394, eID = 1784}, -- Tyrant Velhari
		{ejID = 1447, eID = 1800}, -- Xhul'horac
		{ejID = 1391, eID = 1777}, -- Fel Lord Zakuun
		{ejID = 1395, eID = 1795}, -- Mannoroth
		{ejID = 1438, eID = 1799}, -- Archimonde
	},

	-- Legion
	[1520] = { -- The Emerald Nightmare - 768
		{ejID = 1703, eID = 1853}, -- Nythendra
		{ejID = 1667, eID = 1841}, -- Ursoc
		{ejID = 1744, eID = 1876}, -- Elerethe Renferal
		{ejID = 1738, eID = 1873}, -- Il'gynoth, Heart of Corruption
		{ejID = 1704, eID = 1854}, -- Dragons of Nightmare
		{ejID = 1750, eID = 1877}, -- Cenarius
		{ejID = 1726, eID = 1864}, -- Xavius
	},
	[1648] = { -- Trial of Valor - 861
		{ejID = 1819, eID = 1958}, -- Odyn
		{ejID = 1830, eID = 1962}, -- Guarm
		{ejID = 1829, eID = 2008}, -- Helya
	},
	[1530] = { -- The Nighthold - 786
		{ejID = 1706, eID = 1849}, -- Skorpyron
		{ejID = 1725, eID = 1865}, -- Chronomatic Anomaly
		{ejID = 1731, eID = 1862}, -- Trilliax
		{ejID = 1751, eID = 1871}, -- Spellblade Aluriel
		{ejID = 1713, eID = 1842}, -- Krosus
		{ejID = 1762, eID = 1862}, -- Tichondrius
		{ejID = 1732, eID = 1863}, -- Star Augur Etraeus
		{ejID = 1761, eID = 1886}, -- High Botanist Tel'arn
		{ejID = 1743, eID = 1872}, -- Grand Magistrix Elisande
		{ejID = 1737, eID = 1866}, -- Gul'dan
	},
	[1676] = { -- Tomb of Sargeras - 875
		{ejID = 1862, eID = 2032}, -- Goroth
		{ejID = 1867, eID = 2048}, -- Demonic Inquisition
		{ejID = 1856, eID = 2036}, -- Harjatan
		{ejID = 1861, eID = 2037}, -- Mistress Sassz'ine
		{ejID = 1903, eID = 2050}, -- Sisters of the Moon
		{ejID = 1896, eID = 2054}, -- The Desolate Host
		{ejID = 1897, eID = 2052}, -- Maiden of Vigilance
		{ejID = 1873, eID = 2038}, -- Fallen Avatar
		{ejID = 1898, eID = 2051}, -- Kil'jaeden
	},
	[1712] = { -- Antorus, the Burning Throne - 946
		{ejID = 1992, eID = 2076}, -- Garothi Worldbreaker
		{ejID = 1987, eID = 2074}, -- Felhounds of Sargeras
		{ejID = 1997, eID = 2070}, -- Antoran High Command
		{ejID = 2025, eID = 2075}, -- Eonar the Life-Binder
		{ejID = 1985, eID = 2064}, -- Portal Keeper Hasabel
		{ejID = 2009, eID = 2082}, -- Imonar the Soulhunter
		{ejID = 2004, eID = 2088}, -- Kin'garoth
		{ejID = 1983, eID = 2069}, -- Varimathras
		{ejID = 1986, eID = 2073}, -- The Coven of Shivarra
		{ejID = 1984, eID = 2063}, -- Aggramar
		{ejID = 2031, eID = 2092}, -- Argus the Unmaker
	},

	-- Bfa
	[1861] = { -- Uldir - 1031
		{ejID = 2168, eID = 2144}, -- Taloc
		{ejID = 2167, eID = 2141}, -- MOTHER
		{ejID = 2146, eID = 2128}, -- Fetid Devourer
		{ejID = 2166, eID = 2134}, -- Vectis
		{ejID = 2169, eID = 2136}, -- Zek'voz, Herald of N'zoth
		{ejID = 2195, eID = 2145}, -- Zul, Reborn
		{ejID = 2194, eID = 2135}, -- Mythrax the Unraveler
		{ejID = 2147, eID = 2122}, -- G'huun
	},
	[2070] = { -- Battle of Dazar'alor - 1176
		{ejID = 2333, eID = 2265}, -- Champion of the Light
		{ejID = 2325, eID = 0, factionSpecific = {["Horde"] = 2284, ["Alliance"] = 2263}}, -- Grong, the Jungle Lord
		{ejID = 2341, eID = 0, factionSpecific = {["Horde"] = 2266, ["Alliance"] = 2285}}, -- Jadefire Masters
		{ejID = 2342, eID = 2271}, -- Opulence
		{ejID = 2330, eID = 2268}, -- Conclave of the Chosen
		{ejID = 2335, eID = 2272}, -- King Rastakhan
		{ejID = 2334, eID = 2276}, -- High Tinker Mekkatorque
		{ejID = 2337, eID = 2280}, -- Stormwall Blockade
		{ejID = 2343, eID = 2281}, -- Lady Jaina Proudmoore
	},
	[2096] = { -- Crucible of Storms - 1177
		{ejID = 2328, eID = 2269}, -- The Restless Cabal
		{ejID = 2332, eID = 2273}, -- Uu'nat, Harbinger of the Void
	},
}
do
local _ins = table.insert
local faction = UnitFactionGroup('player')
	function ns:GetDungeonData(instanceID, difficultyID)
		if not dungeons[instanceID] then return end
		local t = {}
		for i = 1, #dungeons[instanceID] do
			local v = dungeons[instanceID][i]
			if not v.specificDif or v.specificDif[difficultyID] then
				local encounterName = EJ_GetEncounterInfo(v.ejID)
				_ins(t, {
					criteria = encounterName,
					eID = v.factionSpecific and v.factionSpecific[faction] or v.eID,
					dif = false,
					completeTime = nil,
					bestTime = ns:GetDiff(v.eID, 0, true, difficultyID, instanceID),
					npcID = v.npcID or nil
				})
			end
		end
		return #t > 0 and t or false
	end
end
StaticPopupDialogs["SPEEDYGG_WARNING"] = {
  text = "WARNING\nOne of the encounters in this instance is known to be buggy and we might not be able to track your progress.",
  button1 = OKAY,
  OnAccept = function()  end,
  timeout = 0,
  whileDead = true,
  preferredIndex = 3,
}
do
	local buggyDungeons = {}
	function ns:IsBuggyDungeon(id, dID)
	if (not id) or (not dID) or (not buggyDungeons[id]) or (not buggyDungeons[id][dID]) then return end
		ns:print("WARNING - One of the encounters in this instance is known to be buggy and we might not be able to track your progress.")
		StaticPopup_Show("SPEEDYGG_WARNING")
	end
end