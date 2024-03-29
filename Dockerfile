FROM ubuntu:16.04
MAINTAINER Léo Biscassi, <leo.biscassi@gmail.com>

ENV MGL_VERSION=1.5.6 \
MGL_USER=mgltools \
MGL_UID=1450 \
MGL_GID=1450 \
MGL_HOME=/home/mgltools \
DATA_DIR=/data \
LC_ALL=en_US.UTF-8 \
LANG=en_US.UTF-8


ENV PROGRAMS_ROOT=$MGL_HOME/programs \
MGL_LINK=http://mgltools.scripps.edu/downloads/downloads/tars/releases/REL1.5.6/mgltools_x86_64Linux2_$MGL_VERSION.tar.gz

RUN apt-get update && apt-get install -y wget tar locales libx11-6 libx11-dev x11-utils libglu1-mesa libglu1-mesa-dev x11vnc git

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales


RUN groupadd -r $MGL_USER -g $MGL_GID && \
	useradd -u $MGL_UID -r -g $MGL_USER -d $MGL_HOME -c "MGL Tools User" $MGL_USER && \
	mkdir $MGL_HOME $DATA_DIR $PROGRAMS_ROOT && \
	chown -R $MGL_USER:$MGL_USER $MGL_HOME $PROGRAMS_ROOT $DATA_DIR

WORKDIR $PROGRAMS_ROOT

USER $MGL_USER

RUN wget -q $MGL_LINK && tar -xf mgltools_x86_64Linux2_$MGL_VERSION.tar.gz && \
	rm -rf mgltools_x86_64Linux2_$MGL_VERSION.tar.gz && cd mgltools_x86_64Linux2_$MGL_VERSION && \
	./install.sh -d $PROGRAMS_ROOT/mgltools_x86_64Linux2_$MGL_VERSION && \
	sh -c "echo alias pmv=$PROGRAMS_ROOT/mgltools_x86_64Linux2_1.5.6/bin/pmv" >> $MGL_HOME/.bashrc && \
	sh -c "alias adt=$PROGRAMS_ROOT/mgltools_x86_64Linux2_1.5.6/bin/adt" >> $MGL_HOME/.bashrc && \
	sh -c "alias vision=$PROGRAMS_ROOT/mgltools_x86_64Linux2_1.5.6/bin/vision" >> $MGL_HOME/.bashrc && \
	sh -c "alias pythonsh=$PROGRAMS_ROOT/mgltools_x86_64Linux2_1.5.6/bin/pythonsh" >> $MGL_HOME/.bashrc

VOLUME ["/data/"]

WORKDIR $DATA_DIR
