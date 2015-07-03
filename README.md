# Appium server docker image
Repository for automated builds of appium server container.

## What is Appium?
Appium is an open source, cross-platform test automation tool for native, hybrid and mobile web apps, tested on simulators (iOS, FirefoxOS), emulators (Android), and real devices (iOS, Android, FirefoxOS)
See the Appium [site](http://appium.io/) for documation on usage within your test code.

## Include software
- Openjdk-7
- Android SDK
- NodeJS
- Appium 1.3.7

## How to use this image
### To run one appium server
Run container with usb privileges to access the phisical devices.
```
$ docker run -d --privileged -v /dev/bus/usb:/dev/bus/usb  -p 4723:4723 <container name>
```

### To run multiple appium servers
Start 2 appium servers with diferents configurations. [Check appium Doc.](https://github.com/appium/appium/blob/master/docs/en/appium-setup/parallel_tests.md)

```
$ docker run -d --privileged -v /dev/bus/usb:/dev/bus/usb -p 4723:4723 -e appium_args="-U 123 -p 4724 -bp 4853 --chromedriver-port 9603 --selendroid-port 8093 --address localhost --session-override --nodeconfig <path to config>" rocketboy/docker-appium-node-android

$ docker run -d --privileged -v /dev/bus/usb:/dev/bus/usb -p 4724:4724 -e appium_args="-U 124 -p 4724 -bp 4854 --chromedriver-port 9604 --selendroid-port 8094 --address localhost --session-override --nodeconfig <path to config>" rocketboy/docker-appium-node-android

```
Used appium server arguments. For all server arguments [Check appium Doc](http://appium.io/slate/en/master/#appium-server-arguments)
- '--nodeconfig': Configuration JSON file to register appium with selenium grid
- '-U', '--uidid': Unique device identifier of the connected physical device
- '-p', '--port': Appium port listen on (default: 4723)
- '-bp', '--bootstrap-port': Port to use on device to talk to Appium (default: 4724)
- '--chromedriver-port': Port upon which ChromeDriver will run (default: 9515)
- '--selendroid-port': Local port used for communication with Selendroid (default: 8080)
- '-a', '--address': IP Address to listen on (default: 0.0.0.0)
- '--session-override': Enables session override (clobbering) (default: false)

