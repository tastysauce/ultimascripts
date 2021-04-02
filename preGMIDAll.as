@clearjournal
unsetalias 'bagtosort'
unsetalias 'stufftosell'
unsetalias 'stufftokeep'
unsetalias 'thingtoidforever'

if not @findobject 'thingtoidforever'
  headmsg 'Select thing to train on' '2124'
  promptalias 'thingtoidforever'
endif
pause 700

if not @findobject 'bagtosort'
  headmsg 'Select From Bag' '2124'
  promptalias 'bagtosort'
endif
pause 700

if not @findobject 'stufftosell'
  headmsg 'Select Junk Bag' '38'
  promptalias 'stufftosell'
endif
pause 700

if not @findobject 'stufftokeep'
  headmsg 'Select Keeper Bag' '58'
  promptalias 'stufftokeep'
endif
pause 700

// !! Static Data
if not listexists 'ItemTypes'
  createlist 'ItemTypes'
endif
useobject 'bagtosort'
useobject 'stufftosell'
useobject 'stufftokeep'
clearlist 'ItemTypes'

// Spellbooks
@pushlist 'ItemTypes' 0xefa // Magic spellbook
// Instruments
@pushlist 'ItemTypes' 0xe9c // Drums
@pushlist 'ItemTypes' 0xeb3 // Lute
@pushlist 'ItemTypes' 0xeb2 // Harp
@pushlist 'ItemTypes' 0xe9e // Tambourine
// Wands
@pushlist 'ItemTypes' 0xdf2 // Magic wand
@pushlist 'ItemTypes' 0xdf3 // Another wand
@pushlist 'ItemTypes' 0xdf4 // And another wand
@pushlist 'ItemTypes' 0xdf5 // And another wand
//Shields
@pushlist 'ItemTypes' 0x1b72 //BronzeShields
@pushlist 'ItemTypes' 0x1b73 //Buckler
@pushlist 'ItemTypes' 0x1b7b //MetalShield
@pushlist 'ItemTypes' 0x1b74 //Metal Kite Shield
@pushlist 'ItemTypes' 0x1b79 //Tear Kite Shield
@pushlist 'ItemTypes' 0x1b7a //WoodenShield
@pushlist 'ItemTypes' 0x1b77 //HeaterShield
//Bone Armor
@pushlist 'ItemTypes' 0x1451 //Bone Helmet
@pushlist 'ItemTypes' 0x1454 //Bone Armor
@pushlist 'ItemTypes' 0x1457 //Bone Leggings
@pushlist 'ItemTypes' 0x1453 //Bone Arms
@pushlist 'ItemTypes' 0x1455 //Bone Gloves 4/2/21
//Platemail
@pushlist 'ItemTypes' 0x1409 //Close Helmet
@pushlist 'ItemTypes' 0x1417 //Platemail Arms
@pushlist 'ItemTypes' 0x141a //Platemail Legs
@pushlist 'ItemTypes' 0x1412 //Plate Helm
@pushlist 'ItemTypes' 0x1413 //Plate Gorget
@pushlist 'ItemTypes' 0x1414 //Platemail Gloves
@pushlist 'ItemTypes' 0x1416 //Plate Chest
@pushlist 'ItemTypes' 0x1c09 //Plate skirt
@pushlist 'ItemTypes' 0x140a //Helmet
@pushlist 'ItemTypes' 0x140c //Bascinet
@pushlist 'ItemTypes' 0x140f //Norse Helm
//Chainmail
@pushlist 'ItemTypes' 0x13c0 //Chainmail Coif
@pushlist 'ItemTypes' 0x13c3 //Chainmail Leggings
@pushlist 'ItemTypes' 0x13c4 //Chainmail Tunic
@pushlist 'ItemTypes' 0x13ef //Chainmail Arms
@pushlist 'ItemTypes' 0x13f2 //Chainmail Gloves
//Ringmail
@pushlist 'ItemTypes' 0x13ee //Ringmail Sleeves
@pushlist 'ItemTypes' 0x13eb //Ringmail Gloves
@pushlist 'ItemTypes' 0x13ec //Ringmail Tunic
@pushlist 'ItemTypes' 0x13f1 //Ringmail Leggings
@pushlist 'ItemTypes' 0x140b //Ringmail Helm
//Studded
@pushlist 'ItemTypes' 0x13e1 //Studded Leggings
@pushlist 'ItemTypes' 0x13e2 //Studded Tunic
@pushlist 'ItemTypes' 0x13e3 //Studded Gloves
@pushlist 'ItemTypes' 0x13d6 //Studded Gorget
@pushlist 'ItemTypes' 0x13d4 //Studded Sleeves
//Leather
@pushlist 'ItemTypes' 0x13ce //Leather Gloves
@pushlist 'ItemTypes' 0x13cd //Leather Sleeves
@pushlist 'ItemTypes' 0x13c5 //Leather arms
@pushlist 'ItemTypes' 0x13d3 //Leather Tunic
@pushlist 'ItemTypes' 0x13d2 //Leather Pants
@pushlist 'ItemTypes' 0x13c7 //Leather Gorget
@pushlist 'ItemTypes' 0x1dba //Leather Cap
//Female Armor
@pushlist 'ItemTypes' 0x1c04 //Female Plate
@pushlist 'ItemTypes' 0x1c0c //Female Studded Bustier
@pushlist 'ItemTypes' 0x1c02 //Female Studded Armor
@pushlist 'ItemTypes' 0x1c00 //Female Leather Shorts
@pushlist 'ItemTypes' 0x1c08 //Female Leather Skirt
@pushlist 'ItemTypes' 0x1c06 //Female Leather Armor
@pushlist 'ItemTypes' 0x1c0b //Female Leather Bustier 4/2/21
//Fencing
@pushlist 'ItemTypes' 0xf62  //Spear
@pushlist 'ItemTypes' 0x1403 //Short Spear
@pushlist 'ItemTypes' 0xe87  //Pitchfork
@pushlist 'ItemTypes' 0x1405 //Warfork
@pushlist 'ItemTypes' 0x1401 //Kryss
@pushlist 'ItemTypes' 0xf52  //Dagger
//Macing
@pushlist 'ItemTypes' 0x13b0 //War axe
@pushlist 'ItemTypes' 0xdf0  //Black Staff
@pushlist 'ItemTypes' 0x1439 //War Hammer
@pushlist 'ItemTypes' 0x1407 //War Mace
@pushlist 'ItemTypes' 0xe89  //Quarter Staff
@pushlist 'ItemTypes' 0x143d //Hammer Pick
@pushlist 'ItemTypes' 0x13b4 //Club
@pushlist 'ItemTypes' 0xe81  //Shepherds Crook
@pushlist 'ItemTypes' 0x13f8 //Gnarled Staff
@pushlist 'ItemTypes' 0xf5c  //Mace
@pushlist 'ItemTypes' 0x143b //Maul
//Swords
@pushlist 'ItemTypes' 0x13b9 //Viking Sword
@pushlist 'ItemTypes' 0xf61 //Longsword
@pushlist 'ItemTypes' 0x1441 //Cutlass
@pushlist 'ItemTypes' 0x13b6 //Scimitar
@pushlist 'ItemTypes' 0xec4  //Skinning Knife
@pushlist 'ItemTypes' 0x13f6 //Butcher Knife
@pushlist 'ItemTypes' 0xf5e  //Broadsword
@pushlist 'ItemTypes' 0x13ff //Katana
@pushlist 'ItemTypes' 0xec3  //Cleaver
//Axes
@pushlist 'ItemTypes' 0xf43 //Hatchet
@pushlist 'ItemTypes' 0xf45 //Executioner's Axe
@pushlist 'ItemTypes' 0xf4d //Bardiche
@pushlist 'ItemTypes' 0xf4b  //Double Axe
@pushlist 'ItemTypes' 0x143e //Halberd
@pushlist 'ItemTypes' 0x13fb //Large Battle Axe
@pushlist 'ItemTypes' 0x1443 //Two Handed Axe
@pushlist 'ItemTypes' 0xf47  //Battle Axe
@pushlist 'ItemTypes' 0xf49  //Axe
@pushlist 'ItemTypes' 0xe85  //Pickaxe
@pushlist 'ItemTypes' 0xe86  //Pickaxe
//Bows
@pushlist 'ItemTypes' 0x13fd //HeavyXbow
@pushlist 'ItemTypes' 0xf50  //Xbow
@pushlist 'ItemTypes' 0x13b2 //bow

// Look at every item type
for 0 to 'ItemTypes'

    // Process all items found of current ItemType
    while @findtype 'ItemTypes[]' 'any' 'bagtosort'

        @clearjournal

        // Id the item using
        pause 2000
        useskill 'Item Identification'
        waitfortarget 15000
        target! found
        pause 2000

        // REMOVE THIS ONCE GM
        // Check if we succeeded
        pause 800
        if injournal 'You are not certain.' 'system' 
            continue
        elseif injournal 'That item is already identified.' 'system'
            headmsg 'Already identified this'
            moveitem found 'stufftosell'
            pause 700
        else 
            headmsg 'Succeeded'
            moveitem found 'stufftosell'
            pause 700
        endif

        pause 1000
        if @injournal 'vanquishing' 'system'
          moveitem found 'stufftokeep'
          headmsg 'vanquishing' '2213'
          @clearjournal
        elseif @injournal 'power' 'system'
          moveitem found 'stufftokeep'
          headmsg 'power' '2213'
          @clearjournal
        elseif @injournal 'force' 'system'
          moveitem found 'stufftokeep'
          headmsg 'force' '2213'
          @clearjournal
        elseif @injournal 'might' 'system'
          moveitem found 'stufftokeep'
          headmsg 'force' '2213'
          @clearjournal
        elseif @injournal 'exceedingly' 'system'
          moveitem found 'stufftokeep'
          headmsg 'exceedingly accurate' '2213'
          @clearjournal
        elseif @injournal 'supremely' 'system'
          moveitem found 'stufftokeep'
          headmsg 'supremely accurate' '2213'
          @clearjournal
        elseif @injournal 'invulnerability' 'system'
          moveitem found 'stufftokeep'
          headmsg 'invulnerability' '2213'
          @clearjournal
        elseif @injournal 'hardening' 'system'
          moveitem found 'stufftokeep'
          headmsg 'hardening' '2213'
          @clearjournal
        elseif @injournal 'fortification' 'system'
          moveitem found 'stufftokeep'
          headmsg 'fortification' '2213'
          @clearjournal
        elseif @injournal 'slaying' 'system'
          moveitem found 'stufftokeep'
          headmsg 'slaying' '2213'
          @clearjournal
        elseif @injournal 'ponderous' 'system'
          moveitem found 'stufftokeep'
          headmsg 'ponderous' '2213'
          @clearjournal
        elseif @injournal 'prodigious' 'system'
          moveitem found 'stufftokeep'
          headmsg 'prodigious' '2213'
          @clearjournal
        elseif @injournal 'troubador' 'system'
          moveitem found 'stufftokeep'
          headmsg 'troubador' '2213'
          @clearjournal
        elseif @injournal 'balladeer' 'system'
          moveitem found 'stufftokeep'
          headmsg 'balladeer' '2213'
          @clearjournal
        elseif @injournal 'enticing' 'system'
          moveitem found 'stufftokeep'
          headmsg 'enticing' '2213'
          @clearjournal
        endif

        @clearjournal

    endwhile

endfor

headmsg 'DONE'
// REMOVE ONCE GM
while skill 'Item Identification' < 100
    useskill 'Item Identification'
    waitfortarget 15000
    target! 'thingtoidforever'
    pause 2000
endwhile

