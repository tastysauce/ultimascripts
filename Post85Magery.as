// This script requires a bit of set up. Should be run when you are 85+ magery
//
// You require the following:
// 1. The following counters for reagents set up in UOSteam:
//    sulfur, blackpearl, bloodmoss, mandrake, silk, nightshade

if skill 'magery' < 85
  sysmsg 'this macro is for more powerful magery people'
  stop
endif

if not findalias regbag
  sysmsg 'Select your reagent bag'
  promptalias regbag
endif

// Sanity check for rereg organizer
sysmsg 'Grabbing starting reagents'
useobject regbag
pause 751
organizer rereg

while organizing
  pause 1001
endwhile

// Main loop
while not dead
  // We assume we're in a house and next to the reagent bag

  // 1. Magery gains
  clearjournal
  pause 650

  // cast earth ele for gainz
  cast 'Summon Earth Elemental'
  pause 6100
  msg 'an earth elemental release'
  pause 1000

  // 2. Mana check
  // Don't med if we're below threshold for healing
  // We will remove hat on next runloop and start to med
  // This makes sure we med up while our healer heals us
  if mana < 50
    useskill 'meditation'
    while mana < 50
    endwhile
    pause 600
  endif

  // 3. Reagent Check
  // Check Earth Elemental Reagents
  sysmsg 'Checking earth elemental reagents'
  if counter 'silk' == 0
    sysmsg 'Restocking'
    useobject regbag
    pause 751
    organizer rereg
    while organizing
      pause 1001
    endwhile
  elseif counter 'bloodmoss' == 0
    useobject regbag
    pause 751
    organizer rereg
    while organizing
      pause 1001
    endwhile
  elseif counter 'mandrake' == 0
    useobject regbag
    pause 751
    organizer rereg
    while organizing
      pause 1001
    endwhile
  endif

endwhile
