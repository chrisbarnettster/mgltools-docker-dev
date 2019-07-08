docker build .

docker run -ti --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix $IMAGENAME /home/mgltools/programs/mgltools_x86_64Linux2_1.5.6/bin/pmv
