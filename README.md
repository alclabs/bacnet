bacnet 2.8.0
========

The bacnet Add-On demonstrates some of the capabilities of the Add-On bacnet API. It demonstrates basic
BACnet discovery and shows how to read some properties.

This tree is implemented using a [dynatree](http://dynatree.googlecode.com/) jQuery based tree.

This addon uses the addon-gradle-2.0.2.gradle script located on the repo in alcshare.
The gradle.properties in the wrapper directory is now updated to use gradle distribution 7.3.3.  
This version also expects the user to get and put the WebCTRL Addon 1.8.0 in a directory called sdk18 as a peer to this directory.  You can change where the addon libraries are found in the 'build.gradle' file.  


Try it out
----------

Deploy the add-on by executing 'gradlew deploy' and starting (if necessary) the server.

Browse to `http://yourserver/bacnet`. This should present a login page. Log in with any valid operator and password.

After the tree appears at the top, expand levels in the tree to discover lower level items. Clicking on a network
will provide a way on the bottom pane to manually add a device on that network.  This sample currently only
supports analog input and schedule objects.

Important Lessons
-----------------

All of the BACnet discovery work is done in `DiscoveryServlet`. This shows the use of both `NetworkDiscoverer` and
`DeviceDiscoverer`. The JSPs analoginput.jsp and schedule.jsp demonstrate reading property values.
