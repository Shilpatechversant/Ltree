<html>
    <head>
        <link rel="stylesheet" href="css/style.css">
        <title>Task Tree</title>
    </head>
    <body>
        <section>
            <div class="main_container">
                <div class="forms card">
                    <h3>Task 1 - Tree Structure</h3>
                    <hr>
                    <cfset data=createObject("component","controllers.admin")>
                    <cfset ldata=data.getLocationTree()> 
                        <ul class="tree">                     
                            <cfset data.processTreeNode(folderId=1, folderName="Kerala") />
                        </ul> 
                    <hr>
                    <form name="cftask_3" action=" " method="post">
                        <div class="form-btn-control">
                            <input type="submit" class="btn btn-lg btn-success" name="Sort" value="Sort" />
                        </div>
                    </form>
                    <hr>
                    <cfif structKeyExists(form, "Sort")>
                       <ch3>Sort List</h3>
                       <cfset sortList=['']>
                       <cfset structClear(session)>
                       <cfinvoke component="controllers.admin" method="lsort" returnvariable="sortList" pid="1"> 
                           <cfset sortResSet= arrayToList(#sortList#,",")>
                           <h4><cfdump var=#sortResSet#></h4>
                     </cfif>
                     <hr>
                    <form name="cftask_5" action=" " method="post">
                        <div class="form-group">
                            <label>Get Parent Ids</label>
                            <input type="text" name="folderId" required  autocomplete="off">
                        </div>
                     
                        <div class="form-btn-control">
                            <input type="submit" class="common-btn" name="submit" value="Submit" />
                        </div>
                    </form>
                    <hr>
                    <cfif structKeyExists(form, "Submit")>
                       <ch3>Parent List</h3>
                       <cfset lid=#form.folderId#>
                       <cfset parentList=['']>
                       <cfset structClear(session)>
                       <cfinvoke component="controllers.admin" method="getParents" returnvariable="parentList" folderId="#form.folderId#"> 
                           <cfset resSet= arrayToList(#parentList#,",")>
                           <h3> <cfdump var=#resSet#></h3>
                     </cfif>
                     <hr>
                     
                    <form name="cftask_4" action=" " method="post">
                        <div class="form-group">
                            <label>Get child Ids</label>
                            <input type="text" name="pid" required  autocomplete="off">
                        </div>
                     
                        <div class="form-btn-control">
                            <input type="submit" class="common-btn" name="Getchild" value="Getchild" />
                        </div>
                    </form>
                    <hr>
                    <cfif structKeyExists(form, "Getchild")>
                       <h3>Child List</h3>
                       <cfset lid=#form.pid#>
                       <cfset childList=['']>
                       <cfset structClear(session)>
                       <cfinvoke component="controllers.admin" method="getChild" returnvariable="childList" pid="#form.pid#"> 
                           <cfset childResSet= arrayToList(#childList#,",")>
                           <h3><cfdump var=#childResSet#></h3>
                     </cfif>
              
                    <form name="cftask_2" action=" " method="post">
                        <div class="form-group">
                            <label>Get Depth</label>
                            <input type="text" name="check_id" required  autocomplete="off">
                        </div>
                        <div class="form-btn-control">
                            <input type="submit" class="common-btn" name="Getdepth" value="Getdepth" />
                        </div>
                    </form>

                    <cfif structKeyExists(form, "Getdepth")>
                       <h3>Level Of the Node</h3>
                       <cfset cid=#check_id#>
                       <cfset levelList=''>
                       <cfset structClear(session)>
                       <cfinvoke component="controllers.admin" method="getDepth" returnvariable="levelList" pid="#form.check_id#"> 
                         <h3><cfdump var=#levelList#></h3>
                     </cfif>
                </div>
            </div>
        </section>
    </body>
</html>