#!/bin/bash
gst-launch \
  v4l2src device=/dev/video0 always-copy=FALSE num-buffers=2000 !\
  autoconvert !\
  'video/x-raw-yuv,width=1280,height=720,framerate=30/1' ! \
  queue !\
  vp8enc mode=0 speed=4 threads=4 quality=4 sharpness=4 max-keyframe-distance=15 !\
  queue !\
  webmmux streamable=true name=mux\
  jackaudiosrc !\
  audioconvert !\
  audiorate !\
  audio/x-raw-float,channels=2,rate=48000,depth=16 !\
  vorbisenc quality=0.5 bitrate=48000 !\
  queue !\
  queue !\
  mux. mux. !\
  queue !\
  shout2send name="XYZ streamname" ip=server.adress.com port=8000 password=hackme mount=/test.webm

