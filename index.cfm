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
                    <div class="res1" >
                        <h3>Task 2 - Sort List </h3>
                        <hr>
                        <table border="1" class="table table-bordered">
                            <cfoutput query="ldata">
                                <tr>
                                <td> #locationName# </td>
                                </tr>
                            </cfoutput>
                        </table>
                    </div>
                    <hr>                                             
                    <form name="cftask_5" action="controllers/admin.cfc?method=getParents" method="post">
                        <div class="form-group">
                            <label>Get Parent Ids</label>
                            <input type="text" name="folderId" required  autocomplete="off">
                        </div>
                     
                        <div class="form-btn-control">
                            <input type="submit" class="common-btn" name="submit" value="Submit" />
                        </div>
                    </form>
                    <hr>

                    <form name="cftask_4" action="controllers/admin.cfc?method=getChild" method="post">
                        <div class="form-group">
                            <label>Get child Ids</label>
                            <input type="text" name="folderId" required  autocomplete="off">
                        </div>
                     
                        <div class="form-btn-control">
                            <input type="submit" class="common-btn" name="submit" value="Getchild" />
                        </div>
                    </form>
                    <hr>

                    <form name="cftask_2" action="controllers/admin.cfc?method=getDepth" method="post">
                        <div class="form-group">
                            <label>Get Depth</label>
                            <input type="text" name="folderId" required  autocomplete="off">
                        </div>
                        <div class="form-btn-control">
                            <input type="submit" class="common-btn" name="submit" value="Getdepth" />
                        </div>
                    </form>
                
                </div>
            </div>
        </section>
    </body>
</html>