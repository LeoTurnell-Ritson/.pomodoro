<h1 align="center">pomodoro</h1>

<p align="center">
  bash shell pomodoro timer prompt
  </p>
</div>

## About The Project

Pomodoro is a shell script wich adds a [pomodoro](https://en.wikipedia.org/wiki/Pomodoro_Technique) style timer to the shell prompt, for example
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

Advantages,
    - WORK/PLAY indicator bar is constantly present every time the user hits enter,
    - synchronised and simultaneous across all open shells.

## Getting Started

   ```sh
   mkdir .pomodoro
   cd .pomodoro
   git clone https://github.com/LeoTurnell-Ritson/pomodoro.git
   ```
   then
      
   ```sh
   souce init.sh
   ```

   or (recommended) add the following lines to your .bashrc file

   ```sh
   if [ -f ~/.pomodoro/init.sh ]; then
       . ~/.pomodoro/init.sh
   fi
   ```
   
### Running pomodoro

To begin a new session

```sh
pomodoro -n
```
to join a session from another (separate) shell
```sh
pomodoro -j
```
to end a session

```sh
pomodoro -e
```

note that ending a session in one shell will end the session in all open shells.

For more information just type

```sh
pomodoro
```