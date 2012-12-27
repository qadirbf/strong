// JavaScript Document




function validate()
{
    //USEr
    var flag = "0";
    var x = document.forms["contact"]["User"].value
    if (x == null || x == "" || x == "Name *") {
        //document.getElementById("tblUser").style.visibility = "visible";
        document.getElementById("User").setAttribute("class", "input_contact_form_val");
        flag = "1";
    }

    else {
        document.getElementById("User").setAttribute("class", "input_contact_form");
    }


    //Phone
    var ph = document.forms["contact"]["Phone"].value
    if (ph == null || ph == "" || ph == "Phone *") {
        //document.getElementById("tblPhone").style.visibility = "visible";
        document.getElementById("Phone").setAttribute("class", "input_contact_form_val");
        flag = "1";
    }

    else {
        document.getElementById("Phone").setAttribute("class", "input_contact_form");
    }


    //Country
    var me = document.forms["contact"]["Message"].value
    if (me == null || me == "" || me == "Message *") {
        document.getElementById("Message").setAttribute("class", "input_message_contact_val");
        flag = "1";
    }
    else { document.getElementById("Message").setAttribute("class", "input_message_contact"); }


    var email = document.forms["contact"]["Email"].value
    if (email == null || email == "" || email == "Email *") {
        document.getElementById("Email").setAttribute("class", "input_contact_form_val");
        //document.getElementById("tblEmail").style.visibility = "hidden";
        flag = "1";
    }
    else {
        document.getElementById("Email").setAttribute("class", "input_contact_form");
        echeck();
    }
    if (flag == "1")
        return false;
    else return true;

}



function validateUser()
{
    var flag="0";
    var x=$("#User").val();//document.forms["contact"]["User"].value
    if (x==null || x=="" || x=="Name *")
    {
        //document.getElementById("tblUser").style.visibility = "visible";
        document.getElementById("User").setAttribute("class", "input_contact_form_val");
        return false;
    }
    else document.getElementById("User").setAttribute("class", "input_contact_form");
}
function validatePhone()
{
    var flag="0";
    var x=$("#Phone").val();//document.forms["contact"]["Phone"].value
    if (x==null || x=="" || x=="Phone *")
    {
        //document.getElementById("tblPhone").style.visibility = "visible";
        document.getElementById("Phone").setAttribute("class", "input_contact_form_val");
        return false;
    }
    else document.getElementById("Phone").setAttribute("class", "input_contact_form");
}
/*function validateCompany()
 {
 var flag="0";
 var x=document.forms["contact"]["Company"].value
 if (x==null || x=="")
 {
 document.getElementById("tblCompany").style.visibility = "visible";
 return false;
 }
 else document.getElementById("tblCompany").style.visibility = "hidden";
 }*/
function validateMessage()
{
    var flag="0";
    var x=$("#Message").val();//document.forms["contact"]["Message"].value
    if (x==null || x=="" || x=="Message *")
    {
        document.getElementById("Message").setAttribute("class", "input_message_contact_val");
        return false;
    }

    else document.getElementById("Message").setAttribute("class", "input_message_contact");
}
function validateEmail()
{
    var email=$("#Email").val();//document.forms["contact"]["Email"].value
    if (email==null || email=="" || email=="Email *")
    {
        document.getElementById("Email").setAttribute("class", "input_contact_form_val");
        //document.getElementById("tblEmail").style.visibility = "hidden";
        return false;
    }
    else
    {
        document.getElementById("Email").setAttribute("class", "input_contact_form");
        echeck();
    }
}

function echeck() {
    var str = $("#Email").val();//document.forms["contact"]["Email"].value;
    var at="@";
    var dot=".";
    var lat=str.indexOf(at);
    var lstr=str.length;
    var ldot=str.indexOf(dot);

    if (str.indexOf(at)==-1){
        document.getElementById("Email").setAttribute("class", "input_contact_form_val");
        return false
    }

    if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
        document.getElementById("Email").setAttribute("class", "input_contact_form_val");
        return false
    }

    if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
        document.getElementById("Email").setAttribute("class", "input_contact_form_val");
        return false
    }

    if (str.indexOf(at,(lat+1))!=-1){
        document.getElementById("Email").setAttribute("class", "input_contact_form_val");
        return false
    }

    if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
        document.getElementById("Email").setAttribute("class", "input_contact_form_val");
        return false
    }

    if (str.indexOf(dot,(lat+2))==-1){
        document.getElementById("Email").setAttribute("class", "input_contact_form_val");
        return false
    }

    if (str.indexOf(" ")!=-1){
        document.getElementById("Email").setAttribute("class", "input_contact_form_val");
        return false
    }
    document.getElementById("Email").setAttribute("class", "input_contact_form");
    return true
}

function CheckNemericValue(e)
{
    var key;
    key = e.which ? e.which : e.keyCode;
    if ((key >= 48 && key <= 57) || key == 8 || key == 9 || key == 46 || key == 45 || key == 43)
    {
        return true;
    }
    else
    {
        return false;
    }
}

function CheckAlphaValue(e)
{
    var key;
    key = e.which ? e.which : e.keyCode;
    if ((key >= 65 && key <= 90) || (key >= 97 && key <= 122) || key == 32 || key == 8 || key == 9 || key == 46)
    {
        return true;
    }
    else
    {
        return false;
    }
}