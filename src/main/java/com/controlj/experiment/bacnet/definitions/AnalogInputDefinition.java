/*
 Copyright (c) 2010, Automated Logic Corporation
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
     * Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
     * Neither the name of Automated Logic Corporation nor the
       names of its contributors may be used to endorse or promote products
       derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL AUTOMATED LOGIC CORPORATION BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package com.controlj.experiment.bacnet.definitions;

import com.controlj.green.addonsupport.bacnet.data.BACnetObjectIdentifier;
import com.controlj.green.addonsupport.bacnet.data.BACnetObjectType;
import com.controlj.green.addonsupport.bacnet.data.BACnetReal;
import com.controlj.green.addonsupport.bacnet.data.BACnetString;
import com.controlj.green.addonsupport.bacnet.object.BACnetObjectTypes;
import com.controlj.green.addonsupport.bacnet.object.ObjectType;
import com.controlj.green.addonsupport.bacnet.property.BACnetPropertyIdentifiers;
import com.controlj.green.addonsupport.bacnet.property.BACnetPropertyTypes;
import com.controlj.green.addonsupport.bacnet.property.PropertyDefinition;
import org.jetbrains.annotations.NotNull;

import static com.controlj.green.addonsupport.bacnet.property.BACnetPropertyTypes.createDefinition;

public class AnalogInputDefinition {
    /**<!----- objectIdentifier ----------------------------------------------->
       The ObjectType for this definition, e.g. {@link BACnetObjectTypes#schedule}.
    <!----------------------------------------------------------------------->*/
    @NotNull public static final ObjectType type = BACnetObjectTypes.schedule;

    /**<!----- objectIdentifier ----------------------------------------------->
       Defines the Object_Identifier property for the Schedule Object Type.
    <!----------------------------------------------------------------------->*/
    @NotNull public static final PropertyDefinition<BACnetObjectIdentifier> objectIdentifier =
          createDefinition(BACnetPropertyTypes.objectIdentifier, BACnetPropertyIdentifiers.objectIdentifier);

    /**<!----- objectName ----------------------------------------------------->
       Defines the Object_Name property for the Schedule Object Type.
    <!----------------------------------------------------------------------->*/
    @NotNull public static final PropertyDefinition<BACnetString> objectName =
          createDefinition(BACnetPropertyTypes.string, BACnetPropertyIdentifiers.objectName);

    /**<!----- objectType ----------------------------------------------------->
       Defines the Object_Type property for the Schedule Object Type.
    <!----------------------------------------------------------------------->*/
    @NotNull public static final PropertyDefinition<BACnetObjectType> objectType =
          createDefinition(BACnetPropertyTypes.objectType, BACnetPropertyIdentifiers.objectType);

    /**<!----- presentValue --------------------------------------------------->
       Defines the Present_Value property for the Schedule Object Type.
    <!----------------------------------------------------------------------->*/
    @NotNull public static final PropertyDefinition<BACnetReal> presentValue =
          createDefinition(BACnetPropertyTypes.real, BACnetPropertyIdentifiers.presentValue);

}
