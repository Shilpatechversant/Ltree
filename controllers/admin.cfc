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
        <cfif arguments.folderId EQ 10>
                <cfset dataSet= arrayToList(#session.arrData#,",")>
                <cfdump var=#dataSet# />
        </cfif>
        <!--- Check for any nodes that have *this* node as a parent --->
        <cfquery name="LOCAL.qFindChildren" returnType="query">
            select locationid, locationName,parentLocationId 
            from coldfusion.tree
            where parentLocationId = <cfqueryparam value="#arguments.folderId#" cfsqltype="cf_sql_varchar" />
        </cfquery> 
           
            <cfif LOCAL.qFindChildren.recordcount>
               <!--- We have children, so process these first --->
              
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
    
    <cffunction name="getResult" output="true" access="remote">
        <cfargument name="res" type="array"/>
        <cfset res1=#arguments.res#>
        <cfreturn res1/>
         <cfabort>
    </cffunction>

    <cffunction name="getParents" output="true" access="remote"  >
        <cfargument name="folderId" type="string"/>
            <!--- Check for any nodes that have *this* node as a parent --->
            <cfquery name="LOCAL.qFindParents" returnType="query">
                select ParentlocationId, locationName,locationid
                from coldfusion.tree
                where locationid = <cfqueryparam value="#arguments.folderId#" cfsqltype="cf_sql_varchar" />
            </cfquery>                   
            <cfset local.dataSet=structNew()>
            <cfif LOCAL.qFindParents.recordcount>
                <cfloop query="#LOCAL.qFindParents#">
                   <cfif #LOCAL.qFindParents.parentLocationId# EQ 0> 
                        <cfset local.dataSet= #session.arr1#>
                        <cfset session.res = #session.arr1#/>
                    </cfif>  
                    <cfif NOT structKeyExists(session,'arr1')>
                        <cfset session.arr1 = arrayNew(1)/>
                        <cfset arrayAppend(session.arr1,#LOCAL.qFindParents.parentLocationId#)>
                    <cfelse>
                        <cfset arrayAppend(session.arr1,#LOCAL.qFindParents.parentLocationId#)>
                    </cfif>
                    <!--- Recursively call function --->
                    <cfset getParents(folderId=LOCAL.qFindParents.parentLocationId) />
                </cfloop>   
                <cfif structKeyExists(session,'res') >
                    <cfreturn session.arr1/>
                    <cfabort>
                </cfif>
            </cfif>
    </cffunction>

    <cffunction name="getChild" output="true" access="remote">
        <cfargument name="pid" type="string"/>
            <!--- Check for any nodes that have *this* node as a parent --->
            <cfquery name="LOCAL.qFParents" returnType="query">
                select ParentlocationId, locationName,locationid
                from coldfusion.tree
                where parentLocationId = <cfqueryparam value="#arguments.pid#" cfsqltype="cf_sql_varchar" />
            </cfquery>  
                <cfif LOCAL.qFParents.recordcount>
                    <!--- We have another list! --->
                        <cfif LOCAL.qFParents.locationid EQ 0>                         
                             <cfabort>
                           </cfif> 
                     <!--- We have children, so process these first --->
                        <cfloop query="LOCAL.qFParents">
                            <cfif NOT structKeyExists(session,'arr1')>
                                <cfset session.arr1 = arrayNew(1)/>
                                <cfset arrayAppend(session.arr1,#LOCAL.qFParents.locationid#)>
                            <cfelse>
                                <cfset arrayAppend(session.arr1,#LOCAL.qFParents.locationid#)>
                            </cfif>
                            <!--- Recursively call function --->
                            <cfset getChild(pid=LOCAL.qFParents.locationid) />
                        </cfloop>
                    
                </cfif> 
                <cfif structKeyExists(session,'arr1') >
                    <cfreturn session.arr1/>
                    <cfabort>
                </cfif>      
    </cffunction>

        <cffunction name="lsort" output="true" access="remote">
        <cfargument name="pid" type="string"/>
            <!--- Check for any nodes that have *this* node as a parent --->
            <cfquery name="LOCAL.qFParents" returnType="query">
                select ParentlocationId, locationName,locationid
                from coldfusion.tree
                where parentLocationId = <cfqueryparam value="#arguments.pid#" cfsqltype="cf_sql_varchar" />
                ORDER BY locationName ASC
            </cfquery>  
                <cfif LOCAL.qFParents.recordcount>
                    <!--- We have another list! --->
                        <cfif LOCAL.qFParents.locationid EQ 0>                         
                             <cfabort>
                           </cfif> 
                     <!--- We have children, so process these first --->
                        <cfloop query="LOCAL.qFParents">
                            <cfif NOT structKeyExists(session,'lsort')>
                                <cfset session.lsort = arrayNew(1)/>
                                <cfset arrayAppend(session.lsort,"Kerala")>
                                <cfset arrayAppend(session.lsort,#LOCAL.qFParents.locationName#)>
                            <cfelse>
                                <cfset arrayAppend(session.lsort,#LOCAL.qFParents.locationName#)>
                            </cfif>
                            <!--- Recursively call function --->
                            <cfset lsort(pid=LOCAL.qFParents.locationid) />
                        </cfloop>
                    
                </cfif> 
                <cfif structKeyExists(session,'lsort') >
                    <cfreturn session.lsort/>
                    <cfabort>
                </cfif>      
    </cffunction>

</cfcomponent>