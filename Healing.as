// Should NOT be looped

// Person we will be healing
if not findalias 'friend1'
  headmsg 'Select friend'
  promptalias 'friend1'
endif

// Where we're findin bandages
if not findalias 'Box'
  headmsg 'Select container of bandages'
  promptalias 'Box'
endif

// Grab some more bandages if we're out
if counter 'bandages' == 0
  movetype 0xe21 'Box' 'backpack' 0 0 0 'any' 20 1
  pause 1000
endif    

// 0x1401 is the ID of the training kryss. Replace this with your weapon type

// Will run while we have 0xe21 (bandages)
while @findtype 0xe21 'any' 'backpack' 1

  pause 1000
  // Make sure we always tab out for now
  warmode 'off'
  pause 650
  warmode 'on'
  pause 650

  // Make sure we have a weapon equipped
  // Have to findtype again to make sure that the dagger is the last found type
  if not @findlayer 'self' 1 and @findtype 0x1401 'any' 'backpack' 1 
    pause 600
    equipitem 'found' 1
  endif

  // Make sure we aren't dying while healing our friend
  if hits self < 50
    @findlayer 'self' 6
    moveitem 'found' 'backpack' 46 65 0
    pause 600
    bandageself
    pause 14000
  // Put hat back on if we're feeling ok again
  elseif not @findlayer 'self' 6
    @findtype 0x1718 'any' 'backpack'
    equipitem 'found' 6
    pause 600
  endif

  // Check if friend is wearing his hat!  If he isn't, he's DYINGGGG
  if not @findlayer 'friend1' 6
    @findtype 0xe21 'any' 'backpack' 1 1
    pause 500
    useobject 'found'
    waitfortarget 1000
    target! 'friend1'
    pause 6500
  endif

  // Grab some more bandages if we're out
  if counter 'bandages' == 0
    movetype 0xe21 'Box' 'backpack' 0 0 0 'any' 20 1
    pause 750
  endif  

  canceltarget  

endwhile
// If we're outta bandages or knives, turn off war mode
warmode 'off'
