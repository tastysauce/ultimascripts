// Person we will making sure isn't dying
if not findalias 'friend1'
  sysmsg 'Select friend'
  promptalias 'friend1'
endif

if not findalias walrusRune
  sysmsg 'Select the rune to your walrus'
  promptalias walrusRune
endif

if not findalias reagentLocationRune
  sysmsg 'Select the rune to your restock location'
  promptalias reagentLocationRune
endif

if not findalias banker
  sysmsg 'Select your banker'
  promptalias banker
endif

if not findalias regbag
  sysmsg 'Select your reagent bag'
  promptalias regbag
endif

// Sanity check for banker
waitforcontext banker 1 15000
pause 751

// Sanity check for rereg organizer
sysmsg 'Grabbing starting reagents'
useobject regbag
pause 751
organizer rereg
while organizing
  pause 1001
endwhile

// Check Recall reagents
sysmsg 'Checking recall reagents'
if counter 'blackpearl' == 0
  sysmsg 'Can not proceed without black pearl. Ending'
  stop
elseif counter 'bloodmoss' == 0
  sysmsg 'Can not proceed without bloodmoss. Ending'
  stop
elseif counter 'mandrake' == 0
  sysmsg 'Can not proceed without mandrake root. Ending'
  stop
endif

// Check flamestrike reagents
sysmsg 'Checking flamestrike reagents'
if counter 'silk' == 0
  sysmsg 'Can not proceed without spiders silk. Ending'
  stop
elseif counter 'sulfur' == 0
  sysmsg 'Can not proceed without sulfurous ash. Ending'
  stop
endif
// Any failure above means something's wrong w/ your reagent situation

// This assume we start next to our sparring partner
// Main loop
while not dead
  // Prime journal with active skill bonus message (if it exists)
  useskill "Evaluating Intelligence"
  waitfortarget 2000 
  target! 'friend1' 
  pause 2000

  // Bonus is active loop
  // We assume we're in a house and next to the reagent bag and our sparring partner
  // This loop performs the following actions:
  // 1. Checks our partner's health to stop sparring if necessary
  // 2. Checks our own health to indicate that we're dying to our partner
  // 3. Casts flamestrike on ourself for GAINS 
  // 4. Walks away to meditate if necessary
  // 5. Restock reagents
  while injournal 'active' 'system'

    // 1. Partner health check
    if not @findlayer 'friend1' 6
      warmode 'off'
      pause 2000
    else
      attack 'friend1'
    endif

    // 2. Self health check
    if hits < 60
      pause 650
      @findlayer 'self' 6
      moveitem 'found' 'backpack' 46 65 0
      pause 650

      // Med up if necessary
      if mana < 40
        warmode 'off'
        pause 650
        warmode 'on'
        pause 650
        warmode 'off'
        pause 1000
        useskill 'meditation'
        while mana < 40
        endwhile
      endif

      // Raise eval while waiting for a heal
      while hits < 60

        // If our friend starts dying while we're waiting for a heal
        // pause attacking a moment but continue to check our own health
        // to put our own hat back on.  Avoids edge case where neither particiant will
        // put hat back on
        if not @findlayer 'friend1' 6
          warmode 'off'
          pause 650
          warmode 'on'
          pause 650
          warmode 'off'
          useskill 'meditation'
          pause 600

          // Put our hat back on since we're fine
          if hits > 59
            @findtype 0x1718 'any' 'backpack'
            equipitem 'found' 6
            pause 600
          endif
        endif
        // Too lazy to optimize this right now from my bed
        // Can probably remove above hat code and just use the blow
        // Put our hat back on since we're fine
        if hits > 59
          @findtype 0x1718 'any' 'backpack'
          equipitem 'found' 6
          pause 600
        endif
      endwhile

      // Put hat back on once we're fine
      if hits > 59
        @findtype 0x1718 'any' 'backpack'
        equipitem 'found' 6
        pause 600
      endif
    endif

    // 3. Magery gains
    clearjournal 
    pause 650
    autotargetself
    cast 'flame strike'
    pause 4001

    // 4. Mana check
    // Don't med if we're below threshold for healing
    // We will remove hat on next runloop and start to med
    // This makes sure we med up while our healer heals us
    if hits > 60
      if mana < 40
        warmode 'off'
        pause 650
        warmode 'on'
        pause 650
        warmode 'off'
        pause 1000
        useskill 'meditation'
        while mana < 40
        endwhile
        pause 600
      else 
        attack 'friend1'
      endif
    endif

    // 5. Reagent Check
    // Check Flamestrike reagents
    sysmsg 'Checking flamestrike reagents'
    if counter 'silk' == 0
      sysmsg 'Restocking'
      useobject regbag
      pause 751
      waitforcontext banker 1 15000
      pause 751
      organizer rereg
      while organizing
        pause 1001
      endwhile
    elseif counter 'sulfur' == 0
      useobject regbag
      pause 751
      waitforcontext banker 1 15000
      pause 751
      organizer rereg
      while organizing
        pause 1001
      endwhile
    endif

    // Check Recall reagents
    sysmsg 'Checking recall reagents'
    if counter 'blackpearl' == 0
      useobject regbag
      pause 751
      waitforcontext banker 1 15000
      pause 751
      organizer rereg
      while organizing
        pause 1001
      endwhile
    elseif counter 'bloodmoss' == 0
      useobject regbag
      pause 751
      waitforcontext banker 1 15000
      pause 751
      organizer rereg
      while organizing
        pause 1001
      endwhile
    elseif counter 'mandrake' == 0
      useobject regbag
      pause 751
      waitforcontext banker 1 15000
      pause 751
      organizer rereg
      while organizing
        pause 1001
      endwhile
    endif

  // End of bonus active loop  
  endwhile

  // Bonus is NOT active loop
  // This loop terminates once we get the active skill gain bonus buff
  // 1. Make sure we have enough reagents to go murder a walrus
  while not injournal 'active' 'system'

    // 1. Reagent Check before leaving bank
    // Check Flamestrike reagents
    sysmsg 'Checking flamestrike reagents'
    if counter 'silk' == 0
      useobject regbag
      pause 751
      waitforcontext banker 1 15000
      pause 751
      sysmsg 'Restocking'
      organizer rereg
      while organizing
        pause 1001
      endwhile
    elseif counter 'sulfur' == 0
      useobject regbag
      pause 751
      waitforcontext banker 1 15000
      pause 751
      organizer rereg
      while organizing
        pause 1001
      endwhile
    endif

    // Check Recall reagents
    sysmsg 'Checking recall reagents'
    if counter 'blackpearl' == 0
      useobject regbag
      pause 751
      waitforcontext banker 1 15000
      pause 751
      organizer rereg
      while organizing
        pause 1001
      endwhile
    elseif counter 'bloodmoss' == 0
      waitforcontext banker 1 15000
      pause 751
      organizer rereg
      while organizing
        pause 1001
      endwhile
    elseif counter 'mandrake' == 0
      waitforcontext banker 1 15000
      pause 751
      organizer rereg
      while organizing
        pause 1001
      endwhile
    endif

    // 1.5 Wait for mana before recalling to walrusRune
    // This is to prevent us aggroing a walrus but not being able to kill it efficiently and, possibly, dying while there
    // Mana check
    if mana < 80
      warmode 'off'
      pause 650
      warmode 'on'
      pause 650
      warmode 'off'
      pause 1000
      useskill 'meditation'
      while mana < 80
      endwhile
      pause 600
    endif 

    // 1.75 Check health before recalling to walrusRune
    // This is to prevent us FS'ing ourselves, having no buff, and recalling out to die to a walrus
    // 2. Self health check
    if hits < 60
      @findlayer 'self' 6
      moveitem 'found' 'backpack' 46 65 0
      pause 600

      while hits < 60
        // Put our hat back on since we're fine
        if hits > 59
          @findtype 0x1718 'any' 'backpack'
          equipitem 'found' 6
          pause 600
        endif
      endwhile
    endif

    // 2. Recall to walrus spot
    autotargetobject walrusRune
    cast 'recall'
    pause 4001

    // 2. Murder a walrus for a great buff
    // Wait around for a walrus
    while not @findtype 0xdd any ground 1 10
      pause 1001
    endwhile
    // Probably found a walrus
    if @findtype 0xdd any ground 1 10
      if not friend found
        sysmsg 'Found friendly walrus'
        setalias die found
      endif
    endif
    // While the walrus is alive, attempt to kill it
    while @findobject die
      // Kill a damn walrus
      autotargetobject die
      if skill 'magery' < 80
        sysmsg 'Checking ebolt reagents'
        if counter 'blackpearl' == 1
          autotargetobject reagentLocationRune
          cast 'recall'
          pause 4001
          break
        elseif counter 'nightshade' == 0
          autotargetobject reagentLocationRune
          cast 'recall'
          pause 4001
          break
        endif
        cast 'energy bolt'
      else
        // Check if we still can cast FS
        sysmsg 'Checking flamestrike reagents'
        if counter 'silk' == 0
          autotargetobject reagentLocationRune
          cast 'recall'
          pause 4001
          break
        elseif counter 'sulfur' == 0
          autotargetobject reagentLocationRune
          cast 'recall'
          pause 4001
          break
        endif
        cast 'flame strike'
      endif
      pause 4001
    endwhile

    // 3. Med up to get home
    while mana < 11
      useskill 'meditation'
      pause 1001
    endwhile

    // 4. Go home if we aren't already there (running out of regs casting FS will cause early recall)
    if not @findlayer 'friend1' 6
      autotargetobject reagentLocationRune
      cast 'recall'
      pause 4001
    endif

    // Break loop and return to main runloop
    break
  // End of bonus inactive loop  
  endwhile
endwhile

