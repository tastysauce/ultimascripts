@clearjournal

// Potion types
@removelist 'potions'
@createlist 'potions'
pushlist 'potions' 0xf0c // heal
pushlist 'potions' 0xf07 // cure
pushlist 'potions' 0xf06 // resist
pushlist 'potions' 0xf0a // poison
pushlist 'potions' 0xf08 // agility
pushlist 'potions' 0xf0b // refresh
pushlist 'potions' 0xf0a // poison
pushlist 'potions' 0xf0d // explo
pushlist 'potions' 0xf09 // strength

// Set alias'
if not findalias 'kegbag'
    sysmsg "Select container (or bag in bank) with empty kegs, full kegs will be placed here" 88
    promptalias 'kegbag'
endif

if not findalias 'shelf'
    sysmsg "Select shelf to dump kegs into," 88
    promptalias 'shelf'
endif

if not findalias 'mainContainer'
    sysmsg "Select top level object," 88
    promptalias 'mainContainer'
endif

// Check no potions in pack
sysmsg "pack potion check" 16
for 0 to 'potions'
    if @findtype potions[] 'any' 'backpack'
        headmsg "Please remove all potions from pack before starting" 88
        stop
    endif
endfor

// This is the list we'll check to see which potion type we're making
@removelist 'potion'
@createlist 'potion'

@useobject 'backpack'
pause 1000

@useobject 'mainContainer'
pause 1000

@useobject 'kegbag'
pause 1000

// Restock from shelf
useobject 'shelf'
waitforgump 0xc0b1026d 15000
replygump 0xc0b1026d 7
waitforgump 0xc0b1026d 15000
replygump 0xc0b1026d 0
pause 1500

while not dead

    // World save check
    if @injournal 'world will save' 'system'
        msg 'Pausing for world save'
        pause 30000
        msg 'Resuming after world save'
    endif
    @clearjournal

    // Check for a keg or transfer empty one
    if not @findtype 0x1940 'any' 'backpack'
        movetype 0x1940 'kegbag' 'backpack' 0 0 0 0 1
        pause 2000
    endif

    // Verify keg. Server save on restock may occur
    // so throw message, wait, and start again
    if not @findtype 0x1940 'any' 'backpack'
        headmsg "I need a keg to continue!" 88
        pause 5000
        continue
    endif

    // Check if we need to pour into keg
    if not @findtype 0xf0e 0 'backpack'
        headmsg "Pouring into keg" 88
        @unsetalias 'keg'
        @findtype 0x1940 'any' 'backpack'
        @setalias 'keg' 'found'
        for 0 to 'potions'
            if @findtype potions[] 'any' 'backpack'
                moveitem 'found' 'keg'
                pause 3000
                break
            endif
        endfor
    endif

    // Check if we need to move any distills out
    while @findtype 0xefc 'any' 'backpack'
        headmsg "Moving essences back"
        movetype 0xefc 'backpack' 'kegbag'
        pause 1000
    endwhile 

    while @findtype 0x4516 'any' 'backpack'
        headmsg "Moving distills back"
        movetype 0x4516 'backpack' 'kegbag'
        pause 1000
    endwhile 

    // Check for empty bottle
    while not @findtype 0xf0e 0 'backpack'
        msg "I need an empty bottle"
        pause 5000
        continue
    endwhile

    // Verify pestle
    if not @findtype 0xe9b 'any' 'backpack'
        headmsg "Attempting to move mortar to backpack" 88
        movetype 0xe9b 'kegbag' 'backpack' 0 0 0 'any' 1
        pause 2000
    endif

    // Check which potion to make given what's in the kegbag
    if @findtype 0xf09 'any' 'kegbag' 1 0 // Strength
        if @pushlist! 'potion' 'Greater Strength'
            msg 'Making Greater Strength'
            if list 'potion' > 1
                poplist 'potion' 'front'
                pushlist! 'potion' 'change' 'front'
            endif
        endif
        // conditionally restock
        if counter 'root' < 10
            msg 'Looking for more root...'
            pushlist 'potion' 'restock' 'front'
        endif
    elseif @findtype 0xf07 'any' 'kegbag' 1 0 // Cure
        if @pushlist! 'potion' 'Greater Cure'
            msg 'Making Greater Cure'
            if list 'potion' > 1
                poplist 'potion' 'front'
                pushlist! 'potion' 'change' 'front'
            endif
        endif
        // conditionally restock
        if counter 'garlic' < 10
            msg 'Looking for more garlic...'
            pushlist 'potion' 'restock' 'front'
        endif
    elseif @findtype 0xf0c 'any' 'kegbag' 1 0 // Heal
        if @pushlist! 'potion' 'Greater Heal'
            msg 'Making Greater Heal'
            if list 'potion' > 1
                poplist 'potion' 'front'
                pushlist! 'potion' 'change' 'front'
            endif
        endif
        // conditionally restock
        if counter 'ginseng' < 10
            msg 'Looking for more ginseng...'
            pushlist 'potion' 'restock' 'front'
        endif
    elseif @findtype 0xf0b 'any' 'kegbag' 1 0 // Refresh
        if @pushlist! 'potion' 'Total Refresh'
            msg 'Making Total Refresh'
            if list 'potion' > 1
                poplist 'potion' 'front'
                pushlist! 'potion' 'change' 'front'
            endif
        endif
        // conditionally restock
        if counter 'blackpearl' < 10
            msg 'Looking for more black pearl...'
            pushlist 'potion' 'restock' 'front'
        endif
    elseif @findtype 0xf0d 'any' 'kegbag' 1 0 // Explo
        if @pushlist! 'potion' 'Greater Explosion'
            msg 'Making Greater Explosion'
            if list 'potion' > 1
                poplist 'potion' 'front'
                pushlist! 'potion' 'change' 'front'
            endif
        endif
        // conditionally restock
        if counter 'ash' < 10
            msg 'Looking for more ash...'
            pushlist 'potion' 'restock' 'front'
        endif
    elseif @findtype 0xf0a 'any' 'kegbag' 1 0 // Deadly
        if @pushlist! 'potion' 'Deadly Poison'
            msg 'Making Deadly Poison'
            if list 'potion' > 1
                poplist 'potion' 'front'
                pushlist! 'potion' 'change' 'front'
            endif
        endif
        // conditionally restock
        if counter 'nightshade' < 10
            msg 'Looking for more nightshade...'
            pushlist 'potion' 'restock' 'front'
        endif
    elseif @findtype 0xf52 'any' 'kegbag' 1 0 // Lethal
        if @pushlist! 'potion' 'Lethal Poison'
            msg 'Making Lethal Poison'
            if list 'potion' > 1
                poplist 'potion' 'front'
                pushlist! 'potion' 'change' 'front'
            endif
        endif
        // conditionally restock
        if counter 'nightshade' < 10
            msg 'Looking for more nightshade...'
            pushlist 'potion' 'restock' 'front'
        endif
    elseif @findtype 0xefc 'any' 'kegbag'
        if @pushlist! 'potion' 'distill'
            msg 'Distilling'
            if list 'potion' > 1
                poplist 'potion' 'front'
                pushlist! 'potion' 'change' 'front'
            endif
        endif
    else // Stop
        if @pushlist! 'potion' 'stop'
            msg 'No potion type selected'
            if list 'potion' > 1
                poplist 'potion' 'front'
                pushlist! 'potion' 'change' 'front'
            endif
        endif
    endif

    if @inlist 'potion' 'restock'
        msg "Restocking reagents"
        useobject 'shelf'
        waitforgump 0xc0b1026d 15000
        replygump 0xc0b1026d 7
        waitforgump 0xc0b1026d 15000
        pause 2000
        replygump 0xc0b1026d 0
        poplist 'potion' 'front'
    endif

    // Check if we need to change potion types
    if @inlist 'potion' 'change'
        headmsg "Dumping existing keg out due to change" 88
        pause 650
        movetype 0x1940 'backpack' 'shelf' 0 0 0 'any' 1
        pause 800
        poplist 'potion' 'front'
    endif

    // Return here if we don't actually have to make anything
    if not list 'potion' == 1 or @inlist 'potion' 'stop'
        continue
    endif

    // Use pestle
    @findtype 0xe9b 'any' 'backpack'
    @useobject 'found'
    waitforgump 0x38920abd 5000

    // If we're distilling, need to return early after this
    if @inlist 'potion' 'distill'
        movetype 0xefc 'kegbag' 'backpack'
        pause 1000

        useobject 0x42f31620
        waitforgump 0x38920abd 15000
        replygump 0x38920abd 108
        waitforgump 0x38920abd 15000
        replygump 0x38920abd 11
        waitforgump 0x38920abd 15000
        replygump 0x38920abd 204
        pause 2000
        replygump 0x38920abd 205
        pause 2000
        replygump 0x38920abd 206
        pause 2000
        replygump 0x38920abd 207
        pause 2000
        replygump 0x38920abd 208
        pause 2000
        replygump 0x38920abd 209
        pause 2000
        replygump 0x38920abd 11
        waitforgump 0x38920abd 15000
        replygump 0x38920abd 200
        pause 2000
        replygump 0x38920abd 201
        pause 2000
        replygump 0x38920abd 202
        pause 2000
        replygump 0x38920abd 203
        pause 2000
        replygump 0x38920abd 204
        pause 2000
        replygump 0x38920abd 205
        pause 2000
        replygump 0x38920abd 206
        pause 2000

        @movetype 0x4516 'backpack' 'kegbag' 0 0 0 'any' 1
        pause 1000

        // Close the alchemy gump
        replygump 0x38920abd 0
        pause 700

        continue
    endif

    // Make
    if @inlist 'potion' 'Greater Heal'
        replygump 0x38920abd 100
        waitforgump 0x38920abd 5000
        replygump 0x38920abd 202
        waitforgump 0x38920abd 15000
        waitforgump 0x38920abd 15000
    elseif @inlist 'potion' 'Greater Cure'
        replygump 0x38920abd 101
        waitforgump 0x38920abd 5000
        replygump 0x38920abd 202
        waitforgump 0x38920abd 15000
        waitforgump 0x38920abd 15000
    elseif @inlist 'potion' 'Total Refresh'
        replygump 0x38920abd 102
        waitforgump 0x38920abd 5000
        replygump 0x38920abd 201
        waitforgump 0x38920abd 15000
        waitforgump 0x38920abd 15000
    elseif @inlist 'potion' 'Greater Strength'
        replygump 0x38920abd 103
        waitforgump 0x38920abd 5000
        replygump 0x38920abd 201
        waitforgump 0x38920abd 15000
        waitforgump 0x38920abd 15000
    elseif @inlist 'potion' 'Greater Agility'
        replygump 0x38920abd 104
        waitforgump 0x38920abd 5000
        replygump 0x38920abd 201
        waitforgump 0x38920abd 15000
        waitforgump 0x38920abd 15000
    elseif @inlist 'potion' 'Greater Magic Resist'
        replygump 0x38920abd 105
        waitforgump 0x38920abd 5000
        replygump 0x38920abd 202
        waitforgump 0x38920abd 15000
        waitforgump 0x38920abd 15000
    elseif @inlist 'potion' 'Deadly Poison'
        replygump 0x38920abd 106
        waitforgump 0x38920abd 5000
        replygump 0x38920abd 203
        waitforgump 0x38920abd 15000
        waitforgump 0x38920abd 15000
    elseif @inlist 'potion' 'Lethal Poison'
        replygump 0x38920abd 106
        waitforgump 0x38920abd 5000
        replygump 0x38920abd 204
        waitforgump 0x38920abd 15000
        waitforgump 0x38920abd 15000
    elseif @inlist 'potion' 'Greater Explosion'
        replygump 0x38920abd 107
        waitforgump 0x38920abd 5000
        replygump 0x38920abd 202
        waitforgump 0x38920abd 15000
        waitforgump 0x38920abd 15000
    elseif @inlist 'potion' 'Stop'
        headmsg "Currently halted" 88
        pause 5000
    else
        headmsg "Unable to figure out potion type you requested" 88
        pause 5000
        continue
    endif


    // Pause to get potion transfer automatically
    pause 1800

    // Close the alchemy gump
    replygump 0x38920abd 0

    // Check if we need to pour into keg
    if not @findtype 0xf0e 0 'backpack'
        headmsg "Pouring into keg" 71
        @unsetalias 'keg'
        @findtype 0x1940 'any' 'backpack'
        @setalias 'keg' 'found'
        for 0 to 'potions'
            if @findtype potions[] 'any' 'backpack'
                moveitem 'found' 'keg'
                pause 3000
                break
            endif
        endfor
    endif

    // Check if keg full
    if @injournal 'hold any more' 'system'
        headmsg "Keg full" 88
        msg "Keg full, transferring to shelf"
        pause 600
        movetype 0x1940 'backpack' 'shelf' 0 0 0 'any' 1
        pause 3000
    endif

endwhile

