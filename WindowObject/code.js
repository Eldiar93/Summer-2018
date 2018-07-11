/*
var doesAgree =
    confirm("Do you agree to be tracked?");
if (doesAgree == true) {
    alert("Thanks for agreeing");

    var name = prompt("Please enter your name", "J. Doe");
    alert("Hello " + name);
}
else {
    location.href = "http://google.com";
}
*/
alert("Hello from script file");

var yearBorn = prompt("Enter year born", "1993");

var today = new Date();
var currYear = today.getFullYear();

var age = currYear - yearUserBorn;

alert("You are" + age, "years old");
