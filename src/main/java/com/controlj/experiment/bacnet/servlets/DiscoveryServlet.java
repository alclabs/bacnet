/*
 * Copyright (c) 2010 Automated Logic Corporation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.controlj.experiment.bacnet.servlets;

import com.controlj.green.addonsupport.access.LocationType;
import com.controlj.green.addonsupport.bacnet.BACnet;
import com.controlj.green.addonsupport.bacnet.BACnetAccess;
import com.controlj.green.addonsupport.bacnet.BACnetConnection;
import com.controlj.green.addonsupport.bacnet.BACnetDevice;
import com.controlj.green.addonsupport.bacnet.data.BACnetObjectIdentifier;
import com.controlj.green.addonsupport.bacnet.data.BACnetString;
import com.controlj.green.addonsupport.bacnet.discovery.DeviceDiscoverer;
import com.controlj.green.addonsupport.bacnet.discovery.NetworkDiscoverer;
import com.controlj.green.addonsupport.bacnet.object.BACnetObjectTypes;
import com.controlj.green.addonsupport.bacnet.object.ObjectType;
import com.controlj.green.addonsupport.bacnet.object.ScheduleDefinition;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeUnit;


public class DiscoveryServlet extends HttpServlet {
    static private HashMap<ObjectType, String> supportedObjectTypes = new HashMap<ObjectType, String>();
    static {
        supportedObjectTypes.put(BACnetObjectTypes.schedule, "schedule.jsp");
        supportedObjectTypes.put(BACnetObjectTypes.analogInput, "analoginput.jsp");
    }

    /*
    This is servicing the ajax requests from the index.html page to build up the tree.
    The results are transferred as JSON objects.  An id and devid parameter are used to pass
    information back to get the next level of the tree.  This tree will only display objects
    that are in the suportedObjectTypes map.
     */

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        final PrintWriter writer = resp.getWriter();
        final String id = req.getParameter("id");
        final String type = req.getParameter("type");
        final JSONArray arrayData = new JSONArray();


        try {
            if (type == null) {
                // Hard Coded root
                JSONObject root = new JSONObject();
                root.put("title", "Networks");
                root.put("childtype", "networks");
                root.put("isLazy", true);
                root.put("icon", getIconForType(LocationType.System));
                arrayData.put(root);
            } else
            {
                // not root, need to get access to BACnet
                BACnetConnection conn = BACnet.getBACnet().getDefaultConnection();
                BACnetAccess bacnet = conn.getAccess();
                                
                if (type!= null && type.equals("networks") ) {   // handle network discovery

                    NetworkDiscoverer networkDiscoverer = bacnet.createNetworkDiscoverer();
                    List<Integer> addresses = networkDiscoverer.search(5, TimeUnit.SECONDS);
                    addresses.add(0);

                    Collections.sort(addresses);
                    for (Integer address : addresses) {
                        JSONObject next = new JSONObject();
                        next.put("title", address == 0 ? "local" : Integer.toString(address));
                        next.put("id", address);
                        next.put("childtype", "devices");
                        next.put("icon", getIconForType(LocationType.Network));
                        next.put("isLazy", true);
                        next.put("renderpage", "network.jsp");
                        arrayData.put(next);
                    }
                } else if (type!=null && type.equals("devices") && id!=null) {
                    DeviceDiscoverer deviceDiscoverer = bacnet.createDeviceDiscoverer();
                    int netNum = Integer.parseInt(id);

                    List<BACnetDevice> devices = deviceDiscoverer.search(netNum, 5, TimeUnit.SECONDS);

                    for (BACnetDevice device : devices) {
                        JSONObject next = new JSONObject();

                        next.put("title", Integer.toString(device.getDeviceIdentifier().getInstance()));
                        next.put("id", device.getDeviceIdentifier().getInstance());
                        next.put("childtype","objects");
                        next.put("icon", getIconForType(LocationType.Device));
                        next.put("isLazy", true);
                        arrayData.put(next);
                    }
                }  else if (type!=null && type.equals("objects") && id!=null) {
                    int devId = Integer.parseInt(id);
                    BACnetDevice device = bacnet.lookupDevice(devId).get();
                    List<BACnetObjectIdentifier> objectIDs = device.readObjectIdentifiers().get();

                    for (BACnetObjectIdentifier objectID : objectIDs) {
                        try {
                            if (supportedObjectTypes.containsKey(objectID.getType())) {

                                BACnetString name = device.readProperty(objectID, ScheduleDefinition.objectName).get();

                                JSONObject next = new JSONObject();
                                next.put("title", name.getValue() + " - " + Integer.toString(objectID.getInstance()));
                                next.put("devid", devId);
                                next.put("id", objectID.getObjectId());
                                next.put("icon", getIconForType(LocationType.Microblock));
                                next.put("renderpage", supportedObjectTypes.get(objectID.getType()));
                                next.put("isLazy", false);
                                arrayData.put(next);
                            }
                        } catch (IllegalArgumentException e) { } // was a custom type that I can't handle, ignore
                    }
                }
            }

            arrayData.write(writer);

        } catch (Exception e) {
            // since this servlet is being accessed via XHR and a user won't see it, this seems the best
            // way to communicate (and log) errors.
            e.printStackTrace();
        }
        

    }


    private String getIconForType(LocationType type) {
        String urlBase = "../../../_common/lvl5/skin/graphics/type/";
        String image;

        switch (type) {
            case System:
                image = "system.gif";
                break;

            case Area:
                image = "area.gif";
                break;

            case Site:
                image = "site.gif";
                break;

            case Network:
                image = "network.gif";
                break;

            case Device:
                image = "hardware.gif";
                break;

            case Driver:
                image = "dir.gif";
                break;

            case Equipment:
                image = "equipment.gif";
                break;

            case Microblock:
                image = "io_point.gif";
                break;

            case MicroblockComponent:
                image = "io_point.gif";
                break;

            default:
                image = "unknown.gif";
                break;
        }

        return urlBase + image;
    }
}