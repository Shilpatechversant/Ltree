<cfcomponent>
    <cffunction  name="getLocationTree" access="remote" output="false">
        <cfquery name="location_list" result="loc_res">
            SELECT * from coldfusion.tree ORDER BY locationName ASC;
        </cfquery>
        <cfreturn location_list>     
    </cffunction>

    <cffunction name="processTreeNode" output="true">
            <cfargument name="folderId" type="numeric" />
            <cfargument name="folderName" type="string" />
          
            <!--- Check for any nodes that have *this* node as a parent --->
            <cfquery name="LOCAL.qFindChildren" returnType="query">
                select locationid, locationName
                from coldfusion.tree
                where parentLocationId = <cfqueryparam value="#arguments.folderId#" cfsqltype="cf_sql_varchar"/>
                ORDER BY locationName ASC
            </cfquery>
            <li>#arguments.folderName#
                <cfif LOCAL.qFindChildren.recordcount>
                    <!--- We have another list! --->
                    <ul>
                        <!--- We have children, so process these first --->
                        <cfloop query="LOCAL.qFindChildren">
                            <!--- Recursively call function --->
                            <cfset processTreeNode(folderId=LOCAL.qFindChildren.locationid, folderName=LOCAL.qFindChildren.locationName) />
                        </cfloop>
                    </ul>
                </cfif>
            </li>
    </cffunction>
    <cffunction name="nodeSort" output="true">
        <cfargument name="folderId" type="numeric"  default="0"/>
        <cfargument name="folderName" type="string" />
        <cfargument name="nodeList" type="array"/>
        <!--- Define the Variable scope. ---> 
        <cfif arguments.folderId EQ 0>
              <cfset Variables.MyList = ''>
              <cfset structClear(session.arrData)>
        <cfelse>
              <cfset Variables.MyList=#arguments.nodeList#>
             
        </cfif>
        <!--- Check for any nodes that have *this* node as a parent --->
        <cfquery name="LOCAL.qFindChildren" returnType="query">
            select locationid, locationName,parentLocationId 
            from coldfusion.tree
            where parentLocationId = <cfqueryparam value="#arguments.folderId#" cfsqltype="cf_sql_varchar" />
        </cfquery> 
           
            <cfif LOCAL.qFindChildren.recordcount>
               <!--- We have children, so process these first --->
                <cfif LOCAL.qFindChildren.LocationId EQ 10>
                <cfset dataSet= arrayToList(#session.arrData#,",")>
                    <cfdump var=#dataSet# />
                </cfif>
                <cfif NOT structKeyExists(session,'arrData')>
                    <cfset session.arrData = arrayNew(1)/>
                <cfelse>
                <cfset arrayAppend(session.arrData,#LOCAL.qFindChildren.locationName#)>
                </cfif>
                <cfloop query="LOCAL.qFindChildren">
                    <!--- Recursively call function --->
                    <cfset nodeSort(folderId=LOCAL.qFindChildren.locationid, 
                                    folderName=LOCAL.qFindChildren.locationName,
                                    nodeList=#Variables.MyList#) />
                </cfloop>
            <cfelse>           
            </cfif>
    </cffunction>

    <cffunction name="getDepth" output="true" access="remote">
        <cfargument name="folderId" type="numeric" />   
        <cfargument name="level" type="string" default="0"/>                  
            <!--- Check for any nodes that have *this* node as a parent --->
            <cfquery name="LOCAL.qFindChildren" returnType="query">
                select locationid, locationName,parentLocationId
                from coldfusion.tree
                where parentLocationId = <cfqueryparam value="1" cfsqltype="cf_sql_varchar" />
            </cfquery>
               
            <cfif LOCAL.qFindChildren.recordcount>
                <!--- We have another list! --->
                        <cfif LOCAL.qFindChildren.locationid EQ #arguments.folderId#>   
                            <cfdump var=#arguments.level#>                     
                            <cfabort>
                        </cfif> 
                    <!--- We have children, so process these first --->
                    <cfloop query="#LOCAL.qFindChildren#">
                        <cfset arguments.level=arguments.level+1>
                        <!--- Recursively call function --->
                        <cfset getDepth(folderId=LOCAL.qFindChildren.locationid,level=arguments.level) />
                    </cfloop>
            </cfif>
    </cffunction>

    <cffunction name="processPNode" output="true">
        <cfargument name="folderId" type="numeric" />
        <cfargument name="nodelist" type="string" />

        <!--- Check for any nodes that have *this* node as a parent --->
        <cfquery name="LOCAL.NodeFindParents" returnType="query">
            select ParentlocationId, locationName,locationid
            from coldfusion.tree
            where locationid = <cfqueryparam value="#arguments.folderId#" cfsqltype="cf_sql_varchar" />
        </cfquery>
        <cfoutput> #arguments.folderId# </cfoutput>
        <cfif LOCAL.NodeFindParents.recordcount> 
                 
            <cfloop query="LOCAL.NodeFindParents">
                    <cfif LOCAL.NodeFindParents.locationid EQ 0>                         
                      
                    </cfif>                     
                    <!--- Recursively call function --->
                    <cfset processPNode(folderId=LOCAL.NodeFindParents.ParentLocationId) />
            </cfloop>
        </cfif>
    </cffunction>

    <cffunction name="getParents" output="true" access="remote">
        <cfargument name="folderId" type="string"/>
            <!--- Check for any nodes that have *this* node as a parent --->
            <cfquery name="LOCAL.qFindParents" returnType="query">
                select ParentlocationId, locationName,locationid
                from coldfusion.tree
                where locationid = <cfqueryparam value="#arguments.folderId#" cfsqltype="cf_sql_varchar" />
            </cfquery>  
            <h3>parent list </h3>

            <cfif LOCAL.qFindParents.recordcount>
                    <!--- We have another list! --->
                    <ul>
                        <!--- We have children, so process these first --->
                        <cfloop query="#LOCAL.qFindParents#">
                            
                            <!--- Recursively call function --->
                            <cfset processPNode(folderId=LOCAL.qFindParents.parentLocationId) />
                        </cfloop>                     
                        
                    </ul>
            </cfif>
    </cffunction>

    <cffunction name="getChild" output="true" access="remote">
        <cfargument name="folderId" type="string"/>
            <!--- Check for any nodes that have *this* node as a parent --->
            <cfquery name="LOCAL.qFParents" returnType="query">
                select ParentlocationId, locationName,locationid
                from coldfusion.tree
                where parentLocationId = <cfqueryparam value="#arguments.folderId#" cfsqltype="cf_sql_varchar" />
            </cfquery>  
                <cfif LOCAL.qFParents.recordcount>
                    <!--- We have another list! --->
                        <cfif LOCAL.qFParents.locationid EQ 0>                         
                             <cfabort>
                           </cfif> 
                     <!--- We have children, so process these first --->
                        <cfloop query="LOCAL.qFParents">
                            <!--- Recursively call function --->
                            <cfoutput>#LOCAL.qFParents.locationid# </cfoutput><br>
                            <cfset getChild(folderId=LOCAL.qFParents.locationid) />
                        </cfloop>
                </cfif>       
    </cffunction>
</cfcomponent>