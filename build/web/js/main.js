'use strict';
 const modal = document.querySelector("#myModal");
 const classname = document.getElementsByClassName("image");
 const modalImg = document.querySelector("#img01");
 Array.from(classname).forEach((element) => {
      element.addEventListener('click', ()=>{
          modal.style.display = "block";
          modalImg.src = element.src;
          console.log(element.src);
      });
    });

 const span = document.querySelector("#close");

 span.addEventListener("click", ()=>{
     modal.style.display = "none";
 });