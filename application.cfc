component {
    this.name = "mytestApp";
    this.datasource = "newtech";
    this.sessionManagement  = true;
    this.sessionTimeout = CreateTimeSpan(0, 0, 30, 0);
    this.scriptProtect="all";
    this.mappings["/local"] = getDirectoryFromPath(getCurrentTemplatePath());

    function OnApplicationStart(requestname)
    { 
        this.return=true;
    }      



    function onMissingTemplate(targetPage){
        writeOutput('<center><h1>This Page is not avilable.</h1>
        <p>Please go back:</p></center>');
    }

    function onSessionEnd(sessionScope, applicationScope){
        writeOutput('<center>
                     <h1>Your session expired. Please login again</h1>
                     <a href="index.cfm">Click Here</a>
                     </center>');
    }
}