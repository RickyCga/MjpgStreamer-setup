# MjpgStreamer-setup
setup mjpg-streamer server on raspberry pi (raspbian)

###1. update before install package
    $ sudo apt-get update
  
  
###2. install svn
    $ sudo apt-get install subversion
  
  
###3. install necessary package for mjpg-streamer
    $ sudo apt-get install imagemagick libjpeg8-dev
  
  
###4. download mjpg-streamer server
    $ svn co https://svn.code.sf.net/p/mjpg-streamer/code/mjpg-streamer
  
  
###5. install it
    $ cd mjpg-streamer/mjpg-streamer; sudo make
if error message in "videodev.h" `$ sudo ln -s /usr/include/linux/videodev2.h /usr/include/linux/videodev.h`
  
  
###6. start streamer
    $ ./streamer.sh start
