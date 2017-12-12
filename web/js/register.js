"use strict";
             let x_timer;
          document.querySelector("#user_name").addEventListener("keyup", () => {
              clearTimeout(x_timer);
                let user_name = document.querySelector("#user_name").value;
                x_timer = setTimeout(function () {
                    check_username(user_name);
                    document.querySelector('#user-result').style.display = "block";
                }, 500);
          });
           document.querySelector("#user_email").addEventListener("keyup", () => {
              clearTimeout(x_timer);
                let user_email = document.querySelector("#user_email").value;
                x_timer = setTimeout(function () {
                    check_email(user_email);
                    document.querySelector('#email-result').style.display = "block";
                }, 500);
          });

           function check_username(user_name) {
                $.post('/project/page/view/checkusername', {'user_name': user_name}, function (data) {
                    $("#user-result").html(data);
                 });
           }
           
//            function check_username(user_name) {
//                const data = new FormData();
//                data.append('user_name', user_name);
//                const settings = {
//                    method: 'POST',
//                    //credentials: 'same-origin',
//                    body: data
//                };
//                fetch('http://localhost:8080/project/page/view/checkusername', settings)
//                        .then((response) => {
//                            console.log(response);
//                            response.text();
//                        }).then((text) => {
//                            document.querySelector("[id='user-result']").innerHTML = text;
//                            console.log(text);
//                        });
//           }
//           
         
           
           
           function check_email(user_email) {
                $.post('/project/page/view/checkemail', {'user_email': user_email}, function (data) {
                    $("#email-result").html(data);
                 });
           }
        
      



