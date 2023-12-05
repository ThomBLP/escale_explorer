// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

let toogle = document.querySelector(".toogle");
let body = document.querySelector("body");

toogle.addEventListener("click", function() {
  body.classList.toggle("open");
});
