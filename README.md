%<h1 align="center">.pomodoro</h1>

<p align="center">
  bash shell pomodoro timer prompt
  </p>
</div>

## About The Project

.Pomodoro is a shell script wich adds a dynamic [pomodoro](https://en.wikipedia.org/wiki/Pomodoro_Technique) style timer to the shell prompt, for example
```sh
user@home:~/.pomodoro$ 
```
becomes
```sh
WORK [||||||----]:user@home:~/.pomodoro$
```
then after a specified work period has passed and the work bar has filled 
```sh
PLAY [|---------]:user@home:~/.pomodoro$
```
and the cycle repeats. 

### Why?

- WORK/PLAY indicator bar is constantly present updating every time the user hits enter,

- synchronised and simultaneous across all open shells,

- very simple and customisable bash script.

## Getting Started

   ```sh
   git clone https://github.com/LeoTurnell-Ritson/.pomodoro.git
   ```
   then
      
   ```sh
   . ~/.pomodoro/init.sh
   ```

   or (recommended) add the following lines to your .bashrc file

   ```sh
        if [ -f ~/.pomodoro/init.sh ]; then
           SESSION_FILE="$HOME/.pomodoro/session"
           . ~/.pomodoro/init.sh
        fi
   ```
   
### Running .pomodoro

To begin a new session

```sh
pomodoro -n
```
to join a session from another (separate) shell
```sh
pomodoro -j
```
and to end a session

```sh
pomodoro -e
```

Note that ending a session in one shell will end the session in all open shells.

For more information and how to change WORK/PLAY duration, just type 

```sh
pomodoro
```

Enjoy!