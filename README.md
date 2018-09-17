# Rotate.sh

A helper script for fb-rotate, which searches for the Display ID automatically, and rotates the secondary display. The reason I wrote this script is because I was getting annoyed that I had to search for monitor ID every time I disconnected my laptop. 

## Getting Started

### Before We Begin
This script targets a very specific use case and may not be suitable for all folks.

If your secondary monitor alternates between `portrait` and `landscape` orientation 

`AND `

- You use a laptop in clamshell mode with two displays attached.

`OR`

- You use a iMac or MacPro with a secondary monitor. 

`THEN`
This script can save you a lot of time!


### Prerequisites
First, and foremost, [fb-rotate](https://github.com/CdLbB/fb-rotate) must be 
installed on your machine. Please follow instructions within Eric's README file.

Once `fb-rotate` is installed, you can clone this repo and place the script file
wherever you like.


### Installation
To clone this repository in your current directory:

`git clone https://github.com/Bardworx/rotate.sh.git`

To use this script from anywhere, you need to copy the rotate.sh to your `$PATH`. If your path is `/usr/local/bin`, the following command would copy the script and make it accessible from anywhere on your system:

`cp rotate.sh /usr/local/bin/rotate`

Now, you can simply:
`rotate -r 90` and your secondary display will rotate 90 degrees; From landscape mode to portrait.

To find your `$PATH`, simply type `$PATH` inside your terminal window. Multiple 
directories should display, similar to:
`-bash: /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:` 

`rotate.sh` will use `find` to locate fb-rotate on your system automatically, a path does not have to be supplied. To optimize `find`, I’ve set the limit to `-maxdepth 3`. You can change the quantity as you see fit, if necessary.


### Usage

To use the script to rotate your secondary display:
`rotate -r 90`

To read full manual:
`rotate -h`


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

`fb-rotate` is licensed under `GPL`. Im not 100% sure if that causes any problems or not.

## Acknowledgments

[Eric Nitardy](http://cdlbb.github.com) who originally wrote [fb-rotate](https://github.com/CdLbB/fb-rotate).
