function validateRegisterForm() { 

    let fname = document.forms["registerForm"]["fullName"].value;
    var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;  

    if (fname == "") {
      alert("Fullname must be filled out");
      event.preventDefault();
      return false;
    }

    let email = document.forms["registerForm"]["emailId"].value;    
    if (email == "") {
      alert("Email must be filled out");
      event.preventDefault();
      return false;
    }
    if (!(email.match(mailformat))) {
        alert("Email is not in correct format");
        event.preventDefault();
        return false;
    }

    let username = document.forms["registerForm"]["userName"].value;
    if (username == "") {
      alert("Username must be filled out");
      event.preventDefault();
      return false;
    }

    let password = document.forms["registerForm"]["passWord"].value;
    if (password == "") {
      alert("password must be filled out");
      event.preventDefault();
      return false;
    }

    let cpassword = document.forms["registerForm"]["confirmPassWord"].value;
    if (cpassword == "") {
      alert("Confirm password must be filled out");
      event.preventDefault();
      return false;
    }

    if (cpassword == password) {
        return true;  
    }  
    else{  
        alert("password and confirm password must be same!"); 
        event.preventDefault(); 
        return false;  
    }  
    return true;  
    
  }

  function validateContactForm()
  {
 
    var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;  
    let title = document.forms["contactform"]["title"].value;
    if (title == "") {
      alert("title must be filled out");
      event.preventDefault();
      return false;
    }

    let email = document.forms["contactform"]["email"].value;    
    if (email == "") {
      alert("Email must be filled out");
      event.preventDefault();
      return false;
    }
    if (!(email.match(mailformat))) {
        alert("Email is not in correct format");
        event.preventDefault();
        return false;
    }

    let fname = document.forms["contactform"]["fname"].value;
    if (fname == "") {
      alert("FirstName must be filled out");
      event.preventDefault();
      return false;
    }
    let lname = document.forms["contactform"]["lname"].value;
    if (lname == "") {
      alert("LastName must be filled out");
      event.preventDefault();
      return false;
    }

    let gender = document.forms["contactform"]["gender"].value;
    if (gender == "") {
      alert("Gender must be filled out");
      event.preventDefault();
      return false;
    }
    let dob = document.forms["contactform"]["dob"].value;
    if (dob == "") {
      alert("Date Of Birth must be filled out");
      event.preventDefault();
      return false;
    }
    
    let address = document.forms["contactform"]["address"].value;
    if (address == "") {
      alert("Address must be filled out");
      event.preventDefault();
      return false;
    }
    let street = document.forms["contactform"]["street"].value;
    if (street == "") {
      alert("Street must be filled out");
      event.preventDefault();
      return false;
    }
    let phone = document.forms["contactform"]["phone"].value;
    if (phone == "") {
      alert("Phone must be filled out");
      event.preventDefault();
      return false;
    }
    function printTable(divName) {
      var printContents = document.getElementById(divName).innerHTML;
      var originalContents = document.body.innerHTML;   
      document.body.innerHTML = printContents;   
      window.print();   
     // document.body.innerHTML = originalContents;
  }
 
  }
