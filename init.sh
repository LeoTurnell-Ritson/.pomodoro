PROMPT_COMMAND="pomo_prompt;$PROMPT_COMMAND"
let POMO_WORK="25*60"
let POMO_PLAY="5*60"

function pomo_prompt() {
    if [ -f "$POMODORO_FILE" ] && [ "$POMO" = true ]; then
        echo -n "$(_pomo):"
    else
        POMO=false
    fi
}

function pomodoro() {
    if [ "$1" = "-n" ] || [ "$1" = "--new" ]; then
        export POMO=true
        POMO_START=$(date +"%s")
        rm -f "$POMODORO_FILE"
        touch "$POMODORO_FILE"
        echo "SESSION_START=$POMO_START" >> "$POMODORO_FILE"
        echo "CYCLE_START=$POMO_START" >> "$POMODORO_FILE"
        echo "WORK=$POMO_WORK" >> "$POMODORO_FILE"
        echo "PLAY=$POMO_PLAY" >> "$POMODORO_FILE"
    elif [ "$1" = "-j" ] || [ "$1" = "--join" ]; then
        if [ -f "$POMODORO_FILE" ]; then
            if [ "$POMO" = true ]; then
                echo "pomodoro: warring: session already joined"
            else
                export POMO=true
            fi
        else
            echo "pomodoro: error: no current session file $SESSION_FILE"
        fi
    elif [ "$1" = "-e" ] || [ "$1" = "--end" ]; then
        if [ "$POMO" = true ]; then
            rm -f "$POMODORO_FILE"
            export POMO=false
        else
            echo "pomodoro: error: current session not open"
        fi
    elif [ "$1" = "-w" ] || [ "$1" = "--work" ]; then
        if [ -f "$POMODORO_FILE" ]; then
            . "$POMODORO_FILE"
            rm "$POMODORO_FILE"
            touch "$POMODORO_FILE"
            echo "SESSION_START=$SESSION_START" >> "$POMODORO_FILE"
            echo "CYCLE_START=$CYCLE_START" >> "$POMODORO_FILE"
            echo "WORK=$2" >> "$POMODORO_FILE"
            echo "PLAY=$PLAY" >> "$POMODORO_FILE"
        else
            echo "pomodoro: error: no current session file $SESSION_FILE"
        fi
    elif [ "$1" = "-p" ] || [ "$1" = "--play" ]; then
        if [ -f "$POMODORO_FILE" ]; then
            . "$POMODORO_FILE"
            rm "$POMODORO_FILE"
            touch "$POMODORO_FILE"
            echo "SESSION_START=$SESSION_START" >> "$POMODORO_FILE"
            echo "CYCLE_START=$CYCLE_START" >> "$POMODORO_FILE"
            echo "WORK=$WORK" >> "$POMODORO_FILE"
            echo "PLAY=$2" >> "$POMODORO_FILE"
        else
            echo "pomodoro: error: no current session file $SESSION_FILE"
        fi
    elif [ "$1" = "-d" ] || [ "$1" = "--display" ]; then
        if [ -f "$POMODORO_FILE" ]; then
            . "$POMODORO_FILE"
            let CYCLE_END="(CYCLE_START + WORK + PLAY)"
            SESSION_START="$(date -d @${SESSION_START} +"%d-%m-%Y %T")"
            CYCLE_START="$(date -d @${CYCLE_START} +"%d-%m-%Y %T")"
            CYCLE_END="$(date -d @${CYCLE_END} +"%d-%m-%Y %T")"
            NOW="$(date +"%d-%m-%Y %T")"
            WORK="$(date -d @${WORK} -u +"           %T")"
            PLAY="$(date -d @${PLAY} -u +"           %T")"

            echo "SESSION START  $SESSION_START"
            echo "CYCLE START    $CYCLE_START"
            echo "CYCLE END      $CYCLE_END"
            echo "NOW            $NOW"
            echo "WORK           $WORK"
            echo "PLAY           $PLAY"
        else
            echo "pomodoro: error: no current session file $SESSION_FILE"
        fi
    else
        echo "Usage: pomodoro [-n | -j | -e | -d | -w WORK | -p PLAY]"
        echo ""
        echo "optional arguments:"
        echo " -n, --new          start a new session"
        echo " -j, --join         join are existing session"
        echo " -e, --end          end the current session"
        echo " -d, --display      display the current session information"
        echo " -w, --work WORK    set new work length in seconds"
        echo " -p, --play PLAY    set new play length in seconds"
    fi
}

function _pomo() {
    . "$POMODORO_FILE"
    POMO_CYCLE=$(expr $WORK + $PLAY)
    POMO_NOW=$(date +"%s")
    POMO_CURRENT=$(expr $POMO_NOW - $CYCLE_START)
    if [ "$POMO_CURRENT" -lt "$WORK" ];
    then
        printf "\033[01;31mWORK ["
        for i in {1..10};
        do
            let BLOCK="(WORK/10)*i";
            if [ "$BLOCK" -lt "$POMO_CURRENT" ];
            then
                printf "|"
            else
                printf "-"
            fi
        done
        printf "]\033[00m"
    elif [ "$POMO_CURRENT" -lt "$POMO_CYCLE" ];
    then
        printf "\033[01;36mPLAY [";
        for i in {1..10};
        do
            let BLOCK="((PLAY/10)*i)+WORK";
            if [ "$BLOCK" -lt "$POMO_CURRENT" ];
            then
                printf "|"
            else
                printf "-"
            fi
        done
        printf "]\033[00m"
    else
        CYCLE_START=$(expr $CYCLE_START + $POMO_CYCLE)
        rm "$POMODORO_FILE"
        touch "$POMODORO_FILE"
        echo "SESSION_START=$SESSION_START" >> "$POMODORO_FILE"
        echo "CYCLE_START=$CYCLE_START" >> "$POMODORO_FILE"
        echo "WORK=$WORK" >> "$POMODORO_FILE"
        echo "PLAY=$PLAY" >> "$POMODORO_FILE"
        printf "\033[01;36mPLAY [||||||||||]\033[00m";
    fi
}
