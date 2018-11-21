// Person we will making sure isn't dying
if not findalias 'friend1'
  headmsg 'Select friend'
  promptalias 'friend1'
endif

if not @findalias 'eval' 
  headmsg 'Select the person to train eval on' 
  promptalias 'eval' 
endif 

// Wait for friend to heal themselves back up
// So we don't wrestle them to death
if not @findlayer 'friend1' 6
  warmode 'off'
  useskill "Evaluating Intelligence"
  waitfortarget 2000 
  target! 'eval' 
  pause 2000
else
  attack 'friend1'
endif

// Take hat off to indicate we're dying
if hits < 50
  @findlayer 'self' 6
  moveitem 'found' 'backpack' 46 65 0
  pause 600

    // Med up if necessary
  if mana < 50
    warmode 'off'
    pause 650
    warmode 'on'
    pause 650
    warmode 'off'
    pause 1000
    useskill 'meditation'
    while mana < 50
      pause 1000
      useskill 'meditation'
    endwhile
  endif

  // Raise eval while waiting for a heal
  while hits < 50
    useskill "Evaluating Intelligence"
    waitfortarget 2000 
    target! 'eval' 
    pause 2000

    // If our friend starts dying while we're waiting for a heal
    // pause attacking a moment but continue to check our own health
    // to put our own hat back on.  Avoids edge case where neither particiant will
    // put hat back on
    if not @findlayer 'friend1' 6
      warmode 'off'
      useskill "Evaluating Intelligence"
      waitfortarget 2000 
      target! 'eval' 
      pause 2000

      // Put our hat back on since we're fine
      if hits > 49
        @findtype 0x1718 'any' 'backpack'
        equipitem 'found' 6
        pause 600
      endif
    endif
  endwhile

  // Put hat back on once we're fine
  if hits > 49
    @findtype 0x1718 'any' 'backpack'
    equipitem 'found' 6
    pause 600
  endif
endif

// Med up if necessary
if mana < 50
  warmode 'off'
  pause 650
  warmode 'on'
  pause 650
  warmode 'off'
  pause 1000
  useskill 'meditation'
  while mana < 50
    pause 1000
    useskill 'meditation'
  endwhile
endif

if skill 'magery' < 60
  cast 'lightning' 'self'
  pause 1000
elseif skill 'magery' < 70
  cast 'energy bolt' 'self'
  pause 1000
else
  sysmsg 'go fite people'
  stop
endif

